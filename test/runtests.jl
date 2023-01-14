using Reflexicons
using Test

@testset "Reflexicons.jl" begin
    R = Reflexicon("x")

    # Page 1
    @test R.start == "x"
    @test R.page == 1
    @test R.data == Dict{Char, Int}('x' => 1)

    # Page 2
    next!(R)
    @test R.start == "x"  # start does not change
    @test R.page == 2  # page number should increment
    @test R.data == Dict{Char, Int}('e' => 1, 'n' => 1, 'o' => 1, 'x' => 1)

    # Pages 3 and 4
    next!(R)
    @test R.data == Dict{Char, Int}('e' => 5, 'n' => 5, 'o' => 5, 'x' => 1)
    next!(R)
    @test R.data == Dict{Char, Int}('e' => 5, 'f' => 3, 'i' => 3, 'n' => 2, 'o' => 2, 'v' => 3, 'x' => 1)

    # Test jump back to start
    first!(R)
    @test R.start == "x"
    @test R.page == 1
    @test R.data == Dict{Char, Int}('x' => 1)
end
