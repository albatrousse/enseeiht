function [X_VS, w, c, code_retour] = SVM_1(X,Y)
    
    % Définition du seuil
    seuil = 10^-6;
    
    % Définition des vecteurs pour quadprog
    H = [1 0 0; 0 1 0; 0 0 0];
    f = zeros(3,1);
    vecteur_moinsUn = -1 * ones(length(X),1);
    A = - repmat(Y,1,3) .* [X(:,1), X(:,2), vecteur_moinsUn];
    b = -1 * ones(length(X), 1);

    [w_tilde, ~, code_retour] = quadprog(H, f, A, b);
    w = w_tilde(1:2)
    c = w_tilde(3)
    
    % X_VS 
    condition = Y .* (sum(repmat(w',length(X),1) .* X,2) - c) -1 < seuil;
    X_VS = X(condition, :);

end

