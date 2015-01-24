% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_gauss0_fill(images)
    images = images ...
        * im_filter_speckles;

    a = preprocess_fill(images);
end

