%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
function fun_evalin2()
  inner();
end
%=============================================================================
function inner()
  KK = 3
  evalin('base', 'XX = 356;');
  disp(KK)
end
%=============================================================================