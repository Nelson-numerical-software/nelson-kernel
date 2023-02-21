%=============================================================================
% Copyright (c) 2017 Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
% <-- Issue URL -->
% https://github.com/Nelson-numerical-software/nelson/issues/74
% <-- Short Description -->
% A=[]; A(end + 1) = 8 failed.
%=============================================================================
A = [];
A(end + 1) = 8;
REF = 8;
assert_isequal(A, REF);
%=============================================================================
A = [];
A(end + 9) = 3;
REF = [0     0     0     0     0     0     0     0     3];
assert_isequal(A, REF);
%=============================================================================