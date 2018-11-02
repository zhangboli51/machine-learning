function [x_norm, mu, sigma] = featureNormalize(x)

x_norm = x;
mu = zeros(1,size(x,2));
sigma = zeros(1,size(x,2));

mu = mean(x);
sigma =std(x);

x_norm = (x - repmat(mu, [size(x,1),1]))./(repmat(sigma, [size(x,1),1]));

end