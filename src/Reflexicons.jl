module Reflexicons

using SpelledOut
using StatsBase


export Reflexicon
export copyto!, first!, next!


const ALPHABET = 'a':'z'


### Reflexicon struct

mutable struct Reflexicon
    start::String
    page_io::IO
    page::Int
    data::Dict{Char, Int}
end

function Reflexicon(start::String)
    page_io = IOBuffer()
    print(page_io, start)
    return Reflexicon(start, page_io, 1, countmap(start))
end


### Display functions

# Given a frequency map of characters, write out the reflexicon page
function _write_out_page(freq::Dict{Char, Int}; infix = "", line_suffix = "")
    io = IOBuffer()
    chars = collect(keys(freq))
    sort!(chars)  # sort for aesthetic
    set_len = length(freq)

    for (i, c) in enumerate(chars)
        n = freq[c]
        print(io, spelled_out(n), infix, c)
        i == set_len || print(io, line_suffix)
    end

    return io
end

# Show current page
function Base.show(io::IO, R::Reflexicon)
    for b in take!(copy(R.page_io))
        print(io, Char(b))
    end
end


### Modifying functions

# Update dest with fields from src
function Base.copyto!(dest::Reflexicon, src::Reflexicon)
    dest.start = src.start
    dest.page_io = src.page_io
    dest.page = src.page
    dest.data = src.data
    return dest
end

# Return reflexicon to initial state
function first!(R::Reflexicon)
    copyto!(R, Reflexicon(R.start))
    R.page = 1
    return R
end

# Calculate next page in reflexicon
function next!(R::Reflexicon)
    chars = Char.(take!(R.page_io))
    filter!(∈('a':'z'), chars)
    R.data = countmap(chars)
    R.page_io = _write_out_page(R.data, infix = ' ', line_suffix = '\n')
    R.page += 1

    return R
end

end  # end module
