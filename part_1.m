extend_path

prmemory = 10*50000000;

train_fraction = .2;

digits = 0:9;
ndigits = length(digits);

% Extract all images from prnist dataset
images = prnist(digits, 1:1000);

% Preprocess images
processed = preprocess_speckle_rot_box0_gauss1_stretch(images);

classifiers = ...
    { pcam([], .85)*ldc ...
    ; pcam([], .85)*qdc ...
    ; pcam([], .85)*knnc([], 1) ...
    ; pcam([], .85)*parzenc ...
};
nclassifiers = length(classifiers);

% Obtain classifier error rates
errors = cell(5, nclassifiers);
for i = 1:5
    fprintf('Round %d', i);
    a = gendat(processed, ones(1, ndigits)*500);
    for iclassifier = 1:nclassifiers
        w = classifiers{iclassifier};
        errors{i, iclassifier} = nist_eval('preprocess_speckle_rot_box0_gauss1_stretch', a*w, 100);
    end
    errors(i,:)
end

errors = cell2mat(errors);

hold on;
for i = 1:nclassifiers
    y = mean(errors);
    bar(y);
end
errorbar(mean(errors), std(errors), '.');
legend('ldc', 'qdc', '1-NN', 'parzenc');


