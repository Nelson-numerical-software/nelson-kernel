%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
clear A
clear B
clear C
A.a = 1;A.b = 2;A.c = 3;
B.a = 3;B.b = 2;B.c = 1;
C.a = 2;C.b = 3;C.c = 1;
%=============================================================================
D = [A, B];
E = [A, C];
assert_isfalse(isequal(D, E));
assert_istrue(isequal(D, D));
%=============================================================================
D = [A; B];
E = [A; C];
assert_isfalse(isequal(D, E));
assert_istrue(isequal(D, D));
%=============================================================================
clear A
clear B
clear C
clear D
clear E