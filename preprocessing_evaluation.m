extend_path;

digits = 0:9;
ndigits = length(digits);
nreps = 10;
side = 16;

images = prnist(digits, 1:1000);
[ train_images ...
, test_images ...
, train_indices ...
, test_indices] = gendat(images, ones(1, ndigits)*nreps);
% 
% interesting_rotation = [4186 4284 7659 7458 8366];
% interesting_speckle = [1090 1248 5900 6002 6113 9945 9896 9890 9891];
% train_indices = [interesting_rotation interesting_speckle];
% train_images = images(train_indices);

nimages = length(train_images);

mappings = ...
    { 'unprocessed', im_fill_norm(train_images, side, 0) ...
    ; 'processed', im_resize(train_images*im_filter_speckles*im_rot_norm*im_gauss(1)*im_box(0), [side side], 'bicubic') ...
};

nsets = length(mappings);
sets = cell(nsets, 1);

for i = 1:length(mappings)
    sets{i} = prdataset(mappings{i,2});
end

out = zeros(nsets*side, nimages*side);
for iimage = 1:nimages
    outcol = (iimage - 1)*side + 1 : iimage*side;
    for iset = 1:nsets
        set = sets{iset};
        pixels = +set(iimage, :);
        pixels = reshape(pixels, [side, side]);
        outrow = (iset - 1)*side + 1 : iset*side;
        out(outrow, outcol) = pixels;
    end
end

%reshape to show digits below each other
out = cell2mat(mat2cell(out, [ nsets*side ], ones(1, 5)*2*ndigits*side)');

imshow(out);

imwrite(imresize(out, 4, 'box'), 'preprocessing_evaluation.png');



