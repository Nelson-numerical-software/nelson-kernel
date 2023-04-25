//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// SPDX-License-Identifier: LGPL-3.0-or-later
// LICENCE_BLOCK_END
//=============================================================================
#include <boost/asio/ip/host_name.hpp>
#include "GetHostname.hpp"
#include "characters_encoding.hpp"
//=============================================================================
namespace Nelson {
//=============================================================================
std::wstring
GetHostname()
{
    return utf8_to_wstring(boost::asio::ip::host_name());
}
//=============================================================================
}
//=============================================================================