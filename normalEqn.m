function [theta] = normalEqn(x, y)
%Computes the closed-form solution to linear regression 
theta = zeros(size(x, 2), 1);
%put the result in theta.
theta = inv(x'* x)*x'*y;
end