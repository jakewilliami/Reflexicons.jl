module Reflexicons

using SpelledOut

export ReflexiconState
export copyto!, first!, next!

const ALPHABET = 'a':'z'

mutable struct ReflexiconState
    start::String
    page_io::IO
    page::Int
    data::Dict{Char, Int}
    lang::Symbol  # used by SpelledOut.jl
end

ReflexiconState(start::String, lang::Symbol = :en) =
    ReflexiconState(start, IOBuffer(start), 1, countmap(start), lang)

include("countmap.jl")
include("state.jl")

end  # end module
