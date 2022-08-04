%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
h = .5; x = 0:h:pi;
X = sin(x.^2);
R = diff(X);
REF = [0.2474    0.5941   -0.0634   -1.5349    0.7236    0.4453];
assert_isapprox(R, REF, 1e-4);
%=============================================================================
X = [1 3 5;7 11 13;17 19 23];
R = diff(X, 1, 2);
REF = [2     2; 4     2; 2     4];
assert_isequal(R, REF);
%=============================================================================
V = [(1:8).^2, (1:8).^3, (1:8).^4];
R = diff(V, 3, 2);
REF = [ 0, 0, 0, 0, 0, -80, 148, -58, 6, 6, 6, 6, 6, -722, 1206, -476, 60, 84, 108, 132, 156];
assert_isequal(R, REF);
%=============================================================================
X = [1 3 5;7 11 13;17 19 23];
assert_checkerror('R = diff(X, -1, 2);', _('Difference order N must be a positive integer scalar.'));
assert_checkerror('R = diff(X, 0, 2);', _('Difference order N must be a positive integer scalar.'));
%=============================================================================
