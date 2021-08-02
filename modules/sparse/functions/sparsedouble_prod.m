%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU Lesser General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% Alternatively, you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 2 of
% the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this program. If not, see <http://www.gnu.org/licenses/>.
% LICENCE_BLOCK_END
%=============================================================================
function r = sparsedouble_prod(varargin)
  nRhs = length(varargin);
  switch nRhs
    case 0
      error(_('Wrong number of input arguments.'));
    case 1
      X = varargin{1};
      r = sparse(prod(full(X)));
    case 2
      X = varargin{1};
      dim = varargin{2};
      r = sparse(prod(full(X)), dim);
    case 3
      X = varargin{1};
      dim = varargin{2};
      typ = varargin{3};
      r = sparse(prod(full(X)), dim, typ);
    case 4
      X = varargin{1};
      dim = varargin{2};
      typ = varargin{3};
      n = varargin{4};
      r = sparse(prod(full(X)), dim, typ, n);
    otherwise
      error(_('Wrong number of input arguments.'));
  end
end
%=============================================================================