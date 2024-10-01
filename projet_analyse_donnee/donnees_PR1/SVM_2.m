function [X_VS, w, c, code_retour] = SVM_2(X,Y)

    % Définition du seuil
    seuil = 10^-6;
    
    % lisibilité
    n = length(Y);

    % Définition des vecteurs pour quadprog
    f = - ones(n,1);
    Aeq = Y';
    beq = 0;
    H = (diag(Y) * X) * (diag(Y) * X)';
    
    [alpha, ~, code_retour] = quadprog(H, f, [], [], Aeq, beq, zeros(n,1), []);

    w = (alpha' * (diag(Y) * X))'
    
    condition = (alpha > seuil);
    X_VS = X(condition, :);
    Y_VS = Y(condition);

    X_VS_plusun = X_VS(Y_VS == 1, : );
    
    c =  X_VS_plusun(1,:) * w - 1
end

