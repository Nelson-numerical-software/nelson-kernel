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
#include <string>
#include <vector>
#include <tuple>
#include "nlsModules_manager_exports.h"
//=============================================================================
namespace Nelson {
//=============================================================================
NLSMODULES_MANAGER_IMPEXP bool
ReadUserModules(
    std::vector<std::tuple<std::wstring, std::wstring, bool>>& userModules, bool reverse = false);
//=============================================================================
}
//=============================================================================