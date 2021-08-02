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
% http://slicot.org/objects/software/shared/doc/SB03MD.html
% [U_OUT, C_OUT, SCALE, SEP, FERR, WR, WI, INFO] = slicot_sb03md(DICO, JOB, FACT, TRANA, A, U_IN, C_IN)
assert_isequal(nargin('slicot_sb03md'), 7);
assert_isequal(nargout('slicot_sb03md'), 8);
%=============================================================================
N = 3;
DICO = 'D';
FACT = 'N';
JOB = 'X';
TRANA = 'N';

A = [3.0   1.0   1.0;
1.0   3.0   0.0;
0.0   0.0   3.0];

U_IN = zeros(N, N);

C_IN = [25.0  24.0  15.0;
24.0  32.0   8.0;
15.0   8.0  40.0];

[U_OUT, C_OUT, SCALE, SEP, FERR, WR, WI, INFO] = slicot_sb03md(DICO, JOB, FACT, TRANA, A, U_IN, C_IN);
%=============================================================================
U_OUT_REF = [0.7071     -0.7071      0.0000;
0.7071      0.7071      0.0000;
0.0000      0.0000      1.0000];
assert_isapprox(U_OUT, U_OUT_REF, 1e-4);
%=============================================================================
C_OUT_REF = [2.0000      1.0000      1.0000;
1.0000      3.0000     -0.0000;
1.0000     -0.0000      4.0000];
assert_isapprox(C_OUT, C_OUT_REF, 1e-4);
%=============================================================================
SCALE_REF = 1;
assert_isequal(SCALE, SCALE_REF);
%=============================================================================
SEP_REF = 0;
assert_isequal(SEP, SEP_REF);
%=============================================================================
FERR_REF = 0;
assert_isequal(FERR, FERR_REF);
%=============================================================================
WR_REF = [4     2     3];
assert_isequal(WR, WR_REF);
%=============================================================================
WI_REF = [0     0     0];
assert_isequal(WI, WI_REF);
%=============================================================================
INFO_REF = int32(0);
assert_isequal(INFO, INFO_REF);
%=============================================================================