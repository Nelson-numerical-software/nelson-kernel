//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// SPDX-License-Identifier: LGPL-3.0-or-later
// LICENCE_BLOCK_END
//=============================================================================
#pragma once
//=============================================================================
#include "nlsIpc_exports.h"
//=============================================================================
namespace Nelson {
//=============================================================================
NLSIPC_IMPEXP
bool
openIpcReceiverIsReadyMutex(int pid);
//=============================================================================
NLSIPC_IMPEXP
bool
closeIpcReceiverIsReadyMutex(int pid);
//=============================================================================
NLSIPC_IMPEXP
bool
haveIpcReceiverIsReadyMutex(int pid);
//=============================================================================
}
//=============================================================================