extend_path

% get NIST digit images as prdatafile
images = prnist(0:9, 1:1000);
% remove speckles with area < 4
images = images*im_filter_speckles(4);

d = prdataset(im_resize(images*im_rot_norm*im_box(1)*im_gauss, [16 16]));

% crossval pcam 25, 4 folds, 10000 objs gave 0.023 error rate
prcrossval(d*pcam(d, 30), parzenc, 2)

