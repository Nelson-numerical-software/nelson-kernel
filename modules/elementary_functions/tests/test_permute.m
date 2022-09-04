%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
M = [];
M(:, :, 1) = [111, 121, 131, 141; 211, 221, 231, 241; 311, 321, 331, 341];
M(:, :, 2) = [112, 122, 132, 142; 212, 222, 232, 242; 312, 322, 332, 342];
M(:, :, 3) = [113, 123, 133, 143; 213, 223, 233, 243; 313, 323, 333, 343];
M(:, :, 4) = [114, 124, 134, 144; 214, 224, 234, 244; 314, 324, 334, 344];
M(:, :, 5) = [115, 125, 135, 145; 215, 225, 235, 245; 315, 325, 335, 345];
%=============================================================================
R = permute(M, [3,1,2]);
REF = [];
REF(:,:,1) = [111   211   311;
   112   212   312;
   113   213   313;
   114   214   314;
   115   215   315];

REF(:,:,2) = [121   221   321;
   122   222   322;
   123   223   323;
   124   224   324;
   125   225   325];


REF(:,:,3) = [131   231   331;
   132   232   332;
   133   233   333;
   134   234   334;
   135   235   335];

REF(:,:,4) = [141   241   341;
   142   242   342;
   143   243   343;
   144   244   344;
   145   245   345];
assert_isequal(R, REF);
%=============================================================================
R = permute(M, [2,4,1,3]);
REF = [];
REF(:,:,1,1) = [111;
   121;
   131;
   141];
REF(:,:,2,1) = [211;
   221;
   231;
   241];
REF(:,:,3,1) = [311;
   321;
   331;
   341];
REF(:,:,1,2) = [112;
   122;
   132;
   142];
REF(:,:,2,2) = [212;
   222;
   232;
   242];
REF(:,:,3,2) = [312;
   322;
   332;
   342];
REF(:,:,1,3) = [113;
   123;
   133;
   143];
REF(:,:,2,3) = [213;
   223;
   233;
   243];
REF(:,:,3,3) = [313;
   323;
   333;
   343];
REF(:,:,1,4) = [114;
   124;
   134;
   144];
REF(:,:,2,4) = [214;
   224;
   234;
   244];
REF(:,:,3,4) = [314;
   324;
   334;
   344];
REF(:,:,1,5) = [115;
   125;
   135;
   145];
REF(:,:,2,5) = [215;
   225;
   235;
   245];
REF(:,:,3,5) = [315;
325;
335;
345];
assert_isequal(R, REF);
%=============================================================================
M = [-9+5i,1+i, 8; 2, i+2*8 ,3-2i;7i,8,1+1.2i;3,1,8];
R = permute(M, [2,1]);
REF = [-9.0000 + 5.0000i   2.0000 + 0.0000i   0.0000 + 7.0000i   3.0000 + 0.0000i;
1.0000 + 1.0000i  16.0000 + 1.0000i   8.0000 + 0.0000i   1.0000 + 0.0000i;
8.0000 + 0.0000i   3.0000 - 2.0000i   1.0000 + 1.2000i   8.0000 + 0.0000i];
assert_isequal(R, REF);
%=============================================================================
R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [1,2]);
REF = [     5     1     8;
2     8     3;
7     8     1;
3     1     8];
assert_isequal(R, REF);
%=============================================================================
R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [2,1]);
REF = [     5     2     7     3;
1     8     8     1;
8     3     1     8];
assert_isequal(R, REF);
%=============================================================================
R = permute(2.3,[1,3,2]);
REF = 2.3;
assert_isequal(R, REF);
%=============================================================================
assert_checkerror('R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [2.8;1.7])', _('Expected integer index.'));
assert_checkerror('R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [1,1])', _('Second argument is not a valid permutation.'));
assert_checkerror('R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [0,2])', _('Second argument is not a valid permutation.'));
assert_checkerror('A = rand(3,3,2); B =permute(A,[2, 1]);', _('ORDER must have at least N elements for an N-D array.'));
%=============================================================================
R = permute([5,1,8;2,8,3;7,8,1;3,1,8], [3,1,2]);
REF = [];
REF(:,:,1) = [ 5,2,7,3];
REF(:,:,2) = [ 1,8,8,1];
REF(:,:,3) = [ 8,3,1,8];
assert_isequal(R, REF);
%=============================================================================
R = permute(ones(0,2),[1,3,2]);
REF = ones(0, 1, 2);
assert_isequal(R, REF);
%=============================================================================
R = permute(ones(2,0),[1,3,2]);
REF = ones(2, 1, 0);
assert_isequal(R, REF);
%=============================================================================
R = permute(ones(2,0),[2,3,1]);
REF = ones(0, 1, 2);
assert_isequal(R, REF);
%=============================================================================
R = permute([],[1,3,2]);
REF = ones(0, 1, 0);
assert_isequal(R, REF);
%=============================================================================
M = int8([5,1,8;2,8,3;7,8,1;3,1,8]);
R = permute(M, [2,1]);
REF = [     5     2     7     3;
1     8     8     1;
8     3     1     8];
assert_isequal(R, int8(REF));
%=============================================================================
A = cell(3,3,2);
R = permute(A,[3, 1, 2]);
assert_isequal(size(R), [2     3     3]);
%=============================================================================

