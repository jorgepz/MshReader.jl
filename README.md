# MshReader.jl
A minimal msh mesh format file reader.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jorgepz.github.io/MshReader.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jorgepz.github.io/MshReader.jl/dev/)
[![Build Status](https://github.com/jorgepz/MshReader.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jorgepz/MshReader.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/jorgepz/MshReader.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/jorgepz/MshReader.jl)



## Scope

The goal and scope of this package is to provide a function to read .msh files generated with (http://gmsh.info).

## Developer's guide

Clone the repo
```
$ git clone git@github.com:jorgepz/MshReader.jl.git
```

Enter to the folder and open julia with
```
$ cd MshReader.jl
$ julia --project=.
```

Run the cube example
```julia
julia> include(joinpath("examples","readCubeMesh.jl"))
```

This example script generates a .vtu file (using https://jipolanco.github.io/WriteVTK.jl/ ) which can be viewed using paraview

![cube](docs/src/assets/cube.png)
