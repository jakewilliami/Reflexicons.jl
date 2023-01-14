# Given a frequency map of characters, write out the reflexicon page
function _write_out_page(freq::Dict{Char, Int})
    io = IOBuffer()
    chars = collect(keys(freq))
    sort!(chars)  # sort for aesthetic
    set_len = length(freq)

    for (i, c) in enumerate(chars)
        n = freq[c]
        print(io, spelled_out(n), ' ', c)
        i == set_len || print(io, '\n')
    end

    return io
end

const _PAGE_BOARDER_CHARS = Dict{Symbol, Char}(
    :top_left_corner => '┌',
    :top_right_corner => '┐',
    :bottom_left_corner => '└',
    :bottom_right_corner => '┘',
    :edge_vertical => '│',
    :edge_horizontal => '─',
    # :blank => '⋅',
    :blank => ' ',
)

# Show current page
function Base.show(io::IO, R::ReflexiconState)
    seekstart(R.page_io)
    lines = split(read(R.page_io, String), '\n')
    line_width = maximum(length, lines)
    page_width = line_width + 4

    # Print header
    page_header = "Page $(R.page)"
    print(io, _PAGE_BOARDER_CHARS[:blank] ^ (max(fld(page_width - length(page_header), 2), 0)))
    Base.emphasize(io, page_header, :bold)
    println(io)

    # Print top boarder
    print(io, _PAGE_BOARDER_CHARS[:top_left_corner])
    print(io, _PAGE_BOARDER_CHARS[:edge_horizontal] ^ (line_width + 2))
    println(io, _PAGE_BOARDER_CHARS[:top_right_corner])

    # Print page contents
    for line in lines
        print(io, _PAGE_BOARDER_CHARS[:edge_vertical], _PAGE_BOARDER_CHARS[:blank])
        print(io, line)
        print(io, _PAGE_BOARDER_CHARS[:blank] ^ (line_width - length(line) + 1))  # right padding
        println(io, _PAGE_BOARDER_CHARS[:edge_vertical])
    end

    # Print bottom boarder
    print(io, _PAGE_BOARDER_CHARS[:bottom_left_corner])
    print(io, _PAGE_BOARDER_CHARS[:edge_horizontal] ^ (line_width + 2))
    print(io, _PAGE_BOARDER_CHARS[:bottom_right_corner])
end
