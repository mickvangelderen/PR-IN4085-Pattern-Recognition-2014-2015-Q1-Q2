extend_path

% all_images  = im_fill_norm(prnist(0:9, 1:1000), 16, 0);
% d = prdataset(all_images);
% nclasses = length(d.lablist{1});

% === scaling vs no scaling before pca ===
% s = pcam(d*scalem(d, 'variance'), .99);
% e1 = clevalf(d, knnc([], 1), 1:10:size(s,2), ones(1, nclasses)*10, 3);
% s = pcam(d, .99);
% e2 = clevalf(d, knnc([], 1), 1:10:size(s,2), ones(1, nclasses)*10, 3);
% plote({e1,e2});
% legend({'scaling','no-scaling'});

nreps = 10;

classifiers = {ldc, knnc([], 1), parzenc, svc};
nclassifiers = length(classifiers);

performances = zeros(nreps, nclassifiers);
 
s = pcam(d, 30);
for i = 1:nreps
    % randomly pick 10 obj from all classes and put it in a, the rest in t
    [a, t] = gendat(d, ones(1, nclasses)*10);
    performances(i,:) = cell2mat(testc(t*s, a*s*classifiers));
    performances(i,:)
end

errorbar(1:nclassifiers, mean(performances), std(performances));
