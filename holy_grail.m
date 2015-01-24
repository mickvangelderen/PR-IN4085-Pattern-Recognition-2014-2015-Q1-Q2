% extend_path

% Generates one figure with all information
classifiers = { ...
%     nmc, ...
    ldc, ...
%     qdc, ...
%     fisherc, ...
%     loglc, ...
%     knnc([], 1), ...
%     parzenc ...
    };
preprocessing_functions = { ...
    'preprocess_speckle_gauss0_fill', ...
    'preprocess_speckle_gauss0_stretch', ...
    'preprocess_speckle_gauss1_fill', ...
    'preprocess_speckle_gauss2_fill', ...
    'preprocess_speckle_gauss4_fill', ...
    'preprocess_speckle_rot_box0_gauss0_stretch', ...
    'preprocess_speckle_rot_box0_gauss1_stretch', ...
    'preprocess_speckle_rot_box0_gauss2_stretch', ...
    'preprocess_speckle_rot_box0_gauss4_stretch' ...
};
objects_per_class = 10;
max_error = 0.25;
nrep = 4;
pca_sizes = 20:10:60;
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

    for n = 1:nrep
        [trn, tst] = gendat(a, ones(1, nclasses) * objects_per_class);

        nfeatures = size(trn,2);
        nclassifiers = size(classifiers,2);

        for pca_size = pca_sizes
            u = pcam([], pca_size) * classifiers; % no scaling
            w = trn * u;
            e = tst * w * testc;

            for i = 1:size(e,2)
                err(pca_size, pre_pr_func_idx, i, n) = e(i);
            end
        end
    end
end

% Covert error matrix to a more matlab style-array
means = [];
stds = [];

for pca_size = pca_sizes
    means = [means; pca_size reshape(mean(err(pca_size,:,:,:),4), [1 nclassifiers * npreprocessing])];
    stds  = [stds; pca_size reshape(std(err(pca_size,:,:,:),0,4), [1 nclassifiers * npreprocessing])];
end

% Create a legend
legend_str = [];
for class_name = arrayfun(@(x) getname(x), classifiers)
    for pr_fn_name = preprocessing_functions
        legend_str = [legend_str; strcat(class_name, '--', pr_fn_name)];
    end
end

hold on;
    errorbar(repmat(pca_sizes,nclassifiers*npreprocessing,1)', means(:,2:end), stds(:,2:end))
    plot([min(means(:,1)) max(means(:,1))], [max_error max_error], ':b');
    legend(legend_str, 'Interpreter', 'none');
    axis([min(pca_sizes) max(pca_sizes) 0 1]);

    xlabel('Number of PCA Components');
    ylabel('Classification error');
hold off;
