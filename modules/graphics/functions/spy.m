%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
function spy(varargin)
  narginchk(0, 3);
  
  cax = newplot();
  next = lower(get(cax, 'NextPlot'));
  hold_state = ishold();
  
  marker = '';
  color = '';
  markersize = 0;
  linestyle = 'none';
  
  if nargin >= 3
    arg3 = varargin{3}
    if ischar(arg3) || isStringScalar(arg3)
      [void, color, marker, msg] = colstyle(arg3, 'plot'); 
      if ~isempty(msg)
        error(msg.message);
      end
    else
      markersize = arg3;
    end
  end
  
  if nargin >= 2
    arg2 = varargin{2};
    if ischar(arg2) || isStringScalar(arg2)
      [void , color, marker, msg] = colstyle(arg2, 'plot');
      if ~isempty(msg)
        error(msg.message);
      end
    else
      markersize = arg2;
    end
  end
  
  if isempty(marker)
    marker = '.';
  end
  if isempty(color)
    co = get(cax, 'colorOrder');
    color = co(1,:);
  end
  
  if nargin < 1
    S = demo();
  else
    S = varargin{1};
  end
  [m, n] = size(S);
  if (markersize == 0) && (marker ~= '.')
    markersize = 6;
  end
  if (markersize == 0)
    ax = gca(); 
    units = ax.units;
    ax.units = 'normalized';
    pos = get(ax,'position');
    pos(1) = pos(1) * 420;
    pos(2) = pos(2) * 315;
    pos(3) = pos(3) * 420; 
    pos(4) = pos(4) * 315;
    markersize = max(4, min(14, round(6 * min(pos(3:4)) / max(m+1, n+1))));
    set(ax,'units', units);
  end
  
  if issparse(S)
    [i, j] = IJV(S);
  else
    [i, j] = find(S);  
  end
  
  if isempty(i)
    i = NaN;
    j = NaN;
  end
  if isempty(S)
    marker = 'none';
  end
  p = plot(j, i); 
  p.Marker = marker;
  p.Markersize = markersize;
  p.Linestyle = linestyle;
  p.Color = color;
  p.MarkerEdgeColor = color;
  
  xlabel(['nz = ', int2str(nnz(S))]);
  ax = gca();
  ax.XLim = [0, n+1];
  ax.YLim = [0, m+1];
  ax.YDir = 'reverse';
  ax.PlotBoxAspectRatio = [n+1, m+1, 1];
  
  if ~hold_state
    cax.NextPlot = next;
  end
