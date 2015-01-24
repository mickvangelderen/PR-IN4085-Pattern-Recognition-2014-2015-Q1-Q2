extend_path

% Generates one figure with all information
% classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc([], 1), parzenc};
% preprocessing_functions = { ...
%     'preprocess_speckle_gauss0_fill', ...
%     'preprocess_speckle_gauss0_stretch', ...
%     'preprocess_speckle_gauss1_fill', ...
%     'preprocess_speckle_gauss2_fill', ...
%     'preprocess_speckle_gauss4_fill', ...
%     'preprocess_speckle_rot_box0_gauss0_stretch', ...
%     'preprocess_speckle_rot_box0_gauss1_stretch', ...
%     'preprocess_speckle_rot_box0_gauss2_stretch', ...
%     'preprocess_speckle_rot_box0_gauss4_stretch' ...
% };
classifiers = {qdc};
preprocessing_functions = { ...
    'preprocess_speckle_gauss0_fill'};
objects_per_class = 10;
max_error = 0.25;
nrep = 2;
pca_sizes = 1:10:100;
images = prnist(0:9, 1:1000);

err = [];
nclassifiers = length(classifiers);
npreprocessing = length(preprocessing_functions);
nclasses = length(images)/1000;    

for pre_pr_func_idx = 1:length(preprocessing_functions)
    cname = preprocessing_functions(pre_pr_func_idx);
    name = cname{1};
    func = str2func(name);
    a = func(images);

%     for n = 1:nrep
        [trn, tst] = gendat(a, ones(1, nclasses) * objects_per_class);

        nfeatures = size(trn,2);
        nclassifiers = size(classifiers,2);

        for pca_size = pca_sizes
            u = pcam([], pca_size) * classifiers; % no scaling
            w = trn * u;
            e = tst * w * testc;

            for i = 1:size(e,2)
                err(pca_size, pre_pr_func_idx, i) = e(i);
            end
        end
%     end
end

% Covert error matrix to a more matlab style-array
means = [];

for pca_size = pca_sizes
    means = [means; pca_size reshape(err(pca_size,:,:), [1 nclassifiers * npreprocessing])];
end

% for pca_size = pca_sizes
%     means = [means; pca_size reshape(mean(err(pca_size,:,:,:),3), [1 nclassifiers * npreprocessing])];
%     stds  = [stds; pca_size reshape(std(err(pca_size,:,:,:),0,3), [1 nclassifiers * npreprocessing])];
% end

legend_str = [];
for class_name = arrayfun(@(x) getname(x), classifiers)
    for pr_fn_name = preprocessing_functions
        legend_str = [legend_str; strcat(class_name, '--', pr_fn_name)];
    end
end

hold on;
    plot(means(:,1), means(:,2:end))
%     errorbar(repmat(pca_sizes,nclassifiers*npreprocessing,1)', means(:,2:end), stds(:,2:end))
    plot([min(means(:,1)) max(means(:,1))], [max_error max_error], ':b');
    legend(legend_str, 'Interpreter', 'none');
    axis([min(pca_sizes) max(pca_sizes) 0 1]);
    gca.XTick = min(pca_sizes):10:max(pca_sizes);
    xlabel('Number of PCA Components');
    ylabel('Classification error');
hold off;
