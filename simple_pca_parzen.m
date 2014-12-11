extend_path;
images = prnist(0:9, 1:1000);
d = prdataset(im_fill_norm(images, 16, 0));
s = pcam(d, 25);
prcrossval(d*s, parzenc, 4);