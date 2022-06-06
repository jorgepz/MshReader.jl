
push!( LOAD_PATH, joinpath("..", "src") )

using Documenter, MshReader

makedocs( sitename="MshReader" )