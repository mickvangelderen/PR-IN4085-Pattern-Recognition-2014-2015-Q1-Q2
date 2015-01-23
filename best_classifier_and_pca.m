extend_path

classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc([], 1), parzenc};
objects_per_class = 200;
max_error = 0.05;
nrep = 2;
pca_sizes = [1 10 20 30 40 50 60 80 100 150 200 256];

% Get dataset, split into training and test
images = prnist(0:9, 1:1000);

% Use some preprocessing function
d = preprocess_fill(images);

err = [];
nfeatures = size(trn,2);
nclasses = length(d.lablist{1});    
nclassifiers = size(classifiers,2);

for n = 1:nrep
    [trn, tst] = gendat(d, ones(1, nclasses) * objects_per_class);

    for pca_size = pca_sizes
        u = pcam([], pca_size) * classifiers; % no scaling
        w = trn * u;
        e = tst * w * testc;
    
        for i = 1:size(e,2)
            err(pca_size, i, n) = e(i);
        end
    end
end

% Covert error matrix to a more matlab style-array
means = [];
stds = [];

for pca_size = pca_sizes
    means = [means; pca_size mean(err(pca_size,:,:),3)];
    stds  = [stds; pca_size std(err(pca_size,:,:),0,3)];
end

hold on;
    errorbar(repmat(pca_sizes,nclassifiers,1)', means(:,2:end), stds(:,2:end))
    legend('nmc', 'ldc', 'qdc', 'fisherc', 'loglc', '1-NN', 'parzenc');
    
    plot([min(means(:,1)) max(means(:,1))], [max_error max_error], ':b');
    
    axis([min(pca_sizes) max(pca_sizes) 0 1]);
    xlabel('Number of PCA Components');
    ylabel('Classification error');
hold off;
