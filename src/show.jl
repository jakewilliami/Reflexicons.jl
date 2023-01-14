# Given a frequency map of characters, write out the reflexicon page
function _write_out_page(freq::Dict{Char, Int}; infix = ' ', line_suffix = '\n')
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
