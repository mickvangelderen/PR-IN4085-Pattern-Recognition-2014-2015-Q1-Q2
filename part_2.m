extend_path

% Generate 10 random indices from 1 - 1000
selection = randperm(1000, 10);

% Extract images from prnist dataset
images = prnist(0:9, selection);

% Preprocess images
d = preprocess_rot_stretch(images);

% Train classifier
w = d*(pcam([], .8)*parzenc);

% Obtain classifier error rate
nist_eval('preprocess_rot_stretch', w, 100)