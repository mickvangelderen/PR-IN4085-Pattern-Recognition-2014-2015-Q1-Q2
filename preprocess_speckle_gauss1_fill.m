% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_gauss1_fill(images)
    images = images ...
        * im_filter_speckles ...
        * im_gauss(1);

    a = preprocess_fill(images);
end

