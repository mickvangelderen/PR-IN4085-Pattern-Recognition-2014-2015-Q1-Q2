extend_path

all_images = im_fill_norm(prnist([0:9], 1:1000), 16, 0);
d = prdataset(all_images);
% [a, t] = gendat(d, 0.5);

% s = featsel(randperm(size(a, 2), 256));
% s = featsellr(a, 'maha-s', 60, 1, 0);
s = featsel([59 231 71 114 127 120 62 167 107 40 95 29 77 195 188 154 147 238 ...
       181 50 103 134 214 140 190 90 226 9 68 116 146 157 108 220 149 32 ...
       102 73 228 169 144 121 42 198 230 223 253 186 12 178 63 81 166 255 ...
       109 60 4 100 123 96 153 225 92 247 117 196 175 1 51 67 15 243 25 ...
       64 164 76 219 201 250 126 156 159 210 23 21 56 162 256 75 43 58 ...
       161 131 142 111 141 101 86 41 69]);
s2 = pcam(gendat(d, ones(1,10)*100), 100);
e1 = clevalf(d*s, knnc([], 1), 10:10:100);
e2 = clevalf(d*s2, knnc([], 1), 10:10:100);
e3 = clevalf(d*s, parzenc, 10:10:100);
e4 = clevalf(d*s2, parzenc, 10:10:100);

plote({e1,e2,e3,e4});
legend({'1-nn lr','1-nn pca','par lr','par pca'});
