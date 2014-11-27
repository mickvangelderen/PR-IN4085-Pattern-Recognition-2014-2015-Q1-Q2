d = 5;
clusters = [ 1, 2, 3, 5, 10, 20, 40, 50, 100 ];
WSJES = zeros(10, length(clusters));
for n = 1:10
    a = +gendats([50, 50], 2, d);
    for i = 1:length(clusters)
        [ P, labs, WS ] = kmclust(a, clusters(i), 0, 0);
        WSJES(n, i) = WS;
    end
    WSJES(n, :) = WSJES(n, :)/WSJES(n, 1);
end
err = zeros(1, 9);
y = zeros(1, 9);
for n = 1:9
    y(n) = mean(WSJES(:, n));
    err(n) = std(WSJES(:, n));
end
errorbar(clusters, y, err)