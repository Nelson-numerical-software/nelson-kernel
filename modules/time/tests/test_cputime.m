%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_isequal(nargin('cputime'), 0);
assert_isequal(nargout('cputime'), 1);
%=============================================================================
t1 = cputime;
sleep(5);
t2 = cputime;
% no real test to do here ...
%=============================================================================