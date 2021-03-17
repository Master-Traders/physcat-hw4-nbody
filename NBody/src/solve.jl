"""
Custom and external solvers for general differential equations. 
(Abstraction barriers at work: solvers don't care what *kind* of differential equation we're working with!)
"""

include("./setup.jl")

"""
Applies Euler's method to solve the differential equation du/dt = f(u),
i.e. numerically integrates with the rule u_(i+1) = u_i + Δt (du/dt)|_i = u_i + Δt f(u_i).

Arguments
    f - function defining the differential equation problem.
    initial_state - the initial input to the function.
    dt - the timestep.
    tmax - the time at which to stop.

Returns
    res - an array, in which the i-th element is the array u_i.
"""
function euler(f::Function, initial_state::Array{<: Number}, dt::Number, tmax::Number)::Array{<:Array{<:Number}}
    times = (0*dt):dt:tmax
    ### YOUR CODE HERE
end
