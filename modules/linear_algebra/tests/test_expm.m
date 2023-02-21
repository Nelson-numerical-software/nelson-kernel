%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('expm'), 1);
assert_isequal(nargout('expm'), 1);
%=============================================================================
R = expm([1,2;3,4]);
REF = [51.9690,   74.7366;  112.1048, 164.0738];
assert_isapprox(R, REF, 1e-4);
assert_isequal(class(R), 'double');
%=============================================================================
R = expm(single([1,2;3,4]));
REF = [51.9689, 74.7365; 112.1048, 164.0737];
assert_isapprox(R, REF, 1e-4);
assert_isequal(class(R), 'single');
%=============================================================================
R = expm([]);
REF = [];
assert_isequal(R, REF);
%=============================================================================
R = expm(100);
REF = 26881171418161415515375286134216098712649728;
assert_isequal(R, REF);
%=============================================================================
R = expm(NaN);
REF = NaN;
assert_isequal(R, REF);
%=============================================================================
R = expm(Inf);
REF = NaN;
assert_isequal(R, REF);
%=============================================================================
R = expm(-Inf);
REF = NaN;
assert_isequal(R, REF);
%=============================================================================
R = expm(i);
REF = 0.5403 + 0.8415i;
assert_isapprox(R, REF, 1e-4);
%=============================================================================
M = [1 -1 -1;0 1 -1; 0 0 1];
R = expm(M);
REF = [2.7183   -2.7183   -1.3591; 0    2.7183   -2.7183; 0         0    2.7183];
assert_isapprox(R, REF, 1e-4);
%=============================================================================
M = [1 -1;0 1];
R = expm(M);
REF = [2.7183, -2.7183; 0    2.7183];
%=============================================================================
M = eye(100);
R = expm(M);
REF = 2.7183 * M;
assert_isapprox(R, REF, 1e-4);
%=============================================================================
M = sparse([1 -1;0 1]);
R = expm(M);
REF = [2.7183, -2.7183; 0    2.7183];
assert_isapprox(R, REF, 1e-4);
%=============================================================================
M = [1 1 0; 0 0 2; 0 0 -1] + i;
R = expm(M);
REF = [-0.0190+0.7636i,  -1.0190+0.7636i, -1.6511+0.7636i;
-1.9072+0.0021i, -0.9072+0.0021i, -0.6430+0.0021i;
-0.7649-0.3821i, -0.7649-0.3821i, -0.3970-0.3821i];
assert_isapprox(R, REF, 1e-4);
%=============================================================================
assert_checkerror('expm([1 2])', _('Square matrix expected.'));
%=============================================================================