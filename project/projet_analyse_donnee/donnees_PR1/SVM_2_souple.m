function [X_VS, w, c, code_retour] = SVM_2_souple(X,Y,lambda)
    % Définition du seuil
    seuil = 10^-6;
    
    % lisibilité
    n = length(Y);

    % Définition des vecteurs pour quadprog
    f = - ones(n,1);
    UB = lambda * ones(n,1);
    Aeq = Y';
    beq = 0;
    H = (diag(Y) * X) * (diag(Y) * X)';
    
    [alpha, ~, code_retour] = quadprog(H, f, [], [], Aeq, beq, zeros(n,1), UB);

    condition_alpha = (alpha > seuil);

    X_VS = X(condition_alpha, :);
    Y_VS = Y(condition_alpha);
    alpha_VS = alpha(condition_alpha);
    
    w = (alpha_VS'* (diag(Y_VS) * X_VS))';
    
    condition_beta = (alpha_VS < lambda-seuil);

    X_Beta = X_VS(condition_beta, :);
    Y_Beta = Y_VS(condition_beta);

    X_Beta_plusun = X_Beta(Y_Beta==1, :);
    c =  X_Beta_plusun(1,:) * w - 1;
end
