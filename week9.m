repetitions = 20;
clusters = 1:5;
x = 1:length(clusters);
y = zeros(1, length(clusters));
e = zeros(1, length(clusters));
for c = 1:length(clusters)
    LogLikelyhoods = zeros(1, repetitions);
    for n = 1:repetitions
        % repetition x clusters
        L = em(rnd, c, 'gauss', 0, 0, 0);
        LogLikelyhoods(n) = L;
    end
    y(c) = mean(LogLikelyhoods);
    e(c) = std(LogLikelyhoods);
end
errorbar(clusters, y, e)