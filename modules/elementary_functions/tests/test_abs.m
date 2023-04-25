%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('abs'), 1)
assert_isequal(nargout('abs'), 1)
%=============================================================================
A = [2.3 3.8 5.5 -2.3 -3.8 -5.5];
R = abs(A);
REF = [2.3 3.8 5.5 2.3 3.8 5.5];
assert_isequal(R, REF);
%=============================================================================
A = single([2.3 3.8 5.5 -2.3 -3.8 -5.5]);
R = abs(A);
REF = single([2.3 3.8 5.5 2.3 3.8 5.5]);
assert_isequal(R, REF);
%=============================================================================
assert_isequal(abs(NaN), NaN);
assert_isequal(abs(Inf), Inf);
assert_isequal(abs(-Inf), Inf);
assert_isequal(abs(zeros(0, 3)), zeros(0, 3));
%=============================================================================
R = abs('a');
REF = 97;
assert_isequal(R, REF);
%=============================================================================