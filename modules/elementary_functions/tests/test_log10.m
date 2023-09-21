%=============================================================================
% Copyright (c) 2020-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('log10'), 1);
assert_isequal(nargout('log10'), 1);
%=============================================================================
R = log10(NaN);
REF = NaN;
assert_isequal(R,REF);
%=============================================================================
R = log10(0);
REF = -Inf;
assert_isequal(R,REF);
%=============================================================================
R = log10(1);
REF = 0;
assert_isequal(R,REF);
%=============================================================================
R = log10(10);
REF = 1;
assert_isequal(R,REF);
%=============================================================================
R = log10(100);
REF = 2;
assert_isequal(R,REF);
%=============================================================================
R = log10(3i);
REF = 0.4771 + 0.6822i;
assert_isapprox(R,REF, 1e-4);
%=============================================================================
R = log10([1 10 100]);
REF =  [0 1 2];
assert_isequal(R,REF);
%=============================================================================
R = log10([1 10 ;100 1000]);
REF = [0 1; 2 3];
assert_isequal(R,REF);
%=============================================================================
R = log10(single(10));
REF = single(1);
assert_isequal(R,REF);
%=============================================================================
msg = sprintf(_('Check for incorrect argument data type or missing argument in call to function ''%s''.'), 'log10');
assert_checkerror('R = log10(true);', msg);
%=============================================================================
R = log10(-3);
REF = log10(complex(-3, 0));
assert_isequal(R,REF);
%=============================================================================
R = log10([0i NaN]);
REF = [-Inf NaN];
assert_isequal(R,REF);
%=============================================================================
R = log10([0i complex(NaN, NaN)]);
REF = [-Inf complex(NaN, NaN)];
assert_isequal(R,REF);
%=============================================================================
