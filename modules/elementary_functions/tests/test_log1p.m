%=============================================================================
% Copyright (c) 2020-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('log1p'), 1);
assert_isequal(nargout('log1p'), 1);
%=============================================================================
R = log1p(NaN);
REF = NaN;
assert_isequal(R,REF);
%=============================================================================
R = log1p(0);
REF = 0;
assert_isequal(R,REF);
%=============================================================================
R = log1p(1);
REF = 0.6931;
assert_isapprox(R,REF, 1e-4);
%=============================================================================
R = log1p(10);
REF = 2.3979;
assert_isapprox(R,REF, 1e-4);
%=============================================================================
R = log1p(100);
REF = 4.6151;
assert_isapprox(R,REF, 1e-4);
%=============================================================================
R = log1p(3i);
REF =  1.1513 + 1.2490i;
assert_isapprox(R,REF, 1e-4);
%=============================================================================
assert_checkerror('R = log1p(true);', sprintf(_('function %s_log1p undefined.'), class(true)));
%=============================================================================
R = log1p(-3);
REF = log1p(complex(-3, 0));
assert_isequal(R, REF);
%=============================================================================