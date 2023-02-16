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
#include "ArrayOf.hpp"
#include "nlsElementary_functions_exports.h"
//=============================================================================
namespace Nelson {
NLSELEMENTARY_FUNCTIONS_IMPEXP ArrayOf
DecimalToBase(ArrayOf& A, ArrayOf& Base, ArrayOf& Ndigits, bool& needToOverload);
//=============================================================================
} // namespace Nelson
//=============================================================================
