a = im_resize(prnist(0:9, 1:50));
t = im_resize(prnist(0:9, 51:200));

w = parzenc(a);

testc(t,w);t


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