%% start of program
clc
close all
format short

%% algoritm parameter
Aineq = [1, 1; -1, 2; 2, 1];
bineq = [2; 2; 3];
Aeq = [1, 2; 3, 4];
beq = [-5, -10];
lb = [-10; -5];
ub = [10; 15];

%% calculate
[x, fval] = ga(@function_one, 2, Aineq, bineq, Aeq, beq, lb, ub, [], []);

%% display
disp(['x1=', num2str(x(1))])
disp(['x2=', num2str(x(2))])
disp(['Fitness value=', num2str(fval)])