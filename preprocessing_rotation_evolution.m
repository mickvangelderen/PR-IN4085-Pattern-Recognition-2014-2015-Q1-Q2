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

mappings = ...
    { 'normal', im_fill_norm(train_images, side, .5) ...
    ; 'rotated without constraints', im_fill_norm(train_images*im_rot_norm(0, 360)*im_box(0), side, .5) ...
    ; 'rotated with constraints', im_fill_norm(train_images*im_rot_norm(.8, 50)*im_box(0), side, .5) ...
    ; 'rotated stretched', im_resize(train_images*im_rot_norm(.8, 50)*im_box(0), [side side], 'bicubic');
};

nsets = length(mappings);
sets = cell(nsets, 1);

for i = 1:length(mappings)
    sets{i} = prdataset(mappings{i,2});
end

o = zeros(ndigits*side, nreps*side);
for idigit = 1:ndigits
    for irep = 1:nreps
        for iset = 1:nsets
            d = sets{iset};
            pixels = +d((idigit - 1)*nreps + irep, :);
            pixels = reshape(pixels, [side, side]);
            y0 = ((idigit - 1)*nsets + iset - 1)*side;
            x0 = (irep - 1)*side;
            o(y0 + 1:y0 + side, x0 + 1:x0 + side) = pixels;
        end
    end
end

o = zeros(ndigits*side, nreps*side);
for idigit = 1:ndigits
    for irep = 1:nreps
        for iset = 1:nsets
            d = sets{iset};
            pixels = +d((idigit - 1)*nreps + irep, :);
            pixels = reshape(pixels, [side, side]);
            y0 = ((idigit - 1)*nsets + iset - 1)*side;
            x0 = (irep - 1)*side;
            o(y0 + 1:y0 + side, x0 + 1:x0 + side) = pixels;
        end
    end
end

imshow([o(1:320,:) o(321:end,:)]);

imwrite([o(1:320,:) o(321:end,:)], 'preprocessing_rotation_evolution.png');


