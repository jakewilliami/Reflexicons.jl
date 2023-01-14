module Reflexicons

using SpelledOut
using StatsBase

export ReflexiconState
export copyto!, first!, next!

const ALPHABET = 'a':'z'

mutable struct ReflexiconState
    start::String
    page_io::IO
    page::Int
    data::Dict{Char, Int}
end


function ReflexiconState(start::String)
    page_io = IOBuffer()
    print(page_io, start)
    return Reflexicon(start, page_io, 1, countmap(start))
end

include("show.jl")
include("mutate.jl")

end  # end module
