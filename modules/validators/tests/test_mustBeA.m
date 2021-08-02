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
% <--ENGLISH IMPOSED-->
%=============================================================================
assert_isequal(nargin('mustBeA'), -2);
assert_isequal(nargout('mustBeA'), 0);
%=============================================================================
A = 3;
mustBeA(A, 'double')
mustBeA(A, {'double'})
mustBeA(A, {'double', 'single'})
mustBeA(A, ["double", "single"])
%=============================================================================
assert_checkerror('mustBeA(A, ''single'')', 'Value must be one of the following types: ''single''.', 'Nelson:validators:mustBeA');
%=============================================================================