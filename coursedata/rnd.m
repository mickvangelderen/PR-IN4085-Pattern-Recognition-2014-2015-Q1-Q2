%RND Random data with 200 objects in 2D
%
%     X = RND;
%
% Load a dataset without any clustering structure.
%
% SEE ALSO
% DATASETS

function a = rnd

prload('rnd.mat');
a = setname(a,'Random');

