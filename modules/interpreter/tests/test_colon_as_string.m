%=============================================================================
% Copyright (c) 2016-present Allan CORNET (Nelson)
%=============================================================================
% This file is part of the Nelson.
%=============================================================================
% LICENCE_BLOCK_BEGIN
% SPDX-License-Identifier: LGPL-3.0-or-later
% LICENCE_BLOCK_END
%=============================================================================
A = [ 1 2 3; 4 5 6; 7 8 9];
R = A(':');
REF = A(:);
assert_isequal(R, REF);
REF2 = [1; 4; 7; 2; 5; 8; 3; 6; 9];
assert_isequal(R, REF2);
%=============================================================================
R = A(2,':');
REF = A(2, ':');
assert_isequal(R, REF);
%=============================================================================
R = A(':', 3);
REF = A(:, 3);
assert_isequal(R, REF);
%=============================================================================
R = A(':', ':');
REF = A(:, :);
assert_isequal(R, REF);
%=============================================================================
R = A(':', ':', ':');
REF = A(:, :, :);
assert_isequal(R, REF);
%=============================================================================
addpath([nelsonroot(), '/modules/interpreter/tests']);
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_istrue(compare_colon(1, A{:}));
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_istrue(compare_colon(2, A{1, ':'}));
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_istrue(compare_colon(3, A{':', 2}));
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_istrue(compare_colon(4, A{':', ':'}));
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_istrue(compare_colon(5, A{':', ':', ':'}));
%=============================================================================
A = [ 1 2 3; 4 5 6; 7 8 9];
A(1,':') = [];
assert_isequal(A, [4 5 6; 7 8 9]);
%=============================================================================
A = [ 1 2 3; 4 5 6; 7 8 9];
A(':', 2) = [];
assert_isequal(A, [ 1 3; 4 6; 7 9]);
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
assert_checkerror('A{'':''} = [];',_('Not enough right hand side values to satisy left hand side expression.'));
%=============================================================================
A = [ 1 2 3; 4 5 6; 7 8 9];
A(':',1) = [10; 11; 12];
REF =[ 10 2 3; 11 5 6; 12 8 9];
assert_isequal(A, REF);
%=============================================================================
A = [ 1 2 3; 4 5 6; 7 8 9];
A(2,':') = [10; 11; 12]
REF =[     1     2     3;
10    11    12
7     8     9];
assert_isequal(A, REF);
%=============================================================================
A = { 1 2 3; 4 5 6; 7 8 9};
A(':',1) = {10; 11; 12};
REF = { 10 2 3; 11 5 6; 12 8 9};
assert_isequal(A, REF);
%=============================================================================