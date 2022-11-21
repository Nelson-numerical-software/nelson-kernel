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
#include "nlsCommons_exports.h"
//=============================================================================
namespace Nelson::UuidHelpers {
//=============================================================================
NLSCOMMONS_IMPEXP void
generateUuid(std::wstring& wstr);
//=============================================================================
NLSCOMMONS_IMPEXP void
generateUuid(std::string& str);
//=============================================================================
}
//=============================================================================