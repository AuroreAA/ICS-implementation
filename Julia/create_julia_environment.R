# Julia -------------------------------------------------------------------
# devtools::install_github("Non-Contradiction/JuliaCall")
# JuliaCall | Version 0.17.5 (2022-09-08) | MIT + file LICENSE

library(JuliaCall)
julia_setup()

julia_library("Pkg")

julia_command('Pkg.activate(".")')
julia_command('Pkg.add(["ICSTools", "Robustbase"])')
julia_command('Pkg.precompile()')
