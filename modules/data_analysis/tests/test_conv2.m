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
assert_isequal(nargin('conv2'), 4);
assert_isequal(nargout('conv2'), 1);
%=============================================================================
A = magic(3);
B = magic(4);
R = conv2(A, B);
REF = [128    32   122   119    31    78;
 88   179   252   208   154   139;
151   275   291   378   281   154;
 79   271   423   366   285   106;
 48   171   248   292   230    31;
 16    92   194   167    39     2];
assert_isequal(R, REF)
%=============================================================================
A = magic(3);
B = magic(4);
R = conv2(A, B, 'full');
REF = [128    32   122   119    31    78;
  88   179   252   208   154   139;
 151   275   291   378   281   154;
  79   271   423   366   285   106;
  48   171   248   292   230    31;
  16    92   194   167    39     2];
assert_isequal(R, REF)
%=============================================================================
A = magic(3);
B = magic(4);
R = conv2(A, B, 'same');
REF = [   291   378   281;
  423   366   285;
  248   292   230];
assert_isequal(R, REF)
%=============================================================================
A = magic(3);
B = magic(4);
R = conv2(A, B, 'valid');
REF = [];
assert_isequal(R, REF)
%=============================================================================
s = [1 2 1; 0 0 0; -1 -2 -1];
A = zeros(10,10);A(3:7,3:7) = 1;
R = conv2(s, A);
REF = [0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     1     3     4     4     4     3     1     0     0     0;
    0     0     1     3     4     4     4     3     1     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0    -1    -3    -4    -4    -4    -3    -1     0     0     0;
    0     0    -1    -3    -4    -4    -4    -3    -1     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0 ];
assert_isequal(R, REF)
%=============================================================================
A = magic(3) + i;
B = magic(4);
R = conv2(A, B);
REF = [128 +  16i,    32 +  18i,   122 +  21i,   119 +  18i,    31 +  16i,    78 +  13i;
    88 +  21i,   179 +  34i,   252 +  47i,   208 +  47i,   154 +  34i,   139 +  21i;
   151 +  30i,   275 +  50i,   291 +  69i,   378 +  72i,   281 +  52i,   154 +  33i;
    79 +  18i,   271 +  50i,   423 +  81i,   366 +  84i,   285 +  52i,   106 +  21i;
    48 +  13i,   171 +  34i,   248 +  55i,   292 +  55i,   230 +  34i,    31 +  13i;
    16 +   4i,    92 +  18i,   194 +  33i,   167 +  30i,    39 +  16i,     2 +   1i];
assert_isequal(R, REF)
%=============================================================================
X = zeros(10);
X(3:7,3:7) = ones(5);
V = [1 0 -1]';
U = [1 2 1];
R = conv2(U, V, X);
REF = [ 0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     1     1     0     0     0    -1    -1     0     0     0;
    0     0     3     3     0     0     0    -3    -3     0     0     0;
    0     0     4     4     0     0     0    -4    -4     0     0     0;
    0     0     4     4     0     0     0    -4    -4     0     0     0;
    0     0     4     4     0     0     0    -4    -4     0     0     0;
    0     0     3     3     0     0     0    -3    -3     0     0     0;
    0     0     1     1     0     0     0    -1    -1     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0;
    0     0     0     0     0     0     0     0     0     0     0     0];
assert_isequal(R, REF)
%=============================================================================
R = conv2(2:6, 3, [1:11; 2:12; 21:31], 'same');
REF = [156   183   210   237   264   291   318   345   372   399   426;
    228   264   300   336   372   408   444   480   516   552   588;
    300   345   390   435   480   525   570   615   660   705   750];
assert_isequal(R, REF)
%=============================================================================
