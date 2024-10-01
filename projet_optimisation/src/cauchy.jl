using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s

        sous les contraintes s = -t gₖ, t > 0, ‖s‖ ≤ Δₖ

# Syntaxe

    s = cauchy(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)

# Sorties

    - s : (Vector{<:Real}) la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = cauchy(g, H, Δ)

"""
function cauchy(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; tol_abs::Real = 1e-10)

    # Lisibilité
    norm_g = sqrt(g' * g)

    # Coefficient du polynome du second degrés
    a = (1/2) * g' * H * g 
    b = - g'*g

    # Calcul du pas
    t = 0
    s = zero(length(g))

    if norm_g < tol_abs 
        return s
    end

    # Le minimum du polynome est en -b/2a
    if a > 0
        t = -b / (2*a)
        # Le minimum est à l'intérieur de l'intervalle
        if t > Δ / norm_g
            t = Δ / norm_g
        # Il est négatif (impossible car norm_g > 0)
        end
        # On garde t = 0 et s = vecteur nul
    elseif a < 0
        # On est strictement supérieur à Δ / norm_g
        # Le polynome ne présente pas de minimum et on est ramené au bord de la région de confiance
        t = Δ / norm_g
    else 
        # cas a = 0 donc droite affine passant en 0
        t = 0
    end
    
    s = -t * g
    return s
end
