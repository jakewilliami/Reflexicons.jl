<h1 align="center">Reflexicons</h1>

## Background

_Reflexicons_ (reflexive lexicons, as coined by Lee Sallows) are self-enumerating word lists that describes its own letter frequency.  We start with arbitrary text on one page, and the next page enumerates the number of letters (written out in full) on the previous page, and so on and so forth.  A _autogram_ is a true self-descriptive sentence.  When iterating over "pages" of the state of a reflexicon, one may encounter loops.  An autogram is then one of these loop whose period/cycle length is one.

For more information on reflexicons more eloquently, see Lee Sallows' [article on reflexicons](https://www.leesallows.com/files/Reflexicons%20NEW(4c).pdf).

## Quick Start

```julia
julia> using Reflexicons

julia> R = ReflexiconState("x")  # construct a reflexicon with an initial state
PAGE 1
┌───┐
│ x │
└───┘

julia> next!(R) # go to the next page, modifying
 PAGE 2
┌───────┐
│ one x │
└───────┘

julia> next!(R)
 PAGE 3
┌───────┐
│ one e │
│ one n │
│ one o │
│ one x │
└───────┘

julia> first!(R)
PAGE 1
┌───┐
│ x │
└───┘
```
