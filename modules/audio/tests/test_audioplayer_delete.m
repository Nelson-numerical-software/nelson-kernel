%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
% <--AUDIO OUTPUT REQUIRED-->
%=============================================================================
r = audioplayer(sin(1:10000), 8192);
%=============================================================================
play(r)
sleep(5);
assert_istrue(isvalid(r));
delete(r)
assert_isfalse(isvalid(r));
%=============================================================================