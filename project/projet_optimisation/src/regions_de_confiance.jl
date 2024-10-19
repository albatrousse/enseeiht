using LinearAlgebra
include("../src/cauchy.jl")
include("../src/gct.jl")
"""
Approximation de la solution du problème min f(x), x ∈ Rⁿ.

L'algorithme des régions de confiance résout à chaque itération, un modèle quadratique
de la fonction f dans une boule (appelée la région de confiance) de centre l'itéré 
courant. Cette minimisation se fait soit par un pas de Cauchy ou par l'algorithme 
du gradient conjugué tronqué.

# Syntaxe

    x_sol, f_sol, flag, nb_iters, xs = regions_de_confiance(f, gradf, hessf, x0; kwargs...)

# Entrées

    - f       : (Function) la fonction à minimiser
    - gradf   : (Function) le gradient de la fonction f
    - hessf   : (Function) la hessienne de la fonction f
    - x0      : (Vector{<:Real}) itéré initial
    - kwargs  : les options sous formes d'arguments "keywords"
        • max_iter      : (Integer) le nombre maximal d'iterations (optionnel, par défaut 5000)
        • tol_abs       : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel       : (Real) la tolérence relative (optionnel, par défaut 1e-8)
        • epsilon       : (Real) le epsilon pour les tests de stagnation (optionnel, par défaut 1)
        • Δ0            : (Real) le rayon initial de la région de confiance (optionnel, par défaut 2)
        • Δmax          : (Real) le rayon maximal de la région de confiance (optionnel, par défaut 10)
        • γ1, γ2        : (Real) les facteurs de mise à jour de la région de confiance (optionnel, par défaut 0.5 et 2)
        • η1, η2        : (Real) les seuils pour la mise à jour de la région de confiance (optionnel, par défaut 0.25 et 0.75)
        • algo_pas      : (String) l'algorithme de calcul du pas - "cauchy" ou "gct" (optionnel, par défaut "gct")
        • max_iter_gct  : (Integer) le nombre maximal d'iterations du GCT (optionnel, par défaut 2*length(x0))

# Sorties

    - x_sol : (Vector{<:Real}) une approximation de la solution du problème
    - f_sol : (Real) f(x_sol)
    - flag  : (Integer) indique le critère sur lequel le programme s'est arrêté
        • 0  : convergence
        • 1  : stagnation du xk
        • 2  : stagnation du f
        • 3  : nombre maximal d'itération dépassé
    - nb_iters : (Integer) le nombre d'itérations faites par le programme
    - xs    : (Vector{Vector{<:Real}}) les itérés

# Exemple d'appel

    f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
    gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
    hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
    x0 = [1; 0]
    x_sol, f_sol, flag, nb_iters, xs = regions_de_confiance(f, gradf, hessf, x0, algo_pas="gct")

"""
function regions_de_confiance(f::Function, gradf::Function, hessf::Function, x0::Vector{<:Real};
    max_iter::Integer=5000, tol_abs::Real=1e-10, tol_rel::Real=1e-8, epsilon::Real=1, 
    Δ0::Real=2, Δmax::Real=10, γ1::Real=0.5, γ2::Real=2, η1::Real=0.25, η2::Real=0.75, algo_pas::String="gct",
    max_iter_gct::Integer = 2*length(x0))

    # Initialisation
    flag  = 0
    nb_iters = 0
    xs = [x0] # vous pouvez faire xs = vcat(xs, [xk]) pour concaténer les valeurs
    Δ = Δ0

    x_courant = x0
    iterer = ~(norm(gradf(x_courant)) <= tol_abs)

    # On itère tant qu'on a pas atteint le nombre d'itération maximal
    while iterer

        # Calcul de la hessienne et du gradient de x_courant
        g = gradf(x_courant)
        h = hessf(x_courant)
        # Calcul du pas de l'itération 
        if algo_pas == "gct"
            s = gct(g, h, Δ; max_iter = max_iter_gct, tol_abs, tol_rel)
        elseif algo_pas == "cauchy"
            s = cauchy(g, h, Δ; tol_abs)
        end

        # Calcul de la qualité de l'approximation
        mk = f(x_courant) + g'*s + 1/2* s' * h * s
        ρ = (f(x_courant) - f(x_courant+s)) / (f(x_courant) - mk)

        # On calcul le nouveau itéré
        maj = (ρ >= η1)
        if maj
            x_ancien = x_courant
            x_courant = x_courant + s
        end

        # On l'ajoute à la liste des itérés
        xs = vcat(xs, [x_courant])

        # Mise à jour de la région de confiance
        if ρ >= η2 
            Δ = min(γ2*Δ, Δmax)
        elseif maj
            # On garde la même région de confiance
        else
            Δ = γ1*Δ
        end

        # On incrémente le nombre d'itération
        nb_iters = nb_iters + 1 

        # Vérifion la CN1
        if norm(gradf(x_courant)) <= max(tol_rel * norm(gradf(x0)), tol_abs)
            flag = 0
            iterer = false
        # On vérifie la stagnation que si l'itéré a été mis à jour
        elseif maj
            # Vérifions que l'on ne stagne pas selon x
            if norm(x_courant - x_ancien) <= epsilon * max(tol_rel * norm(x_ancien), tol_abs)
                flag = 1
                iterer = false
            # Vérifions que l'on ne stagne pas selon f(x)
            elseif abs(f(x_courant) - f(x_ancien)) <= epsilon * max(tol_rel * abs(f(x_ancien)), tol_abs)
                flag = 2
                iterer = false
            end             
        end
        # Vérifion que l'on a pas atteint le nombre d'itération maximal
        if nb_iters == max_iter
            flag = 3
            iterer = false
        end

    end

    x_sol = x_courant
    f_sol = f(x_courant)
    return x_sol, f_sol, flag, nb_iters, xs

end
