% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_gauss2_fill(images)
    images = images ...
        * im_filter_speckles ...
        * im_gauss(2);

    a = preprocess_fill(images);
end

