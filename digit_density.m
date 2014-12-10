extend_path

digits = 0:9; ndigits = length(digits);
pixels = [96+1:96+16]; npixels = length(pixels);

% http://nl.mathworks.com/help/matlab/ref/histcounts.html
for d = 1:ndigits
        a = +prdataset(im_fill_norm(prnist(d, 1:100), 16, 0));
        for p = 1:npixels
            subplot(ndigits, npixels, npixels*(d - 1) + p);
            hist(a(:, pixels(p)), (1:10)/10);
        end
end