end
%=============================================================================
function S = demo()
  DOG = [65, 1;
  66, 1; 
  67, 1; 
  68, 1; 
  63, 2; 
  64, 2; 
  65, 2; 
  66, 2; 
  67, 2; 
  68, 2; 
  69, 2; 
  21, 3; 
  22, 3; 
  23, 3; 
  24, 3; 
  25, 3; 
  26, 3; 
  63, 3; 
  64, 3; 
  68, 3; 
  69, 3; 
  70, 3; 
  71, 3; 
  20, 4; 
  21, 4; 
  22, 4; 
  26, 4; 
  27, 4; 
  63, 4; 
  68, 4; 
  70, 4; 
  71, 4; 
  72, 4; 
  20, 5; 
  21, 5; 
  27, 5; 
  28, 5; 
  62, 5; 
  63, 5; 
  71, 5; 
  72, 5; 
  19, 6; 
  20, 6; 
  28, 6; 
  29, 6; 
  61, 6; 
  62, 6; 
  63, 6; 
  67, 6; 
  72, 6; 
  73, 6; 
  18, 7; 
  19, 7; 
  23, 7; 
  24, 7; 
  28, 7; 
  29, 7; 
  61, 7; 
  62, 7; 
  67, 7; 
  68, 7; 
  70, 7; 
  73, 7; 
  74, 7; 
  18, 8; 
  19, 8; 
  24, 8; 
  25, 8; 
  29, 8; 
  30, 8; 
  61, 8; 
  62, 8; 
  69, 8; 
  70, 8; 
  72, 8; 
  74, 8; 
  75, 8; 
  17, 9; 
  18, 9; 
  25, 9; 
  26, 9; 
  28, 9; 
  29, 9; 
  30, 9; 
  60, 9; 
  61, 9; 
  70, 9; 
  74, 9; 
  75, 9; 
  76, 9; 
  16, 10; 
  17, 10; 
  26, 10; 
  28, 10; 
  30, 10; 
  31, 10; 
  60, 10; 
  61, 10; 
  70, 10; 
  71, 10; 
  72, 10; 
  75, 10; 
  76, 10; 
  16, 11; 
  17, 11; 
  22, 11; 
  26, 11; 
  27, 11; 
  29, 11; 
  30, 11; 
  31, 11; 
  59, 11; 
  60, 11; 
  61, 11; 
  71, 11; 
  72, 11; 
  73, 11; 
  76, 11; 
  77, 11; 
  15, 12; 
  16, 12; 
  22, 12; 
  27, 12; 
  29, 12; 
  31, 12; 
  59, 12; 
  60, 12; 
  70, 12; 
  72, 12; 
  73, 12; 
  77, 12; 
  78, 12; 
  14, 13; 
  15, 13; 
  16, 13; 
  21, 13; 
  27, 13; 
  30, 13; 
  31, 13; 
  32, 13; 
  59, 13; 
  60, 13; 
  73, 13; 
  77, 13; 
  78, 13; 
  14, 14; 
  15, 14; 
  20, 14; 
  21, 14; 
  27, 14; 
  28, 14; 
  30, 14; 
  32, 14; 
  58, 14; 
  59, 14; 
  73, 14; 
  74, 14; 
  78, 14; 
  79, 14; 
  13, 15; 
  14, 15; 
  15, 15; 
  19, 15; 
  20, 15; 
  28, 15; 
  32, 15; 
  33, 15; 
  58, 15; 
  59, 15; 
  74, 15; 
  75, 15; 
  77, 15; 
  78, 15; 
  79, 15; 
  13, 16; 
  14, 16; 
  19, 16; 
  28, 16; 
  29, 16; 
  32, 16; 
  33, 16; 
  34, 16; 
  57, 16; 
  58, 16; 
  59, 16; 
  75, 16; 
  77, 16; 
  79, 16; 
  80, 16; 
  13, 17; 
  14, 17; 
  18, 17; 
  29, 17; 
  33, 17; 
  34, 17; 
  57, 17; 
  58, 17; 
  75, 17; 
  76, 17; 
  78, 17; 
  79, 17; 
  80, 17; 
  12, 18; 
  13, 18; 
  18, 18; 
  29, 18; 
  33, 18; 
  34, 18; 
  35, 18; 
  57, 18; 
  58, 18; 
  76, 18; 
  78, 18; 
  79, 18; 
  80, 18; 
  12, 19; 
  13, 19; 
  17, 19; 
  18, 19; 
  29, 19; 
  30, 19; 
  34, 19; 
  57, 19; 
  58, 19; 
  76, 19; 
  79, 19; 
  80, 19; 
  81, 19; 
  11, 20; 
  12, 20; 
  13, 20; 
  17, 20; 
  30, 20; 
  34, 20; 
  35, 20; 
  57, 20; 
  58, 20; 
  76, 20; 
  77, 20; 
  79, 20; 
  80, 20; 
  81, 20; 
  11, 21; 
  12, 21; 
  17, 21; 
  30, 21; 
  34, 21; 
  35, 21; 
  57, 21; 
  58, 21; 
  77, 21; 
  79, 21; 
  80, 21; 
  81, 21; 
  11, 22; 
  12, 22; 
  17, 22; 
  30, 22; 
  35, 22; 
  36, 22; 
  56, 22; 
  57, 22; 
  77, 22; 
  79, 22; 
  80, 22; 
  81, 22; 
  11, 23; 
  12, 23; 
  16, 23; 
  30, 23; 
  32, 23; 
  35, 23; 
  36, 23; 
  56, 23; 
  57, 23; 
  77, 23; 
  81, 23; 
  10, 24; 
  11, 24; 
  16, 24; 
  30, 24; 
  31, 24; 
  32, 24; 
  35, 24; 
  36, 24; 
  56, 24; 
  57, 24; 
  77, 24; 
  81, 24; 
  82, 24; 
  10, 25; 
  11, 25; 
  16, 25; 
  31, 25; 
  35, 25; 
  36, 25; 
  37, 25; 
  55, 25; 
  56, 25; 
  57, 25; 
  77, 25; 
  80, 25; 
  81, 25; 
  82, 25; 
  10, 26; 
  11, 26; 
  16, 26; 
  28, 26; 
  32, 26; 
  35, 26; 
  36, 26; 
  37, 26; 
  38, 26; 
  39, 26; 
  40, 26; 
  41, 26; 
  50, 26; 
  51, 26; 
  52, 26; 
  53, 26; 
  54, 26; 
  55, 26; 
  56, 26; 
  57, 26; 
  77, 26; 
  81, 26; 
  82, 26; 
  10, 27; 
  11, 27; 
  12, 27; 
  16, 27; 
  26, 27; 
  28, 27; 
  32, 27; 
  36, 27; 
  37, 27; 
  38, 27; 
  39, 27; 
  40, 27; 
  41, 27; 
  42, 27; 
  43, 27; 
  44, 27; 
  45, 27; 
  46, 27; 
  47, 27; 
  48, 27; 
  49, 27; 
  50, 27; 
  51, 27; 
  52, 27; 
  53, 27; 
  54, 27; 
  55, 27; 
  56, 27; 
  77, 27; 
  78, 27; 
  79, 27; 
  81, 27; 
  82, 27; 
  9, 28; 
  10, 28; 
  11, 28; 
  16, 28; 
  25, 28; 
  26, 28; 
  27, 28; 
  28, 28; 
  33, 28; 
  37, 28; 
  38, 28; 
  39, 28; 
  40, 28; 
  41, 28; 
  42, 28; 
  43, 28; 
  44, 28; 
  45, 28; 
  46, 28; 
  47, 28; 
  48, 28; 
  49, 28; 
  50, 28; 
  51, 28; 
  52, 28; 
  54, 28; 
  55, 28; 
  73, 28; 
  74, 28; 
  78, 28; 
  79, 28; 
  81, 28; 
  82, 28; 
  10, 29; 
  11, 29; 
  16, 29; 
  19, 29; 
  20, 29; 
  25, 29; 
  26, 29; 
  27, 29; 
  33, 29; 
  41, 29; 
  42, 29; 
  43, 29; 
  44, 29; 
  45, 29; 
  46, 29; 
  47, 29; 
  48, 29; 
  49, 29; 
  73, 29; 
  74, 29; 
  75, 29; 
  77, 29; 
  78, 29; 
  79, 29; 
  82, 29; 
  10, 30; 
  11, 30; 
  16, 30; 
  19, 30; 
  20, 30; 
  25, 30; 
  26, 30; 
  27, 30; 
  33, 30; 
  57, 30; 
  68, 30; 
  72, 30; 
  73, 30; 
  74, 30; 
  75, 30; 
  77, 30; 
  78, 30; 
  79, 30; 
  82, 30; 
  83, 30; 
  9, 31; 
  10, 31; 
  11, 31; 
  16, 31; 
  18, 31; 
  19, 31; 
  20, 31; 
  25, 31; 
  26, 31; 
  27, 31; 
  33, 31; 
  58, 31; 
  59, 31; 
  60, 31; 
  68, 31; 
  72, 31; 
  73, 31; 
  74, 31; 
  75, 31; 
  77, 31; 
  82, 31; 
  83, 31; 
  9, 32; 
  10, 32; 
  11, 32; 
  16, 32; 
  18, 32; 
  19, 32; 
  20, 32; 
  22, 32; 
  25, 32; 
  26, 32; 
  27, 32; 
  28, 32; 
  33, 32; 
  60, 32; 
  61, 32; 
  62, 32; 
  73, 32; 
  74, 32; 
  75, 32; 
  77, 32; 
  79, 32; 
  80, 32; 
  82, 32; 
  83, 32; 
  9, 33; 
  10, 33; 
  16, 33; 
  18, 33; 
  19, 33; 
  20, 33; 
  21, 33; 
  22, 33; 
  23, 33; 
  25, 33; 
  26, 33; 
  28, 33; 
  32, 33; 
  33, 33; 
  62, 33; 
  63, 33; 
  64, 33; 
  72, 33; 
  73, 33; 
  74, 33; 
  75, 33; 
  76, 33; 
  79, 33; 
  80, 33; 
  82, 33; 
  83, 33; 
  9, 34; 
  10, 34; 
  17, 34; 
  18, 34; 
  19, 34; 
  20, 34; 
  21, 34; 
  22, 34; 
  23, 34; 
  26, 34; 
  27, 34; 
  31, 34; 
  32, 34; 
  64, 34; 
  65, 34; 
  72, 34; 
  73, 34; 
  74, 34; 
  75, 34; 
  76, 34; 
  79, 34; 
  80, 34; 
  83, 34; 
  9, 35; 
  10, 35; 
  17, 35; 
  18, 35; 
  19, 35; 
  20, 35; 
  21, 35; 
  22, 35; 
  26, 35; 
  27, 35; 
  30, 35; 
  31, 35; 
  65, 35; 
  66, 35; 
  72, 35; 
  73, 35; 
  74, 35; 
  75, 35; 
  76, 35; 
  77, 35; 
  79, 35; 
  80, 35; 
  81, 35; 
  83, 35; 
  84, 35; 
  9, 36; 
  10, 36; 
  17, 36; 
  18, 36; 
  19, 36; 
  20, 36; 
  21, 36; 
  22, 36; 
  26, 36; 
  27, 36; 
  28, 36; 
  29, 36; 
  30, 36; 
  66, 36; 
  67, 36; 
  69, 36; 
  70, 36; 
  71, 36; 
  72, 36; 
  73, 36; 
  74, 36; 
  75, 36; 
  76, 36; 
  80, 36; 
  81, 36; 
  83, 36; 
  84, 36; 
  9, 37; 
  10, 37; 
  17, 37; 
  19, 37; 
  20, 37; 
  21, 37; 
  22, 37; 
  24, 37; 
  26, 37; 
  27, 37; 
  28, 37; 
  29, 37; 
  67, 37; 
  68, 37; 
  69, 37; 
  70, 37; 
  71, 37; 
  72, 37; 
  73, 37; 
  74, 37; 
  75, 37; 
  76, 37; 
  80, 37; 
  81, 37; 
  83, 37; 
  84, 37; 
  9, 38; 
  10, 38; 
  17, 38; 
  19, 38; 
  20, 38; 
  21, 38; 
  22, 38; 
  23, 38; 
  24, 38; 
  25, 38; 
  26, 38; 
  27, 38; 
  28, 38; 
  68, 38; 
  69, 38; 
  70, 38; 
  71, 38; 
  72, 38; 
  73, 38; 
  75, 38; 
  76, 38; 
  80, 38; 
  81, 38; 
  83, 38; 
  84, 38; 
  85, 38; 
  8, 39; 
  9, 39; 
  10, 39; 
  17, 39; 
  18, 39; 
  19, 39; 
  20, 39; 
  21, 39; 
  22, 39; 
  23, 39; 
  24, 39; 
  25, 39; 
  26, 39; 
  27, 39; 
  68, 39; 
  69, 39; 
  70, 39; 
  71, 39; 
  74, 39; 
  75, 39; 
  76, 39; 
  80, 39; 
  84, 39; 
  85, 39; 
  7, 40; 
  8, 40; 
  9, 40; 
  10, 40; 
  17, 40; 
  18, 40; 
  19, 40; 
  20, 40; 
  21, 40; 
  22, 40; 
  23, 40; 
  24, 40; 
  25, 40; 
  26, 40; 
  27, 40; 
  70, 40; 
  71, 40; 
  74, 40; 
  75, 40; 
  76, 40; 
  80, 40; 
  85, 40; 
  86, 40; 
  8, 41; 
  18, 41; 
  19, 41; 
  20, 41; 
  21, 41; 
  22, 41; 
  23, 41; 
  25, 41; 
  26, 41; 
  71, 41; 
  72, 41; 
  85, 41; 
  8, 42; 
  18, 42; 
  19, 42; 
  20, 42; 
  21, 42; 
  22, 42; 
  23, 42; 
  24, 42; 
  25, 42; 
  72, 42; 
  73, 42; 
  85, 42; 
  8, 43; 
  19, 43; 
  20, 43; 
  21, 43; 
  22, 43; 
  73, 43; 
  74, 43; 
  82, 43; 
  85, 43; 
  8, 44; 
  22, 44; 
  23, 44; 
  24, 44; 
  74, 44; 
  75, 44; 
  81, 44; 
  84, 44; 
  85, 44; 
  8, 45; 
  75, 45; 
  76, 45; 
  77, 45; 
  82, 45; 
  7, 46; 
  8, 46; 
  77, 46; 
  85, 46; 
  8, 47; 
  12, 47; 
  78, 47; 
  85, 47; 
  86, 47; 
  8, 48; 
  9, 48; 
  19, 48; 
  20, 48; 
  21, 48; 
  87, 48; 
  9, 49; 
  18, 49; 
  19, 49; 
  85, 49; 
  87, 49; 
  88, 49; 
  89, 49; 
  8, 50; 
  90, 50; 
  7, 51; 
  8, 51; 
  84, 51; 
  88, 51; 
  89, 51; 
  90, 51; 
  6, 52; 
  7, 52; 
  87, 52; 
  90, 52; 
  5, 53; 
  6, 53; 
  87, 53; 
  90, 53; 
  3, 54; 
  4, 54; 
  5, 54; 
  87, 54; 
  88, 54; 
  90, 54; 
  91, 54; 
  2, 55; 
  3, 55; 
  4, 55; 
  88, 55; 
  91, 55; 
  1, 56; 
  2, 56; 
  3, 56; 
  4, 56; 
  5, 56; 
  88, 56; 
  89, 56; 
  91, 56; 
  1, 57; 
  2, 57; 
  3, 57; 
  4, 57; 
  89, 57; 
  90, 57; 
  90, 58; 
  1, 59; 
  90, 59; 
  1, 60; 
  90, 60; 
  1, 61; 
  89, 61; 
  90, 61; 
  1, 62; 
  62, 62; 
  63, 62; 
  64, 62; 
  65, 62; 
  66, 62; 
  89, 62; 
  91, 62; 
  31, 63; 
  32, 63; 
  33, 63; 
  34, 63; 
  35, 63; 
  61, 63; 
  62, 63; 
  89, 63; 
  91, 63; 
  2, 64; 
  31, 64; 
  34, 64; 
  36, 64; 
  60, 64; 
  63, 64; 
  65, 64; 
  67, 64; 
  68, 64; 
  91, 64; 
  29, 65; 
  36, 65; 
  59, 65; 
  60, 65; 
  62, 65; 
  63, 65; 
  64, 65; 
  65, 65; 
  68, 65; 
  91, 65; 
  1, 66; 
  30, 66; 
  31, 66; 
  32, 66; 
  33, 66; 
  34, 66; 
  35, 66; 
  36, 66; 
  37, 66; 
  38, 66; 
  59, 66; 
  61, 66; 
  65, 66; 
  67, 66; 
  68, 66; 
  69, 66; 
  90, 66; 
  91, 66; 
  1, 67; 
  3, 67; 
  29, 67; 
  30, 67; 
  32, 67; 
  33, 67; 
  37, 67; 
  38, 67; 
  43, 67; 
  58, 67; 
  59, 67; 
  60, 67; 
  61, 67; 
  63, 67; 
  64, 67; 
  65, 67; 
  67, 67; 
  68, 67; 
  90, 67; 
  91, 67; 
  29, 68; 
  30, 68; 
  31, 68; 
  32, 68; 
  33, 68; 
  34, 68; 
  35, 68; 
  37, 68; 
  38, 68; 
  39, 68; 
  40, 68; 
  57, 68; 
  58, 68; 
  59, 68; 
  60, 68; 
  61, 68; 
  67, 68; 
  68, 68; 
  90, 68; 
  91, 68; 
  29, 69; 
  30, 69; 
  31, 69; 
  32, 69; 
  37, 69; 
  38, 69; 
  39, 69; 
  40, 69; 
  41, 69; 
  60, 69; 
  61, 69; 
  62, 69; 
  63, 69; 
  65, 69; 
  66, 69; 
  67, 69; 
  90, 69; 
  91, 69; 
  30, 70; 
  31, 70; 
  32, 70; 
  33, 70; 
  34, 70; 
  35, 70; 
  36, 70; 
  37, 70; 
  38, 70; 
  39, 70; 
  40, 70; 
  41, 70; 
  57, 70; 
  60, 70; 
  61, 70; 
  62, 70; 
  63, 70; 
  64, 70; 
  65, 70; 
  66, 70; 
  90, 70; 
  91, 70; 
  31, 71; 
  32, 71; 
  33, 71; 
  34, 71; 
  35, 71; 
  36, 71; 
  37, 71; 
  38, 71; 
  39, 71; 
  40, 71; 
  41, 71; 
  57, 71; 
  59, 71; 
  62, 71; 
  63, 71; 
  90, 71; 
  91, 71; 
  33, 72; 
  34, 72; 
  35, 72; 
  36, 72; 
  37, 72; 
  38, 72; 
  41, 72; 
  57, 72; 
  91, 72; 
  39, 73; 
  41, 73; 
  91, 73; 
  91, 74; 
  91, 75; 
  91, 76; 
  91, 77; 
  91, 78; 
  91, 79; 
  91, 80; 
  91, 81; 
  91, 82; 
  91, 83; 
  91, 84; 
  89, 85; 
  91, 85; 
  91, 86; 
  91, 87; 
  91, 88; 
  91, 89; 
  91, 90; 
  91, 91; 
  91, 92; 
  48, 93; 
  49, 93; 
  50, 93; 
  51, 93; 
  52, 93; 
  53, 93; 
  54, 93; 
  90, 93; 
  91, 93; 
  45, 94; 
  46, 94; 
  47, 94; 
  48, 94; 
  49, 94; 
  50, 94; 
  51, 94; 
  52, 94; 
  53, 94; 
  54, 94; 
  55, 94; 
  56, 94; 
  57, 94; 
  90, 94; 
  91, 94; 
  43, 95; 
  44, 95; 
  45, 95; 
  46, 95; 
  47, 95; 
  48, 95; 
  49, 95; 
  50, 95; 
  51, 95; 
  52, 95; 
  53, 95; 
  54, 95; 
  55, 95; 
  57, 95; 
  58, 95; 
  90, 95; 
  91, 95; 
  42, 96; 
  43, 96; 
  44, 96; 
  45, 96; 
  46, 96; 
  47, 96; 
  48, 96; 
  49, 96; 
  50, 96; 
  51, 96; 
  52, 96; 
  53, 96; 
  54, 96; 
  55, 96; 
  56, 96; 
  57, 96; 
  58, 96; 
  90, 96; 
  91, 96; 
  41, 97; 
  42, 97; 
  43, 97; 
  44, 97; 
  45, 97; 
  46, 97; 
  47, 97; 
  48, 97; 
  49, 97; 
  50, 97; 
  51, 97; 
  52, 97; 
  53, 97; 
  54, 97; 
  55, 97; 
  56, 97; 
  57, 97; 
  58, 97; 
  59, 97; 
  90, 97; 
  91, 97; 
  41, 98; 
  42, 98; 
  43, 98; 
  44, 98; 
  45, 98; 
  46, 98; 
  47, 98; 
  48, 98; 
  49, 98; 
  50, 98; 
  51, 98; 
  52, 98; 
  53, 98; 
  54, 98; 
  55, 98; 
  56, 98; 
  57, 98; 
  58, 98; 
  59, 98; 
  90, 98; 
  91, 98; 
  41, 99; 
  42, 99; 
  43, 99; 
  44, 99; 
  45, 99; 
  46, 99; 
  47, 99; 
  48, 99; 
  49, 99; 
  50, 99; 
  51, 99; 
  52, 99; 
  53, 99; 
  54, 99; 
  55, 99; 
  56, 99; 
  57, 99; 
  58, 99; 
  59, 99; 
  66, 99; 
  87, 99; 
  90, 99; 
  91, 99; 
  41, 100; 
  42, 100; 
  43, 100; 
  44, 100; 
  45, 100; 
  46, 100; 
  47, 100; 
  48, 100; 
  49, 100; 
  50, 100; 
  51, 100; 
  52, 100; 
  53, 100; 
  54, 100; 
  55, 100; 
  56, 100; 
  57, 100; 
  58, 100; 
  59, 100; 
  66, 100; 
  89, 100; 
  90, 100; 
  91, 100; 
  28, 101; 
  42, 101; 
  43, 101; 
  44, 101; 
  45, 101; 
  46, 101; 
  47, 101; 
  48, 101; 
  49, 101; 
  50, 101; 
  51, 101; 
  52, 101; 
  53, 101; 
  54, 101; 
  55, 101; 
  56, 101; 
  57, 101; 
  58, 101; 
  59, 101; 
  66, 101; 
  89, 101; 
  90, 101; 
  91, 101; 
  42, 102; 
  43, 102; 
  44, 102; 
  45, 102; 
  46, 102; 
  47, 102; 
  48, 102; 
  49, 102; 
  50, 102; 
  51, 102; 
  52, 102; 
  53, 102; 
  54, 102; 
  55, 102; 
  56, 102; 
  57, 102; 
  58, 102; 
  66, 102; 
  89, 102; 
  90, 102; 
  91, 102; 
  42, 103; 
  43, 103; 
  44, 103; 
  45, 103; 
  46, 103; 
  47, 103; 
  48, 103; 
  49, 103; 
  50, 103; 
  51, 103; 
  52, 103; 
  53, 103; 
  54, 103; 
  55, 103; 
  56, 103; 
  57, 103; 
  58, 103; 
  89, 103; 
  90, 103; 
  91, 103; 
  42, 104; 
  43, 104; 
  44, 104; 
  45, 104; 
  46, 104; 
  47, 104; 
  48, 104; 
  49, 104; 
  50, 104; 
  51, 104; 
  52, 104; 
  53, 104; 
  54, 104; 
  55, 104; 
  56, 104; 
  57, 104; 
  58, 104; 
  89, 104; 
  90, 104; 
  91, 104; 
  43, 105; 
  44, 105; 
  45, 105; 
  46, 105; 
  47, 105; 
  48, 105; 
  49, 105; 
  50, 105; 
  51, 105; 
  52, 105; 
  53, 105; 
  54, 105; 
  55, 105; 
  56, 105; 
  57, 105; 
  89, 105; 
  90, 105; 
  91, 105; 
  31, 106; 
  44, 106; 
  45, 106; 
  46, 106; 
  47, 106; 
  48, 106; 
  49, 106; 
  50, 106; 
  51, 106; 
  52, 106; 
  53, 106; 
  54, 106; 
  55, 106; 
  56, 106; 
  89, 106; 
  90, 106; 
  91, 106; 
  45, 107; 
  46, 107; 
  47, 107; 
  48, 107; 
  49, 107; 
  50, 107; 
  51, 107; 
  52, 107; 
  53, 107; 
  54, 107; 
  55, 107; 
  89, 107; 
  90, 107; 
  91, 107; 
  48, 108; 
  49, 108; 
  50, 108; 
  51, 108; 
  52, 108; 
  53, 108; 
  54, 108; 
  55, 108; 
  88, 108; 
  89, 108; 
  90, 108; 
  91, 108; 
  49, 109; 
  50, 109; 
  51, 109; 
  52, 109; 
  53, 109; 
  54, 109; 
  55, 109; 
  58, 109; 
  59, 109; 
  60, 109; 
  89, 109; 
  90, 109; 
  91, 109; 
  43, 110; 
  44, 110; 
  49, 110; 
  50, 110; 
  51, 110; 
  52, 110; 
  53, 110; 
  54, 110; 
  55, 110; 
  56, 110; 
  57, 110; 
  88, 110; 
  89, 110; 
  90, 110; 
  91, 110; 
  36, 111; 
  37, 111; 
  38, 111; 
  45, 111; 
  46, 111; 
  47, 111; 
  48, 111; 
  49, 111; 
  50, 111; 
  51, 111; 
  52, 111; 
  53, 111; 
  54, 111; 
  55, 111; 
  56, 111; 
  57, 111; 
  58, 111; 
  62, 111; 
  63, 111; 
  64, 111; 
  87, 111; 
  88, 111; 
  89, 111; 
  90, 111; 
  91, 111; 
  38, 112; 
  39, 112; 
  44, 112; 
  45, 112; 
  46, 112; 
  47, 112; 
  48, 112; 
  49, 112; 
  50, 112; 
  51, 112; 
  52, 112; 
  53, 112; 
  54, 112; 
  55, 112; 
  56, 112; 
  57, 112; 
  58, 112; 
  59, 112; 
  60, 112; 
  61, 112; 
  62, 112; 
  86, 112; 
  87, 112; 
  88, 112; 
  89, 112; 
  90, 112; 
  91, 112; 
  9, 113; 
  39, 113; 
  40, 113; 
  41, 113; 
  46, 113; 
  47, 113; 
  48, 113; 
  49, 113; 
  50, 113; 
  51, 113; 
  52, 113; 
  53, 113; 
  54, 113; 
  55, 113; 
  56, 113; 
  59, 113; 
  60, 113; 
  87, 113; 
  88, 113; 
  89, 113; 
  90, 113; 
  8, 114; 
  9, 114; 
  10, 114; 
  11, 114; 
  41, 114; 
  42, 114; 
  43, 114; 
  44, 114; 
  50, 114; 
  51, 114; 
  52, 114; 
  58, 114; 
  59, 114; 
  87, 114; 
  88, 114; 
  89, 114; 
  90, 114; 
  7, 115; 
  8, 115; 
  11, 115; 
  12, 115; 
  42, 115; 
  43, 115; 
  44, 115; 
  45, 115; 
  55, 115; 
  56, 115; 
  57, 115; 
  87, 115; 
  88, 115; 
  89, 115; 
  90, 115; 
  91, 115; 
  7, 116; 
  12, 116; 
  13, 116; 
  45, 116; 
  46, 116; 
  47, 116; 
  51, 116; 
  52, 116; 
  53, 116; 
  54, 116; 
  86, 116; 
  87, 116; 
  88, 116; 
  89, 116; 
  90, 116; 
  7, 117; 
  12, 117; 
  13, 117; 
  14, 117; 
  15, 117; 
  16, 117; 
  17, 117; 
  18, 117; 
  19, 117; 
  20, 117; 
  21, 117; 
  47, 117; 
  48, 117; 
  49, 117; 
  50, 117; 
  51, 117; 
  52, 117; 
  53, 117; 
  76, 117; 
  86, 117; 
  87, 117; 
  88, 117; 
  89, 117; 
  90, 117; 
  8, 118; 
  15, 118; 
  16, 118; 
  17, 118; 
  18, 118; 
  19, 118; 
  20, 118; 
  21, 118; 
  77, 118; 
  87, 118; 
  88, 118; 
  89, 118; 
  90, 118; 
  91, 118; 
  8, 119; 
  9, 119; 
  13, 119; 
  14, 119; 
  15, 119; 
  16, 119; 
  17, 119; 
  18, 119; 
  19, 119; 
  20, 119; 
  21, 119; 
  22, 119; 
  23, 119; 
  77, 119; 
  88, 119; 
  89, 119; 
  90, 119; 
  91, 119; 
  9, 120; 
  15, 120; 
  16, 120; 
  17, 120; 
  18, 120; 
  19, 120; 
  20, 120; 
  21, 120; 
  22, 120; 
  23, 120; 
  24, 120; 
  76, 120; 
  77, 120; 
  89, 120; 
  90, 120; 
  91, 120; 
  9, 121; 
  15, 121; 
  16, 121; 
  17, 121; 
  18, 121; 
  19, 121; 
  20, 121; 
  21, 121; 
  22, 121; 
  23, 121; 
  24, 121; 
  25, 121; 
  75, 121; 
  76, 121; 
  88, 121; 
  89, 121; 
  90, 121; 
  91, 121; 
  10, 122; 
  15, 122; 
  16, 122; 
  17, 122; 
  18, 122; 
  19, 122; 
  20, 122; 
  21, 122; 
  22, 122; 
  23, 122; 
  24, 122; 
  25, 122; 
  75, 122; 
  89, 122; 
  90, 122; 
  91, 122; 
  10, 123; 
  11, 123; 
  16, 123; 
  17, 123; 
  18, 123; 
  19, 123; 
  20, 123; 
  21, 123; 
  22, 123; 
  23, 123; 
  24, 123; 
  25, 123; 
  26, 123; 
  74, 123; 
  75, 123; 
  91, 123; 
  16, 124; 
  17, 124; 
  18, 124; 
  19, 124; 
  20, 124; 
  21, 124; 
  22, 124; 
  23, 124; 
  24, 124; 
  25, 124; 
  26, 124; 
  27, 124; 
  73, 124; 
  74, 124; 
  90, 124; 
  91, 124; 
  16, 125; 
  17, 125; 
  18, 125; 
  19, 125; 
  20, 125; 
  21, 125; 
  22, 125; 
  23, 125; 
  24, 125; 
  25, 125; 
  26, 125; 
  27, 125; 
  72, 125; 
  73, 125; 
  89, 125; 
  90, 125; 
  91, 125; 
  16, 126; 
  17, 126; 
  18, 126; 
  19, 126; 
  20, 126; 
  21, 126; 
  22, 126; 
  23, 126; 
  24, 126; 
  25, 126; 
  26, 126; 
  27, 126; 
  28, 126; 
  29, 126; 
  71, 126; 
  72, 126; 
  89, 126; 
  90, 126; 
  91, 126; 
  17, 127; 
  18, 127; 
  19, 127; 
  20, 127; 
  21, 127; 
  22, 127; 
  23, 127; 
  24, 127; 
  25, 127; 
  26, 127; 
  27, 127; 
  28, 127; 
  29, 127; 
  70, 127; 
  71, 127; 
  89, 127; 
  90, 127; 
  91, 127; 
  18, 128; 
  19, 128; 
  20, 128; 
  21, 128; 
  22, 128; 
  23, 128; 
  24, 128; 
  25, 128; 
  26, 128; 
  27, 128; 
  28, 128; 
  29, 128; 
  30, 128; 
  31, 128; 
  32, 128; 
  69, 128; 
  70, 128; 
  89, 128; 
  90, 128; 
  91, 128; 
  19, 129; 
  20, 129; 
  21, 129; 
  22, 129; 
  23, 129; 
  24, 129; 
  25, 129; 
  26, 129; 
  27, 129; 
  28, 129; 
  29, 129; 
  30, 129; 
  31, 129; 
  68, 129; 
  69, 129; 
  71, 129; 
  89, 129; 
  16, 130; 
  17, 130; 
  19, 130; 
  20, 130; 
  21, 130; 
  22, 130; 
  23, 130; 
  24, 130; 
  25, 130; 
  26, 130; 
  27, 130; 
  28, 130; 
  29, 130; 
  30, 130; 
  31, 130; 
  32, 130; 
  33, 130; 
  34, 130; 
  67, 130; 
  68, 130; 
  70, 130; 
  71, 130; 
  89, 130; 
  20, 131; 
  22, 131; 
  23, 131; 
  24, 131; 
  25, 131; 
  26, 131; 
  27, 131; 
  28, 131; 
  29, 131; 
  30, 131; 
  31, 131; 
  32, 131; 
  33, 131; 
  34, 131; 
  47, 131; 
  48, 131; 
  49, 131; 
  51, 131; 
  52, 131; 
  66, 131; 
  67, 131; 
  70, 131; 
  71, 131; 
  88, 131; 
  89, 131; 
  19, 132; 
  20, 132; 
  23, 132; 
  24, 132; 
  25, 132; 
  26, 132; 
  27, 132; 
  28, 132; 
  29, 132; 
  30, 132; 
  31, 132; 
  32, 132; 
  33, 132; 
  34, 132; 
  35, 132; 
  36, 132; 
  37, 132; 
  38, 132; 
  39, 132; 
  41, 132; 
  47, 132; 
  48, 132; 
  49, 132; 
  51, 132; 
  52, 132; 
  64, 132; 
  65, 132; 
  66, 132; 
  67, 132; 
  71, 132; 
  88, 132; 
  25, 133; 
  26, 133; 
  27, 133; 
  28, 133; 
  29, 133; 
  30, 133; 
  31, 133; 
  32, 133; 
  33, 133; 
  34, 133; 
  35, 133; 
  36, 133; 
  37, 133; 
  38, 133; 
  39, 133; 
  40, 133; 
  45, 133; 
  46, 133; 
  47, 133; 
  48, 133; 
  49, 133; 
  50, 133; 
  51, 133; 
  52, 133; 
  53, 133; 
  55, 133; 
  56, 133; 
  57, 133; 
  61, 133; 
  62, 133; 
  63, 133; 
  67, 133; 
  70, 133; 
  71, 133; 
  88, 133; 
  89, 133; 
  90, 133; 
  91, 133; 
  25, 134; 
  26, 134; 
  27, 134; 
  28, 134; 
  29, 134; 
  30, 134; 
  31, 134; 
  32, 134; 
  33, 134; 
  34, 134; 
  35, 134; 
  36, 134; 
  37, 134; 
  38, 134; 
  39, 134; 
  40, 134; 
  41, 134; 
  42, 134; 
  43, 134; 
  44, 134; 
  45, 134; 
  46, 134; 
  47, 134; 
  48, 134; 
  49, 134; 
  50, 134; 
  51, 134; 
  52, 134; 
  53, 134; 
  54, 134; 
  55, 134; 
  56, 134; 
  57, 134; 
  58, 134; 
  59, 134; 
  60, 134; 
  67, 134; 
  70, 134; 
  89, 134; 
  26, 135; 
  27, 135; 
  28, 135; 
  29, 135; 
  30, 135; 
  31, 135; 
  32, 135; 
  33, 135; 
  34, 135; 
  35, 135; 
  36, 135; 
  37, 135; 
  38, 135; 
  39, 135; 
  40, 135; 
  41, 135; 
  42, 135; 
  43, 135; 
  44, 135; 
  45, 135; 
  46, 135; 
  47, 135; 
  48, 135; 
  49, 135; 
  50, 135; 
  51, 135; 
  52, 135; 
  53, 135; 
  55, 135; 
  56, 135; 
  57, 135; 
  58, 135; 
  59, 135; 
  70, 135; 
  89, 135; 
  26, 136; 
  38, 136; 
  39, 136; 
  40, 136; 
  41, 136; 
  42, 136; 
  43, 136; 
  44, 136; 
  45, 136; 
  46, 136; 
  47, 136; 
  48, 136; 
  49, 136; 
  51, 136; 
  52, 136; 
  53, 136; 
  54, 136; 
  55, 136; 
  56, 136; 
  57, 136; 
  58, 136; 
  59, 136; 
  61, 136];
  S = sparse(DOG(:,1), DOG(:,2), 1)';
end
%=============================================================================
