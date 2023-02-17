//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// SPDX-License-Identifier: LGPL-3.0-or-later
// LICENCE_BLOCK_END
//=============================================================================
#include "onesBuiltin.hpp"
#include "Error.hpp"
#include "i18n.hpp"
#include "Ones.hpp"
#include "StringToClass.hpp"
#include "CheckerHelpers.hpp"
//=============================================================================
using namespace Nelson;
//=============================================================================
ArrayOfVector
Nelson::ConstructorsGateway::onesBuiltin(int nLhs, const ArrayOfVector& argIn)
{
    nargoutcheck(nLhs, 0, 1);
    ArrayOfVector retval(1);
    NelsonType cl = NLS_DOUBLE;
    if (argIn.empty()) {
        retval << Ones(cl);
    } else {
        sizeType nRhs = argIn.size();
        bool bCheckClassName = true;
        if (static_cast<int>(nRhs) - 2 >= 0) {
            ArrayOf Arg = argIn[argIn.size() - 2];
            if (Arg.isRowVectorCharacterArray()) {
                std::wstring paramstr = Arg.getContentAsWideString();
                if (paramstr == L"like") {
                    ArrayOf lastArg = argIn[argIn.size() - 1];
                    if (lastArg.isSparse()) {
                        Error(_W("A supported type expected at last argument."));
                    }
                    switch (lastArg.getDataClass()) {
                    case NLS_LOGICAL:
                        cl = NLS_LOGICAL;
                        break;
                    case NLS_INT8:
                        cl = NLS_INT8;
                        break;
                    case NLS_UINT8:
                        cl = NLS_UINT8;
                        break;
                    case NLS_INT16:
                        cl = NLS_INT16;
                        break;
                    case NLS_UINT16:
                        cl = NLS_UINT16;
                        break;
                    case NLS_INT32:
                        cl = NLS_INT32;
                        break;
                    case NLS_UINT32:
                        cl = NLS_UINT32;
                        break;
                    case NLS_INT64:
                        cl = NLS_INT64;
                        break;
                    case NLS_UINT64:
                        cl = NLS_UINT64;
                        break;
                    case NLS_DOUBLE:
                        cl = NLS_DOUBLE;
                        break;
                    case NLS_SINGLE:
                        cl = NLS_SINGLE;
                        break;
                    case NLS_DCOMPLEX:
                        cl = NLS_DCOMPLEX;
                        break;
                    case NLS_SCOMPLEX:
                        cl = NLS_SCOMPLEX;
                        break;
                    default:
                        Error(_W("A supported type expected at last argument."));
                        break;
                    }
                    nRhs = nRhs - 2;
                    bCheckClassName = false;
                } else {
                    Error(_W("\'like\' expected at n - 2 argument."));
                }
            }
        }
        ArrayOf lastArg = argIn[argIn.size() - 1];
        if (lastArg.isRowVectorCharacterArray() && bCheckClassName) {
            std::wstring paramstr = lastArg.getContentAsWideString();
            cl = StringToClass(paramstr);
            nRhs--;
            if (cl < NLS_LOGICAL || cl > NLS_DOUBLE) {
                Error(_W("A supported type expected at last argument."));
            }
        }
        if (nRhs == 0) {
            retval << Ones(cl);
            return retval;
        }
        Dimensions dims;
        if (nRhs == 1) {
            if (argIn[0].isNumeric() && !argIn[0].isSparse()) {
                if (argIn[0].isRowVector()) {
                    if (argIn[0].isEmpty()) {
                        Error(ERROR_WRONG_ARGUMENT_1_SIZE_ROW_VECTOR_EXPECTED);
                    }
                    if (argIn[0].getElementCount() < Nelson::maxDims) {
                        ArrayOf dimVector = argIn[0];
                        dimVector.promoteType(NLS_DOUBLE);
                        auto* ptrValues = (double*)dimVector.getDataPointer();
                        ompIndexType elementCount = argIn[0].getElementCount();
                        for (ompIndexType k = 0; k < elementCount; k++) {
                            if (ptrValues[k] > 0) {
                                dims[k] = static_cast<indexType>(ptrValues[k]);
                            } else {
                                dims[k] = 0;
                            }
                        }
                        if (dims.getLength() == 1) {
                            dims[1] = dims[0];
                        }
                    } else {
                        Error(_W("Too many dimensions! Current limit is") + L" "
                            + std::to_wstring(Nelson::maxDims) + L".");
                    }
                } else {
                    Error(ERROR_WRONG_ARGUMENT_1_SIZE_ROW_VECTOR_EXPECTED);
                }
            } else {
                Error(ERROR_WRONG_ARGUMENT_1_TYPE_NUMERIC_EXPECTED);
            }
        } else {
            for (sizeType k = 0; k < nRhs; k++) {
                ArrayOf param = argIn[k];
                indexType idx = param.getContentAsScalarIndex();
                dims[k] = idx;
            }
            if (dims.getLength() == 1) {
                dims[1] = dims[0];
            }
        }
        retval << Ones(dims, cl);
    }
    return retval;
}
//=============================================================================
