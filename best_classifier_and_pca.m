extend_path

% classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc([], 1), parzenc};
classifiers = {ldc, qdc};
objects_per_class = 200;
max_error = 0.05;

% Get dataset, split into training and test
images = prnist(0:9, 1:1000);

% Use some preprocessing function
d = preprocess_fill(images);

err = [];
nfeatures = size(trn,2);
nclasses = length(d.lablist{1});    
    
[trn, tst] = gendat(d, ones(1, nclasses) * objects_per_class);

for pca_size = 1:20:nfeatures
    u = pcam([], pca_size) * classifiers; % no scaling
    w = trn * u;
    e = tst * w * testc;

    err = [err; pca_size e];
end

% Make graph with errors of different classifiers plotted against the PCA
% components
plot(err(:,1), err(:,2:end));
line([1 nfeatures], [max_error max_error]);

 % errorbar(1:40:nfeatures, mean(err,3), std(err,0,3))
% errorbar(1:nclassifiers, mean(err), std(err));
% legend('nmc', 'ldc', 'qdc', 'fisherc', 'loglc', '1-NN', 'parzenc');

% 
% images = prnist(0:9, 1:100);
% d = preprocess_fill(images);
% nclasses = length(d.lablist{1});
% 
% % === scaling vs no scaling before pca ===
% % s = pcam(d*scalem(d, 'variance'), .99);
% % e1 = clevalf(d, knnc([], 1), 1:10:size(s,2), ones(1, nclasses)*10, 3);
% % s = pcam(d, .99);
% % e2 = clevalf(d, knnc([], 1), 1:10:size(s,2), ones(1, nclasses)*10, 3);
% % plote({e1,e2});
% % legend({'scaling','no-scaling'});
% 
% nreps = 10;
% 
% classifiers = {ldc, knnc([], 1), parzenc, svc};
% nclassifiers = length(classifiers);
% 
% performances = zeros(nreps, nclassifiers);
% 
% s = pcam(d, 30);
% for i = 1:nreps
%     % randomly pick 10 obj from all classes and put it in a, the rest in t
%     [a, t] = gendat(d, ones(1, nclasses)*10);
%     performances(i,:) = cell2mat(testc(t*s, a*s*classifiers));
%     performances(i,:)
% end
% 
% errorbar(1:nclassifiers, mean(performances), std(performances));
