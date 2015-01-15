% preprocess_rot_stretch
% for use with nist_eval
function a = preprocess_stretch(images)
    a = prdataset(im_resize(images, [16, 16], 'bicubic'));
end

