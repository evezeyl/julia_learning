# 20140111 Julia basis

## vscode shortcut

send to terminal Ctrl+Shift+P

## To do

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


#
trebuchet = Trebuchet(500, 0.25pi)
Trebuchet

environment = Environment(5, 100)

# make a different type of trebuchet - hierarchy of types
mutable struct Trebuchet <: AbstractVector{Float64}> # special type of Trebuchet with another type ---> similar to class hierarchy
  counterweight::Float64
  relaase_angle::Float64
end

# will give an error because a immutable (something is a constant) here - did not really understand
# Ah yes because the definition was just as struct which is immutable
# keyword arguments need special structure - constructor - to create new structure

```

- automatically create doc strings - so ? - then the type to see how the type was defined (guves you a summary)

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

Concreate and abstract types

```julia
1.0 isa #type
1.0 isa Real
1.0 isa Number
1.0 isa Float64
1.0 isa Float32
Float32(1.0) isa Float32

```

### Environments and package manager

- julia as build in env
-

```julia
# in pkg ]
activate projects/trebuchet
# can install packages that will only only be installed in this environment
add Trebuchet
add Trebuchet#dev
status
activate # not the project package
activate projects/trebuchet
```

import as different name

```julia
import Trebuchet as Trebuchets
```

### Functions

```julia
names
?names # :: keyword arg, optional when default values

names(Trebuchets, all = true, imported = true) # use the imported name - separator can be , or ; BUT when define needs to be ;
names(Trebuchets) # the ones we are supposed to use
```

aim is to launch 100 m ...

```julia
# ?
Trebuchets.shoot
# >
Trebuchets.shoot(5, 025pi, 500)
[slice]

function shoot_distance(wind, angle, weight)
  Trebuchets.shoot(wind, angle, weight)[2]
  end
# julia returns last line

# takes the args trebuchet struc and the str environment (allows using then the previous types)
function shoot_distance(trebuchet::Trebuchet, environment::Environment) # here that is the structures we defined
  Trebuchets.shoot(environment.wind, trebuchet.release_angle, trebuchet.counterweight)[2] # here its the package
end

shoot_distance(5, angle = 0.25pi, weight = 500)

```

```julia

```

```julia

```

```julia

```

```julia

```

```julia

```

```julia

```
