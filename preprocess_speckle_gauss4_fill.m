% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_gauss4_fill(images)
    images = images ...
        * im_filter_speckles(20) ...
        * im_gauss(4);

    a = preprocess_fill(images);
end

