%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('rad2deg'), -1);
assert_isequal(nargout('rad2deg'), 1);
%=============================================================================
x = -pi;
R = rad2deg(x);
REF = -180;
assert_isequal(R, REF);
%=============================================================================
x = pi;
R = rad2deg(x);
REF = 180;
assert_isequal(R, REF);
%=============================================================================