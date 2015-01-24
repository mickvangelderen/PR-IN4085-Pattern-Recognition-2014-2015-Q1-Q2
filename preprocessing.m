extend_path

% get NIST digit images as prdatafile
images = prnist(0:9, 1:20);
% remove speckles with area < 4
images = images*im_filter_speckles(20);

da = prdataset(im_fill_norm(images, 16, 0));
db = prdataset(im_fill_norm(images*im_rot_norm*im_box(0), 16, 0));
dc = prdataset(im_resize(images*im_rot_norm*im_box(0), [16 16]));
dd = prdataset(im_resize(images*im_rot_norm*im_box(1)*im_gauss, [16 16]));

d = {da db dc dd};
[a, t] = gendat(d, 1/4);
for i = 1:length(d)
    s = pcam(d{i}, .90);
    testc(t{i}, a{i}*{parzenc, knnc, svc})
    testc(t{i}*s, a{i}*s*{parzenc, knnc, svc})
end
