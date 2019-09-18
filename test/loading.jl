module TestLoading

# using Revise
using Test
using MLJModels

@testset "loading of model implementations" begin
    tree = @load DecisionTreeClassifier pkg=DecisionTree verbosity=1
    @test (@isdefined DecisionTreeClassifier)
    @test tree == DecisionTreeClassifier()
    @test_logs((:info, r"^A model"),
               load("DecisionTreeClassifier", modl=TestLoading))
    @test(MLJModels.info("DecisionTreeClassifier")
          in localmodels(modl=TestLoading))
    @load PCA
    @test_throws(ArgumentError, load("RidgeRegressor", modl=TestLoading))
    @load RidgeRegressor pkg=MultivariateStats
end

end # module

true

