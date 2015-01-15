extend_path;
images = prnist(0:9, 1:200);
d = preprocess_speckle_rot_box0_gauss0_stretch(images);
s = pcam(d, .9);
prcrossval(d*s, parzenc, 4);