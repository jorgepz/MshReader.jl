using MshReader
using Test
using Downloads:download

@testset "MshReader" begin

    @testset "Pyramid problem tests" begin

        nodesCoordMat, connectivity, physicalNames, elemPhysNums = MshFileReader( joinpath("..", "examples", "pyramid.msh") )

        @test nodesCoordMat[3,:] == [1.0,1.0,0]
        @test nodesCoordMat[5,:] == [0.5,0.5,0.5]
        @test cmp( physicalNames[ elemPhysNums[1]], "point_prop_1" ) == 0
    end

    @testset "Uniaxialextension problem tests" begin

        tmp_location = download("https://github.com/ONSAS/ONSAS.m/raw/master/examples/uniaxialExtension/geometry_uniaxialExtension.msh")

        nodesCoordMat, connectivity, physicalNames, elemPhysNums = MshFileReader( tmp_location; verbosityBoolean=false )

        @test nodesCoordMat[7,:] == [2.0,1.0,1.0]
    end
end
