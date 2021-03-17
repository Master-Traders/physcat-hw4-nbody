using NBody
using Test

include("./test_setup.jl")
include("./test_solve.jl")

function tests()
    println("Testing all NBody methods")
    test_invsq_unitless()
    test_invsq_units()
    test_euler_basic()
    test_euler_with_errors()
end

tests()
