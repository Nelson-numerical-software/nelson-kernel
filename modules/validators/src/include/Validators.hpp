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
#include "nlsValidators_exports.h"
#include "ArrayOf.hpp"
//=============================================================================
namespace Nelson {
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeLogical(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeLogicalScalar(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeFinite(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeScalarOrEmpty(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeValidVariableName(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeTextScalar(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeFolder(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeVector(const ArrayOfVector& args, bool allowsAllEmpties, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeFloat(const ArrayOfVector& args, int argPosition);
//=============================================================================
NLSVALIDATORS_IMPEXP void
mustBeNumeric(const ArrayOfVector& args, int argPosition);
//=============================================================================
}
//=============================================================================