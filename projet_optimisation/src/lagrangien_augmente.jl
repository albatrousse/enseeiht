using LinearAlgebra
include("../src/newton.jl")
include("../src/regions_de_confiance.jl")
"""

Approximation d'une solution au problème 

    min f(x), x ∈ Rⁿ, sous la c c(x) = 0,

par l'algorithme du lagrangien augmenté.

# Syntaxe

    x_sol, f_sol, flag, nb_iters, μs, λs = lagrangien_augmente(f, gradf, hessf, c, gradc, hessc, x0; kwargs...)

# Entrées

    - f      : (Function) la ftion à minimiser
    - gradf  : (Function) le gradient de f
    - hessf  : (Function) la hessienne de f
    - c      : (Function) la c à valeur dans R
    - gradc  : (Function) le gradient de c
    - hessc  : (Function) la hessienne de c
    - x0     : (Vector{<:Real}) itéré initial
    - kwargs : les options sous formes d'arguments "keywords"
        • max_iter  : (Integer) le nombre maximal d'iterations (optionnel, par défaut 1000)
        • tol_abs   : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel   : (Real) la tolérence relative (optionnel, par défaut 1e-8)
        • λ0        : (Real) le multiplicateur de lagrange associé à c initial (optionnel, par défaut 2)
        • μ0        : (Real) le facteur initial de pénalité de la c (optionnel, par défaut 10)
        • τ         : (Real) le facteur d'accroissement de μ (optionnel, par défaut 2)
        • algo_noc  : (String) l'algorithme sans c à utiliser (optionnel, par défaut "rc-gct")
            * "newton"    : pour l'algorithme de Newton
            * "rc-cauchy" : pour les régions de confiance avec pas de Cauchy
            * "rc-gct"    : pour les régions de confiance avec gradient conjugué tronqué

# Sorties

    - x_sol    : (Vector{<:Real}) une approximation de la solution du problème
    - f_sol    : (Real) f(x_sol)
    - flag     : (Integer) indique le critère sur lequel le programme s'est arrêté
        • 0 : convergence
        • 1 : nombre maximal d'itération dépassé
    - nb_iters : (Integer) le nombre d'itérations faites par le programme
    - μs       : (Vector{<:Real}) tableau des valeurs prises par μk au cours de l'exécution
    - λs       : (Vector{<:Real}) tableau des valeurs prises par λk au cours de l'exécution

# Exemple d'appel

    f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
    gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
    hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
    c(x) =  x[1]^2 + x[2]^2 - 1.5
    gradc(x) = 2*x
    hessc(x) = [2 0; 0 2]
    x0 = [1; 0]
    x_sol, _ = lagrangien_augmente(f, gradf, hessf, c, gradc, hessc, x0, algo_noc="rc-gct")

"""
function lagrangien_augmente(f::Function, gradf::Function, hessf::Function, 
        c::Function, gradc::Function, hessc::Function, x0::Vector{<:Real}; 
        max_iter::Integer=1000, tol_abs::Real=1e-10, tol_rel::Real=1e-8,
        λ0::Real=2, μ0::Real=10, τ::Real=2, algo_noc::String="rc-gct")

    # Initialisation
    β = 0.9
    η = 0.1258925
    α = 0.1
    μ_courant = μ0
    ε_courant = 1 / μ_courant
    ε0 = ε_courant
    η_courant = η / ((μ_courant) ^ α)
    λ_courant = λ0

    x_courant = x0
    flag  = -1
    nb_iters = 0
    μs = [μ0] # vous pouvez faire μs = vcat(μs, μk) pour concaténer les valeurs
    λs = [λ0]
    iterer = ~(norm(gradf(x_courant)) <= tol_abs) # booléen qui va servir à continuer d'itérer

    # Gradient augmenté initial
    gradLA0 = gradf(x0) + λ0 * gradc(x0) + μ0 * gradc(x0) * c(x0)

    while iterer

        LA(x) = f(x) + λ_courant' * c(x) + (μ_courant / 2) * norm(c(x))^2
        gradLA(x) = gradf(x) + λ_courant' * gradc(x) + μ_courant * gradc(x) * c(x)
        hessLA(x) = hessf(x) + λ_courant' * hessc(x)  + μ_courant * ( gradc(x) * gradc(x)' + hessc(x) * c(x))
        
        # Calcul du nouvel itéré
        tol_abs_recherche = ε_courant
        tol_rel_recherche = ε_courant / norm(gradLA(x_courant))

        if algo_noc == "rc-gct"
            x_courant,_ , _, _, _ = regions_de_confiance(LA, gradLA, hessLA, x_courant; tol_abs = tol_abs_recherche, tol_rel = tol_rel_recherche, algo_pas="gct")
        elseif algo_noc == "rc-cauchy"
            x_courant, _, _, _, _ = regions_de_confiance(LA, gradLA, hessLA, x_courant; tol_abs = tol_abs_recherche, tol_rel = tol_rel_recherche, algo_pas="cauchy")
        elseif algo_noc == "newton"
            x_courant, _, _, _, _ = newton(LA, gradLA, hessLA, x_courant; tol_abs = tol_abs_recherche, tol_rel = tol_rel_recherche)
        end

        # Mise à jour des paramètres
        if norm(c(x_courant)) <= η_courant
            λ_courant = λ_courant + μ_courant * c(x_courant)
            μ_courant = μ_courant
            ε_courant = ε_courant / μ_courant
            η_courant = η_courant / (μ_courant ^ β)
        else 
            λ_courant = λ_courant
            μ_courant = τ * μ_courant
            ε_courant = ε0 / μ_courant
            η_courant = η / (μ_courant ^ α)
        end

        # Ajout dans les listes
        λs = vcat(λs, [λ_courant])
        μs = vcat(μs, [μ_courant])

        # Incrémentation de nb_iters
        nb_iters = nb_iters + 1

        # Vérifion la CN1
        if (norm(gradLA(x_courant)) <= max(tol_rel * norm(gradLA0), tol_abs))
            flag = 0
            iterer = false
        # Vérifion que l'on a pas atteint le nombre d'itération maximal
        elseif nb_iters == max_iter
            flag = 1
            iterer = false
        end
    end

    x_sol = x_courant
    f_sol = f(x_sol)
    return x_sol, f_sol, flag, nb_iters, μs, λs

end
