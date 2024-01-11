# 20140111 Julia basis

## vscode shortcut

send to terminal Ctrl+Shift+P

## To do

- [ ] vscode configure git email and git user
- [ ] save workspace layout
- [ ]

## julia

### Intro

- designed for scientific computing- concept
- C or Fortran - constant consumising
- Julia - mix - lots of premade pieces - a bit of more flexibility
  - aim same speed as fortran and C
  - julia - just in time compiler - possible to inspect lower code - and custumized
  - multiple dispatch : compiler can optimize code to run on specific types eg int or float -> can create 2 optimized functions for each type
  - julia - webpage - compare performace speed to other languages
  - julia prompt is called repl

Assignment `=`
suppress pritint out `;` at the end of the line
pi (symbol) recognized

- must use "" for strings
- escape to go out
- can run julia inside the julia shell
  \... emjoies - can be used
  can run julia eg also in jupyter notebook
  package manager ] - change mode to that
  out of promt backspace or delete

```julia
varinfo() # env
\alpha # ask
pi
? # help switch to help mode
; # switch to shell
include("filename") #copy paste in env run

# install packages - put that in .julia
add OhMyREPL
# import
import # to import of some thing
using OhMyREPL # dud bit work
```

### Types system

- create code to launch trebuchet
- data part - structures - do not have functions attached to it
- functions can act on those data (do something)
- can have 2 functions the same name - that work on 2 different types - will not pose a problem, will select the correct one

? concept - similar to building classes in python and then having functions that act on those classes ? building the data structures

- immutable strings
- identation does not matter in julia

```julia
# The program
# Definition of structure
mutable struct Trebuchet
    counterweight::Float64 # :: annotate adnd give the types
    release_angle::Float64
end

#immutable
struct Environment
    wind::Float64
    target_distance::Float64
end

```

- float types

```julia
supertype(Float64)
supertypes(Float64)
supertypes(Float32)
typeof(1.0)
typeof(1.0f0)
```

- did I understood well eg. if use a supertype ? can it optimize functions for each subtype ?
- so functions for objects that are similar but not the same

```julia

```

```julia

```

```julia

```

```julia

```
