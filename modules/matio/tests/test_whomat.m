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
assert_isequal(nargin('whomat'), 1);
assert_isequal(nargout('whomat'), 1);
%=============================================================================
mat_dir = [fileparts(nfilename('fullpathext'),'path'), '/mat/'];
%=============================================================================
c = whomat([mat_dir, 'test_cell_nest_7.4_GLNX86.mat']);
REF = {'testcellnest'};
assert_isequal(c, REF);
%=============================================================================
A = ones(3, 4);
B = 'Nelson';
C = sparse(true);
D = sparse(3i);
savemat([tempdir(), 'test_whomat-v7.3.mat'], 'A', 'B', 'C', 'D', '-v7.3')
c = whomat([tempdir(), 'test_whomat-v7.3.mat']);
REF = {'A'; 'B'; 'C'; 'D'}
assert_isequal(c, REF);
%=============================================================================
c = whomat([tempdir(), 'test_whomat-v7.3.mat'], 'A', 'C');
REF = {'A'; 'C'}
assert_isequal(c, REF);
%=============================================================================
whomat([tempdir(), 'test_whomat-v7.3.mat'], 'A', 'C');
whomat([tempdir(), 'test_whomat-v7.3.mat']);
%=============================================================================