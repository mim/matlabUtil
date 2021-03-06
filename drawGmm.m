function [Y,z] = drawGmm(mu, sigSq, p, N)

% [Y,z] = drawGmm(mu, sigSq, p, N)
%
% Draw N samples from a mixture of N Gaussians.  In the multivariate
% case, mu is a matrix where each row is the mean of one Gaussian.
% SigSq is a 3D matrix such that sigSq(:,:,i) is the covariance of the
% ith Gaussian.  In the univariate case, mu(i) is the mean and
% sigSq(i) is the variance of the ith Gaussian.

% Copyright (C) 2005 Michael Mandel, mim at ee columbia edu;
% distributable under GPL

% Y ~ sum[ p_i * N(mu_i, sigma_i) ]

[tD,D] = size(mu);
if(tD == 1) D=1; end

z = drawMultinom(repmat(p(:), 1, N));

if(D == 1)
  Y = randn(1,N).*sqrt(sigSq(z)) + mu(z);
else
  for i=1:length(p)
    inClass = find(z == i);
    n = numel(inClass);
    [u,s,v] = svd(sigSq(:,:,i));
    sig = sqrt(s)*v';
    Y(inClass,:) = randn(n,D) * sig + repmat(mu(i,:), n, 1);
  end
end
