% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_gauss0_stretch(images)
    images = images ...
        * im_filter_speckles;

    a = preprocess_stretch(images);
end

