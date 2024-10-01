using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; 
    max_iter::Integer = 100, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8)

    # Initialisation 
    n = length(g)
    j = 0
    g0 = g 
    g_courant = g  
    s_courant = zeros(length(g))
    p_courant = -g

    # Definition de la fonction q
    q(b) = g'b + (1/2) * b' * H * b

    while (j < max_iter) && (j < (2*n)) && (norm(g_courant) > max(norm(g0)*tol_rel, tol_abs))

        κ_courant = p_courant' * H * p_courant

        if κ_courant <= 0 
            # σ_j = la racine de ||s_j + α_j * p_j|| = Δ pour laquelle q(s_j + σ_j * pj_)
            # est la plus petite
            a = p_courant' * p_courant
            b = 2 * s_courant' * p_courant
            c = s_courant' * s_courant - Δ ^ 2
            σ1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a)
            σ2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a)
            if q(s_courant + σ1 * p_courant) > q(s_courant + σ2 * p_courant)
                return s_courant + σ2 * p_courant
            else
                return s_courant + σ1 * p_courant
            end
        end

        α_courant = (g_courant' * g_courant) / κ_courant

        if norm(s_courant + α_courant * p_courant ) >= Δ
            # σ_j = la racine positive de ||s_j + α_j * p_j|| = Δ
            a = p_courant' * p_courant
            b = 2 * s_courant' * p_courant
            c = s_courant' * s_courant - Δ ^ 2
            σ = (-b + sqrt(b^2 - 4*a*c)) / (2*a)
            return s_courant + σ * p_courant
        end 
        
        # Nouvelle itération
        s_courant = s_courant + α_courant * p_courant
        g_ancien = g_courant
        g_courant = g_courant + α_courant * H * p_courant
        β_courant = (g_courant' * g_courant) / (g_ancien' * g_ancien)
        p_courant = - g_courant + β_courant * p_courant
        j = j + 1
    end

    s = s_courant
    return s
end
