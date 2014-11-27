extend_path

a = im_resize(prnist(0:9, 1:200));

w = ldc(a);

mats = []; % mean digit images
imats = []; % upper 0.3 grayscale of mean digit images
for i = 1:10
    data = +w;
    mat = reshape(data.mean(i,:), 16, 16);
    mats = [ mats, mat ];
    imats = [ imats, mat2gray(mat, [ .7, 1 ]) ];
end
show([ mats ; imats ]);