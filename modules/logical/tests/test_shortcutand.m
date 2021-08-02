%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU Lesser General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% Alternatively, you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 2 of
% the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this program. If not, see <http://www.gnu.org/licenses/>.
% LICENCE_BLOCK_END
%=============================================================================
assert_istrue(shortcutand(true, true));
assert_isfalse(shortcutand(true, false));
assert_isfalse(shortcutand(false, false));
assert_isfalse(shortcutand(false, true));
%=============================================================================
assert_istrue(true && true);
assert_isfalse(true && false);
assert_isfalse(false && false);
assert_isfalse(false && true);
%=============================================================================
A = [true, false, true];
B = [true, true, true];
assert_checkerror('A && B', _('Operand to && operator must be convertible to logical scalar values.'));
%=============================================================================
A = [true, false, true];
B = [true, false, true, true];
assert_checkerror('A && B', _('Operand to && operator must be convertible to logical scalar values.'));
%=============================================================================
A = [true, false, true];
B = [true, false, true, true];
assert_checkerror('B && A', _('Operand to && operator must be convertible to logical scalar values.'));
%=============================================================================
assert_isfalse(ischar({'f'}) && strcmp({'f'}, 'f'));
%=============================================================================