%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('tanm'), 1);
assert_isequal(nargout('tanm'), 1);
%=============================================================================
assert_isequal(tanm(NaN), NaN);
assert_isequal(tanm(-NaN), NaN);
assert_isequal(tanm(Inf), NaN);
assert_isequal(tanm(-Inf), NaN);
%=============================================================================
x = tanm(0i);
ref = 0;
assert_isequal(x, ref);
%=============================================================================
X = tanm(zeros(3, 3));
REF = zeros(3, 3);
assert_isequal(X, REF);
%=============================================================================
assert_isequal(tanm([]), []);
%=============================================================================
A = [1,2;3,4];
R = tanm(A);
REF = [     -0.6051     -0.3127;
-0.4691     -1.0742];
assert_isapprox(R, REF, 1e-4);
%=============================================================================
A = single([1,2;3,4]);
R = tanm(A);
REF = [     -0.6051     -0.3127;
-0.4691     -1.0742];
assert_isapprox(R, REF, 1e-4);
assert_isequal(class(R), 'single');
%=============================================================================
A = 3 * eye(2,2) + i;
R = tanm(A);
REF = [    -0.0762 + 0.4827i     0.0663 + 0.4827i
0.0663 + 0.4827i    -0.0762 + 0.4827i];
assert_isapprox(abs(R), abs(REF), 1e-4);
%=============================================================================
A = single(3 * eye(2,2) + i);
R = tanm(A);
REF = [    -0.0762 + 0.4827i     0.0663 + 0.4827i
0.0663 + 0.4827i    -0.0762 + 0.4827i];
assert_isapprox(abs(R), abs(REF), 1e-4);
assert_isequal(class(R), 'single');
%=============================================================================
assert_checkerror('tanm([1 , 2])', _('Square matrix expected.'));
assert_checkerror('tanm(''a'')', [_('Undefined function ''tanm'' for input arguments of type '''), class('a'), '''.']);
%=============================================================================