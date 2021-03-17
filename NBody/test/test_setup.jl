using NBody
using Test
using Unitful
using Unitful: kg, m, s
using UnitfulAstro: AU, yr

"""
Tests inverse-square dynamics.
"""
function test_invsq_unitless()
    config = unitless_config([1.0, 1.5, 2.0] .* 10^(25))
    pos = [1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 0.0, -1.0, -1.0] ./ 10
    vel = collect(1:9)
    du = inverse_square_diffeq(vcat(pos, vel), config)

    @test length(du) == 6 * length(config.params)
    @test all(du .≈ [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, -5.4472701767872676e19, -2.356885893865799e19, -4.491299508792983e19, 5.0108227531284005e19, -4.3298758664509776e19, -7.419955232740329e18, -1.034481976452667e19, 4.425849846771133e19, 2.802146396852016e19])
end

"""
The same test as above, but with units.
"""
function test_invsq_units()
    config = gravity_config([1.0, 1.5, 2.0] .* 10^(25) * kg)
    pos = [1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 0.0, -1.0, -1.0] * AU/10
    vel = collect(1:9) .* AU/yr
    du = inverse_square_diffeq(vcat(pos, vel), config)

    @test length(du) == 6 * length(config.params)
    N = length(config.params)
    for i = 1:(3*N) 
        du[i] |> m/s # if this throws an error your first 3N entries aren't all velocities
        du[i + 3*N] |> m/s^2 # if this throws an error your last 3N entries aren't all accelerations
    end

    @test all(ustrip.(du) .≈ [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, -1.6245527428885305e-13, -7.028998597997206e-14, -1.3394512662940557e-13, 1.4943899574527944e-13, -1.2913094975873621e-13, -2.2128714446412436e-14, -3.085160966453307e-14, 1.319932053090382e-13, 8.356909914951212e-14])
end