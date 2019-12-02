%% start of program
clc
close all
format short

%% algoritm parameter
xmax = [11, 12];
xmin = [-2, -3];
Dpop = length(xmax);
Npop = 20;
npop = Npop / 2;
maxit = 50;
for i = 1:Npop
    pop(i, :) = xmin + rand(1, Dpop) .* [xmax - xmin];

    p_costt(i, 1) = function_two([pop(i, :)]);
end
p_cost = sortrows([pop, p_costt], Dpop+1);
Gbestcost = inf;

%% main loop
for j = 1:maxit
    p_costt = p_cost(1:npop, Dpop+1);

    pop = p_cost(1:npop, 1:Dpop);

    F = abs(p_costt-p_cost(npop, Dpop+1));

    FF = sum(F);

    p = F / FF;

    c(1, 1) = p(1, 1);
    for i = 2:npop
        c(i, 1) = c(i-1, 1) + p(i, 1);
    end

    %% FATHER , MOTHER & CHILD
    n1 = 1;
    n2 = 1;
    n3 = 1;
    for i = 1:npop
        if c(i, 1) > rand
            popfather(n1, :) = pop(i, :);
            L(n1, 1) = i;
            n1 = n1 + 1;
            if n1 > npop / 2
                break
            end
        end
    end
    for i = 1:npop
        if i ~= L(n3, 1)
            popmother(n2, :) = pop(i, :);
            n2 = n2 + 1;
            n3 = n3 + 1;
            if n3 > npop / 2
                break
            end
        end
    end
    popfather_mut = popfather + rand(npop/2, 2) .* (popmother - popfather);
    popmother_mut = popmother + rand(npop/2, 2) .* (popfather - popmother);
    crossover = .9;
    for i = 1:Dpop
        if crossover > rand
            popchild1(:, i) = popfather_mut(:, i);
        else
            popchild1(:, i) = popfather(:, i);
        end
    end
    for i = 1:Dpop
        if crossover > rand
            popchild2(:, i) = popmother_mut(:, i);
        else
            popchild2(:, i) = popmother(:, i);
        end
    end
    pop_new = [popchild1; popchild2];
    o = floor((npop * rand / 2)+5);
    pop_new(o, :) = pop_new(o, :) .* rand(1, Dpop);
    %pop_new(o,:)=pop_new(o,:).*rand(1,1:Dpop);
    for i = 1:npop
        p_cost_new(i, 1) = function_two([pop_new(i, :)]);
    end
    p_cost = sortrows([pop_new, p_cost_new], Dpop+1);
    gbestcost = p_cost(1, Dpop+1);
    if gbestcost < Gbestcost
        Gbestcost = gbestcost;
    end
    %disp(['gbest= ' num2str(p_cost(1,1:2))]);
    disp(['Iteration ', num2str(j), ':   Best Cost = ', num2str(Gbestcost)]);
    l1(j, 1) = j;
    l2(j, 1) = Gbestcost;

end

%% final result
result = [l1, l2];
pop_new(1, 1:2)
plot(l1, l2);
hold on
xlim([1, 20])
