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
#pragma once
//=============================================================================
#include "nlsMex_exports.h"
#include "MxTypes.h"
//=============================================================================
#ifdef __cplusplus
extern "C"
{
#endif
    //=============================================================================
    NLSMEX_IMPEXP
    mxArray*
    mxCreateStructArray(mwSize ndim, const mwSize* dims, int nfields, const char** fieldnames);
    //=============================================================================
    NLSMEX_IMPEXP
    mxArray*
    mxCreateStructMatrix(mwSize m, mwSize n, int nfields, const char** fieldnames);
    //=============================================================================
    NLSMEX_IMPEXP
    bool
    mxIsStruct(const mxArray* pm);
    //=============================================================================
    NLSMEX_IMPEXP
    int
    mxGetNumberOfFields(const mxArray* pm);
    //=============================================================================
    NLSMEX_IMPEXP
    mxArray*
    mxGetFieldByNumber(const mxArray* pm, mwIndex index, int fieldnumber);
    //=============================================================================
    NLSMEX_IMPEXP
    void
    mxSetField(mxArray* pm, mwIndex index, const char* fieldname, mxArray* pvalue);
    //=============================================================================
    NLSMEX_IMPEXP
    void
    mxSetFieldByNumber(mxArray* pm, mwIndex index, int fieldnumber, mxArray* pvalue);
    //=============================================================================
    NLSMEX_IMPEXP
    int
    mxGetFieldNumber(const mxArray* pm, const char* fieldname);
    //=============================================================================
    NLSMEX_IMPEXP
    int
    mxAddField(mxArray* pm, const char* fieldname);
    //=============================================================================
    NLSMEX_IMPEXP
    void
    mxRemoveField(mxArray* pm, int fieldnumber);
    //=============================================================================
    NLSMEX_IMPEXP
    const char*
    mxGetFieldNameByNumber(const mxArray* pm, int fieldnumber);
//=============================================================================
#ifdef __cplusplus
}
#endif
//=============================================================================