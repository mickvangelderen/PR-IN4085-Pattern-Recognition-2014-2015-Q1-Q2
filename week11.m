extend_path;

prwaitbar on
prwarning off

% a = gendatd(100, 10);
% 
% [w, r] = featself(a, ldc, 0, 4);
% 

[a t] = gendat(diabetes, 0.5);

selections = nchoosek(1:8, 1);

nselections = length(selections);
nrepetitions = 2;

performances = zeros(nselections, nrepetitions);

for s = 1:nselections
    data = featsel(diabetes, selections(s, :));
    for r = 1:nrepetitions
        [a, t] = gendat(data, 0.5);
        performances(s, r) = testc(t, a*fisherc);
    end
end

means = mean(performances');
stds = std(performances');

errorbar(1:nselections, means, stds);

[error, index] = min(means);

selections(index, :)
error

