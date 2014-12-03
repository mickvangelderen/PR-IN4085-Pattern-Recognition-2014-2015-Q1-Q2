a = prdataset(im_resize(prnist([0:9], 1:200)));
t = prdataset(im_resize(prnist([0:9], 201:1000)));
% a = prdataset(im_resize(prnist([0 2:9], 1:200),[8 8]));
% t = prdataset(im_resize(prnist([0 2:9], 201:1000), [8 8]));
% 
% show(a)

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
% [pca_a, N] = pcam(a,200);
% [pca_t, N] = pcam(t,200);
% w = parzenc(a*pca_a);
% 
% testc(t*pca_t,w);

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
% 
% Results
%   Product combiner        0.062
%   Mean combiner           0.055
%   Median combiner         0.065
%   Maximum combiner        0.059
%   Minimum combiner        0.069
%   Voting combiner         0.065


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