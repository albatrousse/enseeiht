# Ecrire les tests de l'algorithme du pas de Cauchy
using Test

function tester_cauchy(cauchy::Function)

	@testset "Pas de Cauchy" begin
        # Cas 1 : Tout se passe bien le minimum du polynome de second degrés est 
        # dans l'intervalle 0 et Δ / norm_g avec a >= 
        g = [1; 1]
        h = [1 1; 1 1]
        a = 1/2 * g' * h * g
        b = - g' * g
        Δ = 2 
        s = cauchy(g, h, Δ)
        t = -b/(2*a)
        @test s ==  -t * g && a >= 0

        # Cas 2 : Le t trouvé est plus grand que Δ / norm_g avec a >= 0
        g = [1; 1]
        h = [1 0; 0 1]
        a = 1/2 * g' * h * g
        b = - g' * g
        Δ = 1
        s = cauchy(g, h, Δ)
        t = Δ / norm(g)
        @test s == -t * g && a >= 0

        # Cas 3 : Le t trouvé est nul avec a >= 0
        # Implique forcément que b = 0 i.e norm_g = 0
        # Donc g est le vecteur nul et donc a = 0
        g = [0, 0]
        a = 1/2 * g' * h * g
        b = - g' * g
        Δ = 1
        s = cauchy(g, h, Δ)
        t = Δ / norm(g)
        @test s == zero(length(g)) && a >= 0

        # Cas 4 : a < 0, b != 0
        g = [1, 1]
        h = [-1 0; 0 -1]
        a = 1/2 * g' * h * g
        b = - g' * g
        Δ = 1
        s = cauchy(g, h, Δ)
        t = Δ / norm(g)
        @test s == -t * g && a <= 0

        # Cas 5 : a = 0, b != 0 
        g = [1, 1]
        h = [0 0; 0 0]
        a = 1/2 * g' * h * g
        b = - g' * g
        Δ = 1
        s = cauchy(g, h, Δ)
        t = 0
        @test s == -t * g && a == 0
    end

end