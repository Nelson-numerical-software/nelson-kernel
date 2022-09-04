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
#include <vector>
#include "ArrayOf.hpp"
#include "nlsElementary_functions_exports.h"
//=============================================================================
namespace Nelson {
//=============================================================================
NLSELEMENTARY_FUNCTIONS_IMPEXP ArrayOf
Permute(
    const ArrayOf& arrayIn, const std::vector<indexType>& permutationVector, bool& needToOverload);
//=============================================================================
}
//=============================================================================
