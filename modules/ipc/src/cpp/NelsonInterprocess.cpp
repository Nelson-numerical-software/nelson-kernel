//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// Alternatively, you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of
// the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program. If not, see <http://www.gnu.org/licenses/>.
// LICENCE_BLOCK_END
//=============================================================================
#include <boost/archive/binary_oarchive.hpp>
#include <boost/archive/binary_iarchive.hpp>
#include <boost/interprocess/ipc/message_queue.hpp>
#include <boost/thread/thread.hpp>
#include <boost/algorithm/string.hpp>
#include "NelsonInterprocess.hpp"
#include "NelsonPIDs.hpp"
#include "characters_encoding.hpp"
#include "PostCommandDynamicFunction.hpp"
#include "GetNelsonMainEvaluatorDynamicFunction.hpp"
#include "Warning.hpp"
#include "Sleep.hpp"
#include "nlsConfig.h"
#include "DataInterProcessToExchange.hpp"
#include "CompressedStringHelpers.hpp"
#include "StringZLib.hpp"
#include "IpcReadyReceiverNamedMutex.hpp"
//=============================================================================
namespace Nelson {
//=============================================================================
constexpr auto NELSON_COMMAND_INTERPROCESS = "NELSON_COMMAND_INTERPROCESS";
#if (defined(_LP64) || defined(_WIN64))
constexpr auto OFF_MSG_SIZE = sizeof(double) * 16 * 1024;
constexpr auto MAX_MSG_SIZE = sizeof(double) * (4096 * 4096) + OFF_MSG_SIZE;
constexpr auto MAX_NB_MSG = 4;
#else
constexpr auto MAX_MSG_SIZE = sizeof(double) * (1024 * 1024);
constexpr auto MAX_NB_MSG = 2;
#endif
//=============================================================================
static bool receiverLoopRunning = false;
//=============================================================================
static boost::thread* receiver_thread = nullptr;
//=============================================================================
static volatile bool isMessageQueueFails = false;
static volatile bool isMessageQueueReady = false;
static volatile bool loopTerminated = false;
//=============================================================================
static volatile bool isVarAnswer = false;
static volatile bool isVarAnswerAvailable = false;
//=============================================================================
static ArrayOf getVarAnswer;
static volatile bool getVarAnswerAvailable = false;
//=============================================================================
static bool
sendIsVarAnswerToNelsonInterprocessReceiver(int pidDestination, bool isVar);
//=============================================================================
static bool
sendGetVarAnswerToNelsonInterprocessReceiver(int pidDestination, const ArrayOf& data);
//=============================================================================
static std::string
getChannelName(int currentPID)
{
    return std::string(NELSON_COMMAND_INTERPROCESS) + "_" + std::to_string(currentPID);
}
//=============================================================================
static Scope*
getScopeFromName(Evaluator* eval, const std::string& name)
{
    Scope* scope = nullptr;
    if (eval != nullptr) {
        Context* context = eval->getContext();
        if (name == "global") {
            scope = context->getGlobalScope();
        }
        if (name == "base") {
            scope = context->getBaseScope();
        }
        if (name == "caller") {
            scope = context->getCallerScope();
        }
        if (name == "local") {
            scope = context->getCurrentScope();
        }
    }
    return scope;
}
//=============================================================================
static bool
processMessageData(const dataInterProcessToExchange& messageData)
{
    bool res = false;
    if (messageData.commandType == "eval") {
        std::wstring line = utf8_to_wstring(messageData.lineToEvaluate);
        boost::algorithm::replace_all(line, L"'", L"''");
        std::wstring command = L"evalin('base','" + line + L"');";
        res = PostCommandDynamicFunction(command);
    } else if (messageData.commandType == "put") {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        Scope* scope = getScopeFromName(eval, messageData.scope);
        if (scope != nullptr) {
            bool success;
            ArrayOf var
                = CompressedStringToArrayOf(messageData.serializedCompressedVariable, success);
            if (success) {
                res = scope->insertVariable(messageData.variableName, var);
            }
        }
    } else if (messageData.commandType == "isvar") {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        Scope* scope = getScopeFromName(eval, messageData.scope);
        if (scope != nullptr) {
            bool isVar = scope->isVariable(messageData.variableName);
            res = sendIsVarAnswerToNelsonInterprocessReceiver(messageData.pid, isVar);
        }
    } else if (messageData.commandType == "isvar_answer") {
        isVarAnswer = messageData.valueAnswer;
        isVarAnswerAvailable = true;
    } else if (messageData.commandType == "get") {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        Scope* scope = getScopeFromName(eval, messageData.scope);
        if (scope != nullptr) {
            ArrayOf result;
            bool isVar = scope->lookupVariable(messageData.variableName, result);
            res = sendGetVarAnswerToNelsonInterprocessReceiver(messageData.pid, result);
        }
    } else if (messageData.commandType == "get_answer") {
        bool success;
        getVarAnswer = CompressedStringToArrayOf(messageData.serializedCompressedVariable, success);
        getVarAnswerAvailable = true;
        res = true;
    }
    return res;
}
//=============================================================================
static boost::interprocess::message_queue* messageQueue = nullptr;
//=============================================================================
static void
createNelsonInterprocessReceiverThread(int currentPID, bool withEventsLoop)
{
    receiverLoopRunning = true;
    isMessageQueueFails = false;
    try {
        std::string channelName = getChannelName(currentPID);
        messageQueue = new boost::interprocess::message_queue(
            boost::interprocess::open_or_create, channelName.c_str(), MAX_NB_MSG, MAX_MSG_SIZE);
    } catch (std::bad_alloc&) {
        messageQueue = nullptr;
    } catch (boost::interprocess::interprocess_exception&) {
        messageQueue = nullptr;
    }
    if (messageQueue == nullptr) {
        receiverLoopRunning = false;
        isMessageQueueFails = true;
        removeNelsonInterprocessReceiver(currentPID, withEventsLoop);
        return;
    }
    openIpcReceiverIsReadyMutex(currentPID);
    dataInterProcessToExchange msg("");
    isMessageQueueReady = true;
    std::string serialized_compressed_string;
    unsigned int maxMessageSize = messageQueue->get_max_msg_size();
    loopTerminated = false;
    while (receiverLoopRunning) {
        unsigned int priority = 0;
        size_t recvd_size = 0;
        std::stringstream iss;
        if (messageQueue == nullptr) {
            receiverLoopRunning = false;
            return;
        }
        serialized_compressed_string.resize(messageQueue->get_max_msg_size());
        bool readed = false;
        try {
            readed = messageQueue->try_receive(
                &serialized_compressed_string[0], maxMessageSize, recvd_size, priority);
        } catch (...) {
            readed = false;
        }
        if (messageQueue && readed) {
            if (recvd_size != 0) {
                serialized_compressed_string[recvd_size] = 0;
                bool failed = false;
                std::string decompressed_string
                    = decompressString(serialized_compressed_string, failed);
                serialized_compressed_string.clear();
                if (!failed) {
                    iss << decompressed_string;
                    try {
                        boost::archive::binary_iarchive ia(iss);
                        ia >> msg;
                        processMessageData(msg);
                    } catch (boost::archive::archive_exception&) {
                    }
                }
            }
        }
        try {
            boost::this_thread::sleep_for(boost::chrono::milliseconds(uint64(50)));
        } catch (boost::thread_interrupted&) {
            receiverLoopRunning = false;
            isMessageQueueFails = false;
            loopTerminated = true;
            return;
        }
    }
    loopTerminated = true;
}
//=============================================================================
bool
createNelsonInterprocessReceiver(int pid, bool withEventsLoop)
{
    try {
        receiver_thread
            = new boost::thread(createNelsonInterprocessReceiverThread, pid, withEventsLoop);
    } catch (const std::bad_alloc&) {
        receiver_thread = nullptr;
        receiverLoopRunning = false;
        isMessageQueueFails = true;
        isMessageQueueReady = false;
        return false;
    }
    if (receiver_thread) {
        receiver_thread->detach();
    }
    return true;
}
//=============================================================================
static void
terminateNelsonInterprocessReceiverThread()
{
    if (receiver_thread) {
        receiverLoopRunning = false;
        receiver_thread->interrupt();
        receiver_thread = nullptr;
    }
}
//=============================================================================
bool
removeNelsonInterprocessReceiver(int pid, bool withEventsLoop)
{
    waitMessageQueueUntilReady(withEventsLoop);
    terminateNelsonInterprocessReceiverThread();
    bool res = boost::interprocess::message_queue::remove(getChannelName(pid).c_str());
    closeIpcReceiverIsReadyMutex(pid);
    int l = 0;
    if (withEventsLoop) {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        while (!loopTerminated && l < 20) {
            Sleep(eval, .5);
            l++;
        }
    } else {
        while (!loopTerminated && l < 20) {
            try {
                boost::this_thread::sleep(boost::posix_time::milliseconds(500));
            } catch (boost::thread_interrupted&) {
            }
            l++;
        }
    }
    if (messageQueue) {
        delete messageQueue;
        messageQueue = nullptr;
    }
    return res;
}
//=============================================================================
static bool
sendMessage(int pid, const std::string& message)
{
    bool sent = false;
    try {
        boost::interprocess::message_queue messages(
            boost::interprocess::open_only, getChannelName(pid).c_str());
        messages.send(message.data(), message.size(), 0);
        sent = true;
    } catch (boost::interprocess::interprocess_exception&) {
        sent = false;
    }
    return sent;
}
//=============================================================================
bool
sendIsVarAnswerToNelsonInterprocessReceiver(int pidDestination, bool isVar)
{
    dataInterProcessToExchange msg(pidDestination, "isvar_answer", isVar);
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_compressed_string = compressString(oss.str(), failed);
    if (failed) {
        return false;
    }
    return sendMessage(pidDestination, serialized_compressed_string);
}
//=============================================================================
bool
sendGetVarAnswerToNelsonInterprocessReceiver(int pidDestination, const ArrayOf& data)
{
    bool isFullySerialized = false;
    std::string compressedData = ArrayOfToCompressedString(data, isFullySerialized);
    dataInterProcessToExchange msg(pidDestination, "get_answer", compressedData, isFullySerialized);
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_compressed_string = compressString(oss.str(), failed);
    if (failed) {
        return false;
    }
    return sendMessage(pidDestination, serialized_compressed_string);
}
//=============================================================================
bool
sendCommandToNelsonInterprocessReceiver(int pidDestination, const std::wstring& command,
    bool withEventsLoop, std::wstring& errorMessage)
{
    errorMessage.clear();
    if (isMessageQueueFails) {
        errorMessage = _W("Impossible to initialize IPC.");
        return false;
    }
    waitMessageQueueUntilReady(withEventsLoop);
    dataInterProcessToExchange msg(wstring_to_utf8(command));
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_compressed_string = compressString(oss.str(), failed);
    if (failed) {
        return false;
    }
    return sendMessage(pidDestination, serialized_compressed_string);
}
//=============================================================================
bool
sendVariableToNelsonInterprocessReceiver(int pidDestination, const ArrayOf& var,
    const std::wstring& name, const std::wstring& scope, bool withEventsLoop,
    std::wstring& errorMessage)
{
    if (isMessageQueueFails) {
        errorMessage = _W("Impossible to initialize IPC.");
        return false;
    }
    waitMessageQueueUntilReady(withEventsLoop);
    bool isFullySerialized = false;
    std::string compressedData = ArrayOfToCompressedString(var, isFullySerialized);
    dataInterProcessToExchange msg(
        wstring_to_utf8(name), wstring_to_utf8(scope), compressedData, isFullySerialized);
    if (!msg.isFullySerialized()) {
        Warning(WARNING_NOT_FULLY_SERIALIZED, _W("Variable not fully serialized."));
    }
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_string = oss.str();
    std::string serialized_compressed_string = compressString(serialized_string, failed);
    bool bSend = false;
    if (failed) {
        return bSend;
    }
    if (serialized_compressed_string.size() < MAX_MSG_SIZE) {
        bSend = sendMessage(pidDestination, serialized_compressed_string);
    }
    return bSend;
}
//=============================================================================
bool
isVariableFromNelsonInterprocessReceiver(int pidDestination, const std::wstring& name,
    const std::wstring& scope, bool withEventsLoop, std::wstring& errorMessage)
{
    if (isMessageQueueFails) {
        errorMessage = _W("Impossible to initialize IPC.");
        return false;
    }
    waitMessageQueueUntilReady(withEventsLoop);
    dataInterProcessToExchange msg(
        getCurrentPID(), "isvar", wstring_to_utf8(name), wstring_to_utf8(scope));
    if (!msg.isFullySerialized()) {
        Warning(WARNING_NOT_FULLY_SERIALIZED, _W("Variable not fully serialized."));
    }
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_compressed_string = compressString(oss.str(), failed);
    if (failed) {
        errorMessage = _W("Cannot compress data.");
        return false;
    }
    if (serialized_compressed_string.size() >= MAX_MSG_SIZE) {
        errorMessage = _W("Serialized data too big.");
        return false;
    }
    if (!sendMessage(pidDestination, serialized_compressed_string)) {
        errorMessage = _W("Cannot send serialized data.");
        return false;
    }
    int l = 0;
    if (withEventsLoop) {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        while (!isVarAnswerAvailable && l < 20) {
            Sleep(eval, .5);
            l++;
        }
    } else {
        while (!isVarAnswerAvailable && l < 20) {
            try {
                boost::this_thread::sleep(boost::posix_time::milliseconds(500));
            } catch (boost::thread_interrupted&) {
            }
            l++;
        }
    }
    if (l == 20) {
        errorMessage = _W("Impossible to get value (Timeout).");
        return false;
    } else {
        bool isVarExist = isVarAnswer;
        isVarAnswer = false;
        isVarAnswerAvailable = false;
        return isVarExist;
    }
    return false;
}
//=============================================================================
ArrayOf
getVariableFromNelsonInterprocessReceiver(int pidDestination, const std::wstring& name,
    const std::wstring& scope, bool withEventsLoop, std::wstring& errorMessage)
{
    errorMessage.clear();
    if (isMessageQueueFails) {
        errorMessage = _W("Impossible to initialize IPC.");
        return ArrayOf();
    }
    waitMessageQueueUntilReady(withEventsLoop);

    dataInterProcessToExchange msg(
        getCurrentPID(), "get", wstring_to_utf8(name), wstring_to_utf8(scope));
    if (!msg.isFullySerialized()) {
        Warning(WARNING_NOT_FULLY_SERIALIZED, _W("Variable not fully serialized."));
    }
    std::stringstream oss;
    boost::archive::binary_oarchive oa(oss);
    oa << msg;
    bool failed = false;
    std::string serialized_compressed_string = compressString(oss.str(), failed);
    if (failed) {
        errorMessage = _W("Cannot serialize data.");
        return ArrayOf();
    }
    if (serialized_compressed_string.size() >= MAX_MSG_SIZE) {
        errorMessage = _W("Serialized data too big.");
        return ArrayOf();
    }
    if (!sendMessage(pidDestination, serialized_compressed_string)) {
        errorMessage = _W("Cannot send serialized data.");
        return ArrayOf();
    }
    int l = 0;
    if (withEventsLoop) {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        while (!getVarAnswerAvailable && l < 20) {
            Sleep(eval, .5);
            l++;
        }
    } else {
        while (!getVarAnswerAvailable && l < 20) {
            try {
                boost::this_thread::sleep(boost::posix_time::milliseconds(500));
            } catch (boost::thread_interrupted&) {
            }
            l++;
        }
    }
    ArrayOf result;
    if (l == 20) {
        errorMessage = _W("Impossible to get value (Timeout).");
        return ArrayOf();
    } else {
        result = getVarAnswer;
        getVarAnswerAvailable = false;
        getVarAnswer = ArrayOf();
    }
    return result;
}
//=============================================================================
void
waitMessageQueueUntilReady(bool withEventsLoop)
{
    if (withEventsLoop) {
        auto* eval = (Evaluator*)GetNelsonMainEvaluatorDynamicFunction();
        while (!isMessageQueueReady && !isMessageQueueFails) {
            Sleep(eval, .5);
        }
    } else {
        while (!isMessageQueueReady && !isMessageQueueFails) {
            try {
                boost::this_thread::sleep(boost::posix_time::milliseconds(500));
            } catch (boost::thread_interrupted&) {
            }
        }
    }
}
//=============================================================================
}
//=============================================================================