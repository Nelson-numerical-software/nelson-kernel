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
assert_isequal(nargin('ismatfile'), 1);
assert_isequal(nargout('ismatfile'), 1);
%=============================================================================
mat_dir = [fileparts(nfilename('fullpathext'),'path'), '/mat/'];
%=============================================================================
[tf, ver] = ismatfile({[mat_dir, 'test_cell_nest_7.4_GLNX86.mat']});
assert_istrue(tf);
assert_isequal(ver, "-v7");
%=============================================================================
[tf, ver] = ismatfile(string([mat_dir, 'test_cell_nest_7.4_GLNX86.mat']));
assert_istrue(tf);
assert_isequal(ver, "-v7");
%=============================================================================
[tf, ver] = ismatfile([mat_dir, 'test_cell_nest_7.4_GLNX86.mat']);
assert_istrue(tf);
assert_isequal(ver, "-v7");
%=============================================================================
[tf, ver] = ismatfile([mat_dir, 'test_not_exist.mat']);
assert_isfalse(tf);
assert_isequal(ver, string());
%=============================================================================
[tf, ver, header] = ismatfile([mat_dir, 'test_cell_nest_7.4_GLNX86.mat']);
assert_istrue(tf);
assert_isequal(ver, "-v7");
header_ref = "MATLAB 5.0 MAT-file, Platform: GLNX86, Created on: Fri Feb 20 15:26:59 2009";
assert_isequal(header, header_ref);
%=============================================================================
[tf, ver, header] = ismatfile([mat_dir, 'test_not_exist.mat']);
assert_isfalse(tf);
assert_isequal(ver, string());
assert_isequal(header, string());
%=============================================================================