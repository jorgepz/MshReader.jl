using MshReader
using WriteVTK

# runs MshFileReader
nodesCoordMat, connectivity, physicalNames, elemPhysNums = MshFileReader( joinpath("examples","cube.msh") )

#
print( "\n-------------------------\nexporting matrices")
print( "\nnodes Coords Mat", nodesCoordMat)
print( "\nconnec", connectivity )
print( "\nelem phys nums", elemPhysNums )

#
print( "\n-------------------------\nexporting to VTK...\n")
cells = Vector{MeshCell}( undef, length( connectivity ) )
MEBIs = Vector{String}(   undef, length( connectivity ) )

for i in 1:length(connectivity)
    aux = connectivity[i]
    print("  i: ", i, " aux:", aux ,"\n" )
    if length( aux ) == 1
        cells[i] = MeshCell( VTKCellTypes.VTK_VERTEX, connectivity[i] )
    elseif length( aux ) == 3
        cells[i] = MeshCell( VTKCellTypes.VTK_TRIANGLE, connectivity[i] )
    elseif length( aux ) == 4
        cells[i] = MeshCell( VTKCellTypes.VTK_TETRA, connectivity[i] )
    end

    if elemPhysNums[i] == 0
        MEBIs[i] = "null"
    else
        MEBIs[i] = physicalNames[ elemPhysNums[i] ]
    end
end

vtk_grid("cube.vtu", Array( nodesCoordMat' ) , cells, ascii=true) do vtk
    vtk["MEBI_params"] = MEBIs
end


export MshFileReader