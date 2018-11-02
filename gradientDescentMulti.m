function [theta, J_history] = gradientDescentMulti(x, y, theta, alpha, num_iters)
 m = length(y); % number of training examples 
    J_history = zeros(num_iters, 1); 
    feature_number = size(x,2); 
    temp = zeros(feature_number,1); 
    for iter = 1:num_iters 
 
        for i=1:feature_number 
            temp(i) = theta(i) - (alpha / m) * sum((x * theta - y).* x(:,i)); 
        end 
        for j=1:feature_number 
            theta(j) = temp(j); 
        end 
      
        J_history(iter) = computeCostMulti(x, y, theta); 
 
    end 
 
end 