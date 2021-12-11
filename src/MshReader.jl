module MshReader

"""
function for reading gmsh's msh-format files. http://gmsh.info/doc/texinfo/gmsh.html#MSH-file-format
    Input:
        - mshFilename: the name of the msh file
    Output:
        - nodesMat: matrix with 4 columns: [x y z physicalTag]
        - conecMat: matrix with 5 columns: [ n1 n2 n3 n4 physicalTag ]
            for elements with less than four nodes 0 is used as node.
        - physicalNames: cell with strings of physical names.

    Assumptions:
        - physical names are saved as strings
        - maximum of one physical tag per entity
        - maximum number of nodes per element: 4 (linear tetrahedron)
"""
function MshFileReader( mshFilename; verbosityBoolean::Bool = true )

    mshFileLines = open( readlines, mshFilename, "r")

    # ----------------------------------------------------
    # verifies if the msh version is 4.1
    currLine = 2
    cmp( mshFileLines[currLine][1:3], "4.1" ) != 0 && error("version of file error")


    # ----------------------------------------------------
    # reads physical names
    currLine += 2
    if cmp( mshFileLines[ currLine ][2:14], "PhysicalNames" ) == 0
        verbosityBoolean && println("Physical names found. Reading ... ")

        currLine += 1
        numPhysicalNames = parse( Int32, mshFileLines[ currLine ] )

        numsPhysProp   = zeros( Int32, numPhysicalNames )
        physicalNames  = Vector{String}(undef, numPhysicalNames )

        for i in 1:numPhysicalNames
            currLine += 1
            _, aux, aux2 = split( mshFileLines[ currLine ] )
            numsPhysProp[i]  = parse( Int32, aux ) # convert string to integer
            physicalNames[i] = aux2[2:end-1]       # remove quotes from start and end

            verbosityBoolean && println("  property: ", i )
        end

    end


    # ----------------------------------------------------
    currLine += 2
    if cmp( mshFileLines[ currLine ][2:7], "Entiti" ) == 0
        verbosityBoolean && println("Entities found. Reading ... ")

        currLine += 1
        entNumsPerDim = parse.( Int32, split( mshFileLines[ currLine ]) )

        #    matsPhysicalPropsPerEntity = cell(4) ;
        vecsPhysicalPropsPerEntity = Vector{Matrix{Int32}}(undef,4)
        [ vecsPhysicalPropsPerEntity[i] = zeros(entNumsPerDim[i],2) for i in 1:4 ]

        for indDim in 1:4
             colNumTags  = 1+3+3*(indDim>1)+1
             colTags     = 1+3+3*(indDim>1)+2

            if entNumsPerDim[indDim] > 0
                for i in 1:entNumsPerDim[indDim]
                    currLine += 1
                    aux = parse.( Int32, split( mshFileLines[currLine] ) )
                    if aux[colNumTags] > 0
                        vecsPhysicalPropsPerEntity[indDim][i,:] = [ aux[1] aux[colTags] ]
                    else
                        vecsPhysicalPropsPerEntity[indDim][i,:] = [ aux[1] 0            ]
                    end
                end
            end
        end
    end # if - entities block


    # ----------------------------------------------------
    currLine += 2
    if cmp( mshFileLines[ currLine ][2:5], "Node" ) == 0
        currLine += 1
        numEntBlocks, numNodes = parse.( Int32, split( mshFileLines[ currLine ] ) )[1:2]

        nodesCoordMat = zeros( numNodes, 3 )

        for block in 1:numEntBlocks
            currLine += 1
            aux = parse.( Int32, split( mshFileLines[ currLine ] ) )
            numNodesInEnt = aux[4]
            if numNodesInEnt > 0 # if there are nodes in the block
                currLine += 1
                nodesTags = parse.( Int32, split( mshFileLines[ currLine ] ) )

                for indnode in nodesTags
                    currLine += 1
                    nodesCoordMat[ indnode, :] = parse.( Float64, split( mshFileLines[ currLine ] ) )
                end
            end
        end
    end # if - nodes block

    # ----------------------------------------------------
    currLine += 2
    if cmp( mshFileLines[ currLine ][2:5], "Elem" ) == 0
        currLine += 1
        aux = parse.( Int32, split( mshFileLines[ currLine ] ) )

        numEntBlocks = aux[1]
        numElems     = aux[2]

        connectivity = Vector{Vector{Int64}}(undef, numElems)

        for block in 1:numEntBlocks
            currLine += 1
            dimOfBlock, _, _, numElemInBlock = parse.( Int32, split( mshFileLines[ currLine ] ) )

            if numElemInBlock > 0 # if there are elements in the block
                print("aux", aux)
                for i in 1:numElemInBlock
                    currLine += 1
                    aux = parse.( Int32, split( mshFileLines[ currLine ] ) )
                    println("aux1: ", aux[1] )
                    connectivity[ aux[1] ] = aux[2:end]
                end
            end
        end
    end # if - elements block

    return nodesCoordMat, connectivity, physicalNames
end # function

export MshFileReader

end # module
