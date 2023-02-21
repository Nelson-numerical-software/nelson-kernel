//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// SPDX-License-Identifier: LGPL-3.0-or-later
// LICENCE_BLOCK_END
//=============================================================================
#include "GOArrayOfProperty.hpp"
//=============================================================================
namespace Nelson {
//=============================================================================
ArrayOf
GOArrayOfProperty::get()
{
    return _data;
}
//=============================================================================
void
GOArrayOfProperty::set(ArrayOf m)
{
    GOGenericProperty::set(m);
    _data = m;
}
//=============================================================================
ArrayOf
GOArrayOfProperty::data()
{
    return _data;
}
//=============================================================================
void
GOArrayOfProperty::data(const ArrayOf& m)
{
    _data = m;
}
//=============================================================================
std::wstring
GOArrayOfProperty::toWideString()
{
    return L"[" + _data.getDimensions().toWideString() + L"]";
}
//=============================================================================
}
//=============================================================================