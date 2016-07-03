
function [M, s, si] = countrate(data, cdata)

[s, si] = sort(data);

ai = si <= cdata(1);
ni = ~ai;

indx = 1 : length(s);
indx = indx(diff(s) ~= 0);
indx = [indx, length(s)];

M = zeros(2, length(indx));

ac = cumsum(ai);
nc = cumsum(ni);

M(1, :) = diff([0; ac(indx)]);
M(2, :) = diff([0; nc(indx)]);

end
