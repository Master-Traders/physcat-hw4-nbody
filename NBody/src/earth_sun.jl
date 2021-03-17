using NBody
using Unitful: G
using UnitfulAstro: Msun, Mearth, AU, yr
using Plots

function earth_sun()
    config = gravity_config([1.0 * Msun, 1.0 * Mearth])
    pos_init = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0] * AU
    vel_init = sqrt.([0.0, 0.0, 0.0, 0.0, 1.0, 0.0] * G * Msun / AU)
    u0 = vcat(pos_init, vel_init)

    f = nbody_to_ode(config, inverse_square_diffeq)

    dt = yr/3600 # 10 steps per day-ish
    tmax = 10 * yr
    sol = euler(f, u0, dt, tmax)

    pos_to_plottable = i -> map(x -> ustrip.(x), [y[i] |> AU for y in sol])
    sun_x = pos_to_plottable(1)
    sun_y = pos_to_plottable(2)
    earth_x = pos_to_plottable(4)
    earth_y = pos_to_plottable(5)

    return sun_x, sun_y, earth_x, earth_y
end

"""
Run this in your Julia REPL after calling `earth_sun`

sun_x, sun_y, earth_x, earth_y = earth_sun()
scatter()
scatter!(sun_x, sun_y, color="orange", label="sun") - look at the plot at this point!
scatter!(earth_x, earth_y, color="blue", label="earth")
"""
