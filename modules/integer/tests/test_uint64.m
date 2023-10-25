%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
as_uint64 = 18446744073709551615u64;
max_uint64 = intmax('uint64');
assert_isequal(as_uint64, max_uint64);
%=============================================================================
A = 1;
B = 1u64;
C = uint64(A);
assert_isequal(class(B), class(C));
assert_isequal(class(B), 'uint64');
assert_isequal(B, C);
%=============================================================================
