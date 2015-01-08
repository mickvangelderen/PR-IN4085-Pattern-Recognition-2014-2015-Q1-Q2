% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_fill(images)
    images = images ...
        * im_filter_speckles(4) ...
        * im_filter_gauss(1);

    a = prdataset(im_fill_norm(images, 13, 0));
end

