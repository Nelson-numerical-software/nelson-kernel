%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
% <--WINDOWS ONLY-->
%=============================================================================
pTextToSpeech = actxserver('Sapi.SpVoice');
%=============================================================================
p(1) = pTextToSpeech;
p(2) = pTextToSpeech;
assert_isequal(size(p), [1 2]);
%=============================================================================
K = [];
K(1) = pTextToSpeech;
K(2) = pTextToSpeech;
assert_isequal(size(K), [1 2]);
%=============================================================================
