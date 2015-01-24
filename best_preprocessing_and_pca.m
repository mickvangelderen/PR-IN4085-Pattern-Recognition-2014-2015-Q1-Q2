extend_path

digits = 0:9;
images = prnist(digits, 1:200);
classifiers = {parzenc, qdc, knnc([],1)};

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

err = [];

    for cname = preprocessing_functions
        name = cname{1};
        func = str2func(name);
        a = func(images);
        
        for pca_size = pca_sizes
            u = pcam([], pca_size) * classifiers; % no scaling
            w = trn * u;
            e = tst * w * testc;
            err = [err; pca_size cname e];
        end
    end