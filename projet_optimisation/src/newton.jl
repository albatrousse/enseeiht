using LinearAlgebra
"""
Approximation d'une solution du problème min f(x), x ∈ Rⁿ, en utilisant l'algorithme de Newton.

# Syntaxe

   x_sol, f_sol, flag, nb_iters, xs = newton(f, gradf, hessf, x0; kwargs...)

# Entrées

   - f       : (Function) la fonction à minimiser
   - gradf   : (Function) le gradient de la fonction f
   - hessf   : (Function) la Hessienne de la fonction f
   - x0      : (Union{Real,Vector{<:Real}}) itéré initial
   - kwargs  : les options sous formes d'arguments "keywords"
      • max_iter : (Integer) le nombre maximal d'iterations (optionnel, par défaut 1000)
      • tol_abs  : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
      • tol_rel  : (Real) la tolérence relative (optionnel, par défaut 1e-8)
      • epsilon  : (Real) le epsilon pour les tests de stagnation (optionnel, par défaut 1)

# Sorties

   - x_sol : (Union{Real,Vector{<:Real}}) une approximation de la solution du problème
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
   x_sol, f_sol, flag, nb_iters, xs = newton(f, gradf, hessf, x0)

"""
function newton(f::Function, gradf::Function, hessf::Function, x0::Union{Real,Vector{<:Real}}; 
    max_iter::Integer = 1000, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8, 
    epsilon::Real = 1)
    #

    flag  = 0
    nb_iters = 0
    xs = [x0] # vous pouvez faire xs = vcat(xs, [xk]) pour concaténer les valeurs

    x_courant = x0
    iterer = ~(norm(gradf(x_courant)) <= tol_abs)

    # On itère tant qu'on a pas atteint le nombre d'itération maximal
    while iterer

      # Vérifion que l'on a pas atteint le nombre d'itération maximal
      if nb_iters == max_iter
         flag = 3
         iterer = false

      # Si c'est pas le cas, on effectue une itération
      else
         # Calcul du pas de l'itération 
         d = - hessf(x_courant) \ gradf(x_courant)

         # On calcul le nouveau itéré
         x_ancien = x_courant
         x_courant = x_courant + d

         # On l'ajoute à la liste des itérés
         xs = vcat(xs, [x_courant])
         
         # Vérifion la CN1
         if norm(gradf(x_courant)) <= max(tol_rel * norm(gradf(x0)), tol_abs)
            flag = 0
            iterer = false
         # Vérifions que l'on ne stagne pas selon x
         elseif norm(x_courant - x_ancien) <= epsilon * max(tol_rel * norm(x_ancien), tol_abs)
            flag = 1
            iterer = false
         # Vérifions que l'on ne stagne pas selon f(x)
         elseif abs(f(x_courant) - f(x_ancien)) <= epsilon * max(tol_rel * abs(f(x_ancien)), tol_abs)
            flag = 2
            iterer = false
         end

         # On incrémente le nombre d'itération
         nb_iters = nb_iters + 1

      end

   end
    
    x_sol = x_courant
    f_sol = f(x_courant)
    return x_sol, f_sol, flag, nb_iters, xs
end