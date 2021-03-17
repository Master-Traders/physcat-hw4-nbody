"""
N-body integration tool, for use as Homework 4 in PhysCat, Spring 2021 at UC Berkeley.
This package was partially adapted from Assignment 2, Week 2 of Astro 528 at Penn State in Spring 2019,
and the idea of introducing a new language with N-body integration was somewhat inspired by CS 61B at UC Berkeley.

v1.0: Aditya Sengupta, Aled Cuda
"""

module NBody
    include("./solve.jl")
    include("./earth_sun.jl")

    export gravity_config, electrostatics_config, unitless_config, inverse_square_diffeq, nbody_to_ode
    export euler
    export earth_sun
end # module NBody
