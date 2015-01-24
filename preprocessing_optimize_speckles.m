extend_path;

prwaitbar off
prwarning off

digits = 0:9;
ndigits = length(digits);
train_fraction = 0.2;
side = 16;

images = prnist(digits, 1:1000);
[ train_images ...
, test_images ...
, train_indices ...
, test_indices] = gendat(images, train_fraction);

mappings = { ...
    ; 'speckles < 1', im_filter_speckles(1)*im_box(0) ...
    ; 'speckles < 2', im_filter_speckles(2)*im_box(0) ...
    ; 'speckles < 4', im_filter_speckles(4)*im_box(0) ...
    ; 'speckles < 8', im_filter_speckles(8)*im_box(0) ...
    ; 'speckles < 16', im_filter_speckles(16)*im_box(0) ...
    ; 'speckles < 32', im_filter_speckles(32)*im_box(0) ...
};
nmappings = length(mappings);

errors = zeros(nmappings, 1);
for i = 1:nmappings
    a = prdataset(im_fill_norm(train_images * mappings{i, 2}, side, 0));
    t = prdataset(im_fill_norm(test_images * mappings{i, 2}, side, 0));
    w = pcam([], .9)*parzenc;
    errors(i) = testc(t, a*w);
    errors(i)
end

a = prdataset(im_fill_norm(train_images, side, 0));
t = prdataset(im_fill_norm(test_images, side, 0));
w = pcam([], .9)*parzenc;
identityError = testc(t, a*w)

[bestError, bestIndex] = min(errors)
bestTitle = mappings{bestIndex, 1}

errorsEccRot = errors;

errorsImg = (errorsEccRot - min(errors))./(max(errors) - min(errors));
imshow(imresize(errorsImg, 20, 'box'));

imwrite(imresize(errorsImg, 20, 'box'), 'preprocessing_optimize_speckles.png');



