function [X_VS,Y_VS,Alpha_VS,c,code_retour] = SVM_3_souple(X,Y,sigma,lambda)

    % Définition du seuil
    seuil = 10^-6;
    
    % lisibilité
    n = length(Y);

    % Définition des vecteurs pour quadprog
    f = - ones(n,1);
    Aeq = Y';
    beq = 0;
    UB = lambda * ones(n,1);

    H = zeros(n, n);
    for i = 1:n
        for j = 1:n
            normeDifference = (X(i,:) - X(j,:)) * (X(i,:) - X(j,:))';
            H(i, j) = Y(i) * exp( -1 * (normeDifference) / (2 * sigma^2)) * Y(j);
        end 
    end

    
    [alpha, ~, code_retour] = quadprog(H, f, [], [], Aeq, beq, zeros(n,1), UB);
    
    condition = (alpha > seuil);
    X_VS = X(condition,:);
    Y_VS = Y(condition);
    Alpha_VS = alpha(condition);
    
    condition_lambda = (Alpha_VS < lambda-seuil);
    X_Lambda = X_VS(condition_lambda, :);
    Y_Lambda = Y_VS(condition_lambda);

    X_VS_plusun = X_Lambda(Y_Lambda == 1,:);
    Xi = X_VS_plusun(1, :);
    

    c = 0;
    for j = 1:length(X_VS)
        normeDifference = (X_VS(j,:) - Xi) * (X_VS(j,:) - Xi)';
        c = c + Alpha_VS(j) * Y_VS(j) * exp( -1 * (normeDifference) / (2 * sigma^2));
    end
    c = c - 1;

end

