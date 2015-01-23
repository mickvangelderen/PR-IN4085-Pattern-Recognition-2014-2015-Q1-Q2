% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_speckle_rot_box0_gauss4_stretch(images)
    images = images ...
        * im_filter_speckles(4) ...
        * im_rot_norm ...
        * im_box(0) ...
        * im_gauss(4);

	a = preprocess_stretch(images);
end