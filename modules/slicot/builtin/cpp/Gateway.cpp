//=============================================================================
// LICENCE_BLOCK_BEGIN
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// LICENCE_BLOCK_END
//=============================================================================
// Generated by Nelson Interface Generator 1.0.0
//=============================================================================
#include "NelsonGateway.hpp"
#include "slicot_ab01odBuiltin.hpp"
#include "slicot_ab04mdBuiltin.hpp"
#include "slicot_ab08ndBuiltin.hpp"
#include "slicot_sb01bdBuiltin.hpp"
//=============================================================================
using namespace Nelson;
//=============================================================================
const std::wstring gatewayName = L"slicot";
//=============================================================================
static const nlsGateway gateway[] =
{
    { "slicot_ab01od", Nelson::SlicotGateway::slicot_ab01odBuiltin, 8, 10},
    { "slicot_ab04md", Nelson::SlicotGateway::slicot_ab04mdBuiltin, 5, 7},
    { "slicot_ab08nd", Nelson::SlicotGateway::slicot_ab08ndBuiltin, 11, 9},
    { "slicot_sb01bd", Nelson::SlicotGateway::slicot_sb01bdBuiltin, 10, 7},
};
//=============================================================================
NLSGATEWAYFUNC(gateway)
//=============================================================================
NLSGATEWAYINFO(gateway)
//=============================================================================
NLSGATEWAYREMOVE(gateway)
//=============================================================================
NLSGATEWAYNAME()
//=============================================================================
