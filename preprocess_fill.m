% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_fill(images)
    a = prdataset(im_fill_norm(images, 16, 0));
end

