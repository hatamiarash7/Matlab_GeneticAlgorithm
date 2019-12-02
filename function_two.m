function cost = function_two(x)
    x1 = x(1, 1);
    x2 = x(1, 2);
    % cost = 20 + x1.^2 + x2.^2 - 10 * (cos(2*pi*x1) + cos(2*pi*x2)) + 21.3182;
    % cost = (x1).^2 + (x2).^2;
    cost = x1^4 + x2^2 + 204.5910264;
end