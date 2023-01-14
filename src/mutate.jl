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
    R.page_io = _write_out_page(R.data)
    R.page += 1

    return R
end
