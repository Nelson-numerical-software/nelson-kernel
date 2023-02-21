%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
assert_istrue(istril(ones(2, 0)));
%=============================================================================
assert_istrue(istril([]));
%=============================================================================
assert_isfalse(istril([3 2]));
%=============================================================================
assert_isfalse(istril(ones(2, 2, 2)));
%=============================================================================
assert_istrue(istril(eye(10, 10)));
%=============================================================================
assert_istrue(istril(tril(magic(5))));
%=============================================================================
assert_isfalse(istril(triu(magic(5))));
%=============================================================================