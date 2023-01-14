module Reflexicons

using SpelledOut
using StatsBase

export ReflexiconState
export copyto!, first!, next!

const ALPHABET = 'a':'z'

include("state.jl")

end  # end module
