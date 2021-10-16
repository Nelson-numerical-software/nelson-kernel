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
R = evalc('A = string(NaN)');
REF =  '
A =

    <missing>

';
assert_isequal(R, REF)
%=============================================================================
R = evalc('A = string([])');
REF = '
A =

  0×0 empty string matrix

';
assert_isequal(R, REF)
%=============================================================================
A = ["d","d","d";
    "ddd","dddd","dd";
    "cc","cc","cc"];
R = evalc('A');
REF = '
A =

  <string> - size: 3×3

      "d"       "d"     "d"
    "ddd"    "dddd"    "dd"
     "cc"      "cc"    "cc"

';
assert_isequal(R, REF)
%=============================================================================
A = ["d","d","d";
    "ds", NaN,"ds";
    "c","c","c"];
R = evalc('A');
REF =   '
A =

  <string> - size: 3×3

     "d"          "d"     "d"
    "ds"    <missing>    "ds"
     "c"          "c"     "c"

';
assert_isequal(R, REF)
%=============================================================================
A = ["dddlll" "dd" "1234567890ABCDEFGHIJKLMNOPQRSTVUWXY0123";"dddlll" "dd" "ddddddddddddddd";"d" "dd" ""];
R = evalc('A');
%=============================================================================
A = ["Mercury1" "Gemini2" "Apollo3" "Smith4","Chung5","Morales6" "Mercury7" "Gemini8" "Apollo9" "Smith10","Chung11","Morales12" "Mercury13" "Gemini14" "Apollo15" "Smith16","Chung17","Morales18";
       "Skylab19" "Skylab B20" "ISS21" "Sanchez22","Peterson23","Adams24" "Mercury25" "Gemini26" "Apollo27" "Smith28","Chung29","Morales30" "Mercury31" "Gemini32" "Apollo33" "Smith34","Chung35","Morales36"]
R = evalc('A');
%=============================================================================
A = ["Smith","Chung","Morales"; 
       "Sanchez","Peterson","Adams"];
R = evalc('A');
%=============================================================================
A = ["dd", "dddddddddddddddddddddddddddddddddddddddddddddddddd"];
R = evalc('A');
%=============================================================================
A = ["ffffffffffffff", "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", "dddddddddddddddddddddddddddddd","ddddddddddddddddddddddddddddddddddddddddddddddddddd"];
R = evalc('A');
%=============================================================================
A=1:10:27*10;
B = string(reshape(A,3,3,3));
B(2,1, 2) = "ffffffffffffffffffdddddddddddffffffffffffffffffffff"
B(1,1, 3) = NaN;
R = evalc('B');
%=============================================================================

R = evalc('B');
R = evalc('disp(B)');

