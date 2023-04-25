%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
R = invhilb(2);
REF = [4, -6; -6, 12];
assert_isequal(R, REF);
%=============================================================================
R = invhilb(2, 'single');
REF = single([4, -6; -6, 12]);
assert_isequal(R, REF);
%=============================================================================
R = invhilb(4);
REF = [ 16     -120      240     -140;
-120     1200    -2700     1680;
240    -2700     6480    -4200;
-140     1680    -4200     2800];
assert_isequal(R, REF);
%=============================================================================