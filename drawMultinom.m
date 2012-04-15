function x = drawMultinom(p)

% x = drawMultinom(p)
%
% Draw size(p,2) samples from a multinomial distribution where the
% elements [1..size(p,1)] have probabilities p.  There should be a way
% to do it without the repmats...

% Copyright (C) 2005 Michael Mandel, mim at ee columbia edu;
% distributable under GPL


p = cumsum(p);
pmax = max(max(p))+1;
u = repmat(rand(1,size(p,2)).*p(end,:), size(p,1), 1);
m = (u < p) .* (pmax-p);
x = argmax(m);
