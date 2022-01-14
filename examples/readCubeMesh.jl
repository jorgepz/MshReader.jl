using MshReader
using WriteVTK

# runs MshFileReader
nodesCoordMat, connectivity, physicalNames = MshFileReader( joinpath("examples","cube.msh") )

#
print( "\n-------------------------\nexporting matrices")
print( "nodes Coords Mat", nodesCoordMat)
print( "connec", connectivity )

#
print( "\n-------------------------\nexporting to VTK")
cells = Vector{MeshCell}( undef, length( connectivity ) )
MEBIs = Vector{String}(   undef, length( connectivity ) )

for i in 1:length(connectivity)
    aux = connectivity[i]
    if length( aux ) == 3
        cells[i] = MeshCell( VTKCellTypes.VTK_TRIANGLE, connectivity[i] )
        MEBIs[i] = "triangle"*string(round(i/4.0))
    elseif length( aux ) == 4
        cells[i] = MeshCell( VTKCellTypes.VTK_TETRA, connectivity[i] )
        MEBIs[i] = "tet"*string(round(i/4.0))
    end
end

vtk_grid("cube.vtu", Array( nodesCoordMat' ) , cells, ascii=true) do vtk
    vtk["MEBI_params"] = MEBIs
end
