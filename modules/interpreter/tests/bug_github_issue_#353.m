%=============================================================================
% Copyright (c) 2017 Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
% <-- Issue URL -->
% https://github.com/Nelson-numerical-software/nelson/issues/353
% <-- Short Description -->
% N = i; N(1) returned wrong value.
%=============================================================================
N = i;
REF = i;
assert_isequal(N(1), REF);
%=============================================================================
N = i;
REF = i;
assert_isequal(N(1, 1), REF);
%=============================================================================