using NBody
using Test

"""
Tests the Euler integrator against the known differential equation du/dt = u(t) ⟹ u = u₀ eᵗ.
"""
function test_euler_basic(λ=1, u0=[1.0])
    f = x -> λ*x
    dt = 1e-15
    tmax = 1e-9

    @test all(vcat(euler(f, u0, dt, tmax)...) .≈ u0 .* exp.(λ .* 0:dt:tmax))
end

"""
Tests the Euler integrator, accounting for second-order errors.
"""
function test_euler_with_errors(λ=1, u0=[1.0])
    f = x -> λ*x
    dt = 1e-5
    tmax = 1

    integrated_sol = vcat(euler(f, u0, dt, tmax)...)
    analytic_sol = u0 .* exp.(λ .* 0:dt:tmax)

    @test all(abs.(integrated_sol - analytic_sol) .< dt .* (1:(round(tmax/dt)+1)))
    @test sum(integrated_sol - analytic_sol) <  (dt * λ)/(2) * (exp(λ * tmax) - 1) # Wikipedia: global truncation error
end
