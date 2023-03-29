%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('min'), 4)
assert_isequal(nargout('min'), 2)
%=============================================================================
R = min([]);
assert_isequal(R, []);
%=============================================================================
[R, I] = min([]);
assert_isequal(R, []);
assert_isequal(I, []);
%=============================================================================
[R, I] = min(5);
assert_isequal(R, 5);
assert_isequal(I, 1);
%=============================================================================
[R, I] = min([1 NaN 3 Inf -Inf 4]);
assert_isequal(R, -Inf);
assert_isequal(I, 5);
%=============================================================================
A = [23 42 37 18 52];
R = min(A);
assert_isequal(R, 18);
%=============================================================================
A = [23 42 37 18 52];
[R, I] = min(A);
assert_isequal(R, 18);
assert_isequal(I, 4);
%=============================================================================
A = [-2+2i, 4+i, -1-3i];
[R, I] = min(A);
assert_isequal(R, -2+2i);
assert_isequal(I, 1);
%=============================================================================
A = [-2+2i, 4+i, -1-5i];
[R, I] = min(A);
assert_isequal(R, -2+2i);
assert_isequal(I, 1);
%=============================================================================
A = [2 8 4; 7 3 9];
R = min(A);
assert_isequal(R, [2 3 4]);
%=============================================================================
A = [1.7 1.2 1.5; 1.3 1.6 1.99];
R = min(A, [], 2);
assert_isequal(R, [1.2; 1.3]);
%=============================================================================
A = [1 9 -2; 8 4 -5];
[R, I] = min(A);
assert_isequal(R, [1 4 -5]);
assert_isequal(I, [1 2 2]);
%=============================================================================
A = [1 7 3; 6 2 9];
B = 5;
R = min(A, B);
REF = [1 5 3; 5 2 5];
assert_isequal(R, REF);
%=============================================================================
A = [8 2 4; 7 3 9];
[R, I] = min(A(:));
assert_isequal(R, 2);
assert_isequal(I, 3);
%=============================================================================
A = 'Nelson';
[R, I] = min(A);
assert_isequal(R, 78);
assert_isequal(I, 1);
%=============================================================================
A = [1 7 3; 6 2 9];
B = 5i;
R = min(A, B);
REF = [ 1.0000 + 0.0000i   0.0000 + 5.0000i   3.0000 + 0.0000i;
0.0000 + 5.0000i   2.0000 + 0.0000i   0.0000 + 5.0000i];
assert_isequal(R, REF);
%=============================================================================
A = [1 complex(7,NaN) 3; 6 2 complex(NaN, 9)];
B = 5;
R = min(A, B);
REF = [     1     5     3;5     2     5];
assert_isequal(R, REF);
%=============================================================================
A = [1 complex(7,NaN) 3; 6 2 complex(NaN, 9)];
[R, I] = min(A, [], 1, 'omitnan');
assert_isequal(R, [1 2 3]);
assert_isequal(I, [1 2 1]);
%=============================================================================
A = [1 complex(7,NaN) 3; 6 2 complex(NaN, 9)];
[R, I] = min(A, [], 1);
assert_isequal(R, [1 2 3]);
assert_isequal(I, [1 2 1]);
%=============================================================================
A = [1 complex(7,NaN) 3; 6 2 complex(NaN, 9)];
[R, I] = min(A, [], 1, 'includenan');
assert_isequal(R, [1, complex(7, NaN), complex(NaN,9)]);
assert_isequal(I, [1 1 2]);
%=============================================================================
A = [1 NaN 3; 6 2 NaN];
[R, I] = min(A, [], 1, 'omitnan');
assert_isequal(R, [1 2 3]);
assert_isequal(I, [1 2 1]);
%=============================================================================
A = [1 NaN 3; 6 2 NaN];
[R, I] = min(A, [], 1);
assert_isequal(R, [1 2 3]);
assert_isequal(I, [1 2 1]);
%=============================================================================
A = [1 NaN 3; 6 2 NaN];
[R, I] = min(A, [], 1, 'includenan');
assert_isequal(R, [1 NaN NaN]);
assert_isequal(I, [1 1 2]);
%=============================================================================
A = [1.77 -0.005 3.98 -2.95 NaN 0.34 NaN 0.19];
R = min(A, [], 'omitnan');
REF = -2.95;
assert_isequal(R, REF);
%=============================================================================
R = min(A, [], 'includenan');
REF = NaN;
assert_isequal(R, REF);
%=============================================================================
A = [1     NaN     3;6     2     9];
B = [1     NaN     3;6     2     NaN];
R = min(A, B);
assert_isequal(R, [1 NaN 3; 6 2 9]);
R = min(A, B, 'omitnan');
assert_isequal(R, [1 NaN 3; 6 2 9]);
R = min(A, B, 'includenan');
assert_isequal(R, [1 NaN 3; 6 2 NaN]);
%=============================================================================
A = [1     NaN     3;6     2     9] + i;
B = [1     NaN     3;6     2     NaN];
R = min(A, B);
REF = [   1.0000 + 0.0000i      NaN + 1.0000i   3.0000 + 0.0000i;
6.0000 + 0.0000i   2.0000 + 0.0000i   9.0000 + 1.0000i];
assert_isequal(R, REF);
%=============================================================================
R = min(A, B, 'omitnan');
REF = [   1.0000 + 0.0000i      NaN + 1.0000i   3.0000 + 0.0000i;
6.0000 + 0.0000i   2.0000 + 0.0000i   9.0000 + 1.0000i];
assert_isequal(R, REF);
%=============================================================================
R = min(A, B, 'includenan');
REF = [1.0000 + 0.0000i      NaN + 1.0000i   3.0000 + 0.0000i;
6.0000 + 0.0000i   2.0000 + 0.0000i      NaN + 0.0000i];
assert_isequal(R, REF);
%=============================================================================
M = [10 20 30; 33 34 36; 39 3 44];
R = min(M, [], 'all');
assert_isequal(R, 3);
%=============================================================================
[M, I] = min([1 2 3], [], 3);
REF_M =  [1 2 3];
REF_I =  [1 1 1];
assert_isequal(M, REF_M);
assert_isequal(I, REF_I);
%=============================================================================