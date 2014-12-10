a = prdataset(im_gauss(im_fill_norm(prnist(0:9, 1:500), 16, 0)));
t = prdataset(im_gauss(im_fill_norm(prnist(0:9, 501:1000), 16, 0)));

% u = scalem([], 'variance') * pcam([], 0.9) * knnc([],1);
% w = a*u;
% err = t*w*testc;

w = scalem(a, 'variance') * pcam(a, 0.95) * parzenc;
[ERR,STDS] = prcrossval(a, w, 10, 3);

% error = t *  * testc;

% testc(t, a*parzenc);

% e = cleval(a, parzenc, 1:100:500, 5);
% [ERR,STDS] = prcrossval(a, scalem([], 'variance') * pcam([], 0.95) * parzenc, 4, 3);

% t = prdataset(im_fill_norm(prnist([0:9], 501:1000), 16, 0));
% a = prdataset(im_resize(prnist([0 2:9], 1:200),[8 8]));
% t = prdataset(im_resize(prnist([0 2:9], 201:1000), [8 8]));
% 
% show(a)
% error = [];

% for i = 1:10
%     [a,t] = gendat(data, 0.5);
%     u = scalem([], 'variance') * pcam([], 0.9) * qdc;%adaboostc([], qdc, 10);
%     w = a*u;
%     err = t*w*testc;
%     error = [error; err];
% end
% 
% errorbar(mean(error), std(error,0,2))

% [ERR,STDS] = prcrossval(a, scalem([], 'variance') * pcam([], 0.9) * qdc, 10, 5);

% cleval(a, scalem([], 'variance') * pcam([], 0.9) * qdc, 200:20:500, t)

% [w,n] = pcam(a, 0.90);

% confmat(t*w);

% u = scalem([], 'variance') * pcam([], 0.9) * adaboostc([], qdc, 10);
% e = cleval(a, u, 200:50:500, 5);
% plote(e)



% Show densities
% for i = 0:9
%     a = prdataset(im_fill_norm(prnist(i, 1:200), 16, 0));
%     figure;
% 
%     for px = 1:256
%       subplot(16,16,px);
%       ksdensity(mean(+a(:,px)));  
%     end
% end

% figure;
% 
% for px = 1:20:256    
%     subplot(5,3,ceil(px/20));
%     hold on;
% 
%     for digit = 0:9
%       a = prdataset(im_fill_norm(prnist(digit, 1:200), 16, 0));
%       
%       hist(+a(:,px), 10);
%       
%     end
%     hold off;
% end

% legend('0','1','2','3','4','5','6','7','8','9');

% knnc
%w = knnc(a,1);
%testc(t,w);

% NN
%[W,HIST] = bpxnc(a,[300 300]);
%testc(t,W);

% SVM
% [w,J] = a*svc(proxm('p',3));
% testc(t,w);
% e = cleval(a, svc(proxm('p',3)), 1:10:200);
% plote(e);

% Parzen
% w = parzenc(a);
% testc(t,w);
% e = cleval(a, parzenc, 1:10:200);
% plote(e);

% PCA
% pca_err = [];
% 
% for i = 5:5:256
%     [pca_a, N] = pcam(a,i);
%     [pca_t, N] = pcam(t,i);
%     w = parzenc(a*pca_a);
%     
%     pca_err = [pca_err; i testc(t*pca_t,w)];
% end

% Combining Classifiers
% W = {parzenc,knnc([],1),svc(proxm('p',3)),bpxnc([],[300 300])};
% 
% % Train them all
% V = a*W;
% % Test them all
% disp([newline 'Errors for individual classifiers'])
% testc(t,V);
% % Construct combined classifier
% VALL = [V{:}];
% % Define combiners
% WC = {prodc,meanc,medianc,maxc,minc,votec};
% % Combine (result is cell array of combined classifiers)
% VC = VALL * WC;
% % Test them all
% disp([newline 'Errors for combining rules'])
% testc(t,VC)

% Results
%   Product combiner        0.062 - 0.063
%   Mean combiner           0.055 - 0.051
%   Median combiner         0.065 - 0.057
%   Maximum combiner        0.059 - 0.062
%   Minimum combiner        0.069 - 0.072
%   Voting combiner         0.065 - 0.063


% Forward Feature selection met maha dist
% [W R] = featself(a, 'maha-m', 0, t);
% w = parzenc(a*W);

% E = clevalf(a,parzenc,[10:20:250],0.7,25);
% 
% plote(E);

% a = prnist(0:5, 1:50);
% t = prnist(0:5, 51:100);
% 
% featuresa = im_features(a);
% featurest = im_features(t);
% 
% frank = featrank(featuresa,parzenc,featurest)
% f = find(frank < 3);
% 
% w = fisherc(featuresa(:,f));
% 
% % scatterd(featuresa(:,f))
% % plotc(w);
% 
% testc(featurest(:,f),w);

% 
% w = parzenc(features);
% 
% res = testc(t,w)

% data = features(:,1);

% for i = 1:24
%     figure;
%     scatterd(features(:,i))
% end

% im_features(a(1))
% scatterd(features(:,[13 18]))
% plotc(parzenc(features(:,[13 18])))