using MshReader
using Documenter

DocMeta.setdocmeta!(MshReader, :DocTestSetup, :(using MshReader); recursive=true)

makedocs(;
    modules=[MshReader],
    authors="Jorge Pérez Zerpa",
    repo="https://github.com/jorgepz/MshReader.jl/blob/{commit}{path}#{line}",
    sitename="MshReader.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jorgepz.github.io/MshReader.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jorgepz/MshReader.jl",
    devbranch="main",
)
