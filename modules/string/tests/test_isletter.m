%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('isletter'), 1);
assert_isequal(nargout('isletter'), 1);
%=============================================================================
A = 'Nelson';
R = isletter(A);
REF = logical(ones(1, 6));
assert_isequal(R, REF);
%=============================================================================
A = "Nelson";
R = isletter(A);
REF = logical(ones(1, 6));
assert_isequal(R, REF);
%=============================================================================
