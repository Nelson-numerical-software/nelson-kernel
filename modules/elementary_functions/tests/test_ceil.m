%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('ceil'), 1)
assert_isequal(nargout('ceil'), 1)
%=============================================================================
A = [2.3 3.8 5.5 -2.3 -3.8 -5.5];
R = ceil(A);
REF = [3     4     6    -2    -3    -5];
assert_isequal(R, REF);
%=============================================================================
A = single([2.3 3.8 5.5 -2.3 -3.8 -5.5]);
R = ceil(A);
REF = single([3     4     6    -2    -3    -5]);
assert_isequal(R, REF);
%=============================================================================
A = complex([2.3 3.8 5.5 -2.3 -3.8 -5.5], [2.3 3.8 5.5 -2.3 -3.8 -5.5] * 2);
R = ceil(A);
REF = [3.0000+5.0000i, 4.0000+8.0000i, 6.0000+11.0000i, -2.0000-4.0000i, -3.0000-7.0000i, -5.0000-11.0000i];
assert_isequal(R, REF);
%=============================================================================
A = ceil(int8(3));
R = class(A);
assert_isequal(R, 'int8');
%=============================================================================
assert_isequal(ceil(NaN), NaN);
assert_isequal(ceil(Inf), Inf);
assert_isequal(ceil(-Inf), -Inf);
assert_isequal(ceil(zeros(0, 3)), zeros(0, 3));
%=============================================================================
