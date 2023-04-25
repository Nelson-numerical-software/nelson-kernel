%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('cos'), 1);
assert_isequal(nargout('cos'), 1);
%=============================================================================
assert_isequal(cos(NaN), NaN);
assert_isequal(cos(-NaN), NaN);
assert_isequal(cos(Inf), NaN);
assert_isequal(cos(-Inf), NaN);
%=============================================================================
v = [1.   0.8660254   0.7071068   0.5   0.   0.  -0.5  -0.7071068  -0.8660254  -1];
r = cos(v);
ref = [ 0.5403    0.6479    0.7602    0.8776    1.0000    1.0000    0.8776    0.7602    0.6479    0.5403];
assert_isapprox(r, ref, 1e-4);
%=============================================================================
x = cos(0i);
ref = 1;
assert_isequal(x, ref);
assert_isequal(cos(0), 1);
assert_isequal(cos(-0), 1);
%=============================================================================
X = cos(zeros(3, 3, 3));
REF = ones(3, 3, 3);
assert_isequal(X, REF);
%=============================================================================
S = sparse(zeros(3, 3));
X = cos(S);
REF = sparse(ones(3, 3));
assert_isequal(X, REF);
%=============================================================================
assert_isequal(cos([]), []);
%=============================================================================
X = [5.235987755982988157E-01;
7.853981633974482790E-01;
1.047197551196597631E+00;
1.570796326794896558E+00;
2.094395102393195263E+00;
2.356194490192344837E+00;
2.617993877991494411E+00;
3.141592653589793116E+00];
REF = [8.660254037844386755E-01;
7.071067811865475727E-01;
5.000000000000000994E-01;
6.123233995736765886e-17;
-4.999999999999998011e-01;
-7.071067811865474595E-01;
-8.660254037844386698E-01;
-1.000000000000000000E+00];
assert_isapprox(cos(X), REF, 1e-15);
%=============================================================================
assert_checkerror('cos(''a'')', [_('Undefined function ''cos'' for input arguments of type '''), class('a'), '''.']);
%=============================================================================