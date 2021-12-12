using MshReader
using WriteVTK

nodesCoordMat, connectivity, physicalNames = MshFileReader("cube.msh" )

print( "nodes Coords Mat", nodesCoordMat)
print( "connec", connectivity )

print("length",length(connectivity))
cells = Vector{MeshCell}(undef, length(connectivity))

for i in 1:length(connectivity)
    aux = connectivity[i]
    print("aux: ", aux)
    if length( aux ) == 3
        cells[i] = MeshCell( VTKCellTypes.VTK_TRIANGLE, connectivity[i] )
    elseif length( aux ) == 4
        cells[i] = MeshCell( VTKCellTypes.VTK_TETRA, connectivity[i] )
    end
end

valores = Vector{String}(undef, length(connectivity))
valores[1] = "caca"
valores[2] = "jeje"

vtk_grid("cube.vtu", Array( nodesCoordMat' ) , cells, ascii=true) do vtk
#        vtk["date",VTKCellData()] = valores                         # metadata ("field data" in VTK)
end
