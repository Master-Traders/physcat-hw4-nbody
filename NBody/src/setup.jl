"""
Setup for an N-body integration problem, in a form compatible with DifferentialEquations.jl.
"""

using Unitful

"""
Stores parameters for an N-body integration problem.
"""
struct NBodyConfig
    params::Array{<: Number}
    k::Number
end

"""
Applies the inverse square law, F = k*p1*p2/r^2, to each pair of bodies in an N-body system.

Arguments
    pos - array of positions [x1, y1, z1, x2, y2, z2, ...] - length 3N
    vel - array of velocities [vx1, vy1, vz1, vx2, vy2, vz2, ...] - length 3N
    params - array of masses/charges [p1, p2, ...] - length N
    k - the gravitational/electrostatic constant to use.

Returns
    du - array of velocities and accelerations [vx_1, vy_1, vz_1, vx_2, vy_2, vz_2, ...., ax_1, ay_1, az_1, ..., az_N] - length 6N
"""
function inverse_square_diffeq(pos::Array{<: Number}, vel::Array{<: Number}, params::Array{<: Number}, k::Number)
    @assert length(pos) == length(vel) == 3 * length(params)
    N = length(params)
    @assert N >= 2
    if isa(k, Unitful.Quantity) # dispatch on units is a little strange
        acc = zeros(3 * N) .* Unitful.m / Unitful.s^2
    else
        acc = zeros(3 * N)
    end
    
    ### YOUR CODE HERE
    
    return vcat(vel, acc)
end

# Defining some useful shortcut functions 
 
inverse_square_diffeq(u::Array{<: Number}, config::NBodyConfig) = inverse_square_diffeq(u[1:length(u)÷2], u[length(u)÷2 + 1:length(u)], config.params, config.k)

# Note that for bigger use cases, you might define special Gravity and Electrostatic types which subtype NBodyConfig,
# and you can write methods that dispatch on NBodyConfig that apply to both. This felt overkill to me though.
gravity_config(masses::Array{<: Number}) = NBodyConfig(masses, Unitful.G)
electrostatics_config(charges::Array{<: Number}) = NBodyConfig(charges, Unitful.ϵ0)
unitless_config(params::Array{<: Number}) = NBodyConfig(params, 1)
nbody_to_ode(config::NBodyConfig, dynamics::Function) = u -> dynamics(u, config) # for solver compatibility
