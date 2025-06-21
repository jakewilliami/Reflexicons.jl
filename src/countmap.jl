# Own version of countmap adapted from StatsBase's countmap function:
#   github.com/JuliaStats/StatsBase.jl/blob/dfe8945a/src/counts.jl#L433
#     github.com/JuliaStats/StatsBase.jl/blob/dfe8945a/src/counts.jl#L270
#       github.com/JuliaStats/StatsBase.jl/blob/dfe8945a/src/counts.jl#L272-L283
#         github.com/JuliaStats/StatsBase.jl/blob/dfe8945a/src/counts.jl#L285-L296
#  github.com/JuliaStats/StatsBase.jl/blob/dfe8945a/src/counts.jl#L9
#    github.com/JuliaStats/StatsBase.jl/pull/327/commits/0cfc0090
#
# I'm only porting the specialised version of this function that works for me because
# I want to efficiency of the StatsBase countmap algorithm without the extra import.
function countmap(x)
    cm = Dict{eltype(x), Int}()

    for v in x
        i = Base.ht_keyindex2!(cm, v)
        if i > 0
            @inbounds cm.vals[i] += 1
        else
            @inbounds Base._setindex!(cm, 1, v, -i)
        end
    end

    return cm
end
