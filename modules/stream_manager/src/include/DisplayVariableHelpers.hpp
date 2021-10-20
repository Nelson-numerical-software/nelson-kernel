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
#include <string>
#include "ArrayOf.hpp"
#include "Interface.hpp"
#include "NelsonConfiguration.hpp"
#include "nlsStream_manager_exports.h"
//=============================================================================
namespace Nelson {
//=============================================================================
#define HORIZONTAL_ELLIPSIS L"\u2026" // L"�"
#define BLANKS_AT_BOL L"    "
#define LENGTH_BLANKS_AT_BOL 4
#define DEFAULT_NOMINAL_WIDTH 10
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP void
DisplayVariableHeader(Interface* io, const ArrayOf& A, const std::wstring& name);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP void
DisplayVariableFooter(Interface* io, const ArrayOf& A, const std::wstring& name);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
completeWithBlanksAtBeginning(const std::wstring& msg, NumericFormatDisplay currentNumericFormat);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
completeWithBlanksAtBeginning(const std::wstring& msg, size_t width);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
summarizeStringArray(const ArrayOf& A, size_t beginingLineLength, size_t termWidth);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
summarizeCellEntry(const ArrayOf& A, size_t beginingLineLength, size_t termWidth,
    NumericFormatDisplay currentNumericFormat);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
lightDescription(const ArrayOf& A, const std::wstring& firstChar, const std::wstring& lastChar);
//=============================================================================
NLSSTREAM_MANAGER_IMPEXP std::wstring
columnsHeader(indexType startCol, indexType endCol);
//=============================================================================
std::wstring
outputDoublePrecisionAsIntegerForm(
    double num, NumericFormatDisplay currentNumericFormat, bool trim = false);
//=============================================================================
std::wstring
outputSinglePrecisionAsIntegerForm(
    single num, NumericFormatDisplay currentNumericFormat, bool trim = false);
//=============================================================================
std::wstring
outputDoublePrecisionFloat(
    double num, NumericFormatDisplay currentNumericFormat, bool forceFormat, bool trim = false);
//=============================================================================
std::wstring
outputDoubleComplexPrecisionFloat(double realPart, double imagPart,
    NumericFormatDisplay currentNumericFormat, bool forceFormat, bool trim = false);
//=============================================================================
std::wstring
outputSinglePrecisionFloat(
    single num, NumericFormatDisplay currentNumericFormat, bool forceFormat, bool trim = false);
//=============================================================================
static std::wstring
outputSingleComplexPrecisionFloat(single realPart, single imagPart,
    NumericFormatDisplay currentNumericFormat, bool forceFormat, bool trim = false);
//=============================================================================
} // namespace Nelson
//=============================================================================
