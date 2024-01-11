# 20140111 Julia basis

Thanks to Carpentry people for this course : https://carpentries-incubator.github.io/julia-novice/aio.html

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

Etterpad website - [pad.carpentries.org](https://pad.carpentries.org/Julia_DSdays2024)

just example

```julia
shoot_distance(args...)
function shoot_distance(args...) # slurping
     Trebuchets.shoot(args...)[2] # splatting
end


function (wind, angle, weight)
  Trebuchets.shoot(wind, angle, weight)[2]
end

shoot_function(wind, angle, weight) = Trebuchets.shoot(wind, angle, weight)[2] # one line function

# changing the arguments
a = [1,2,3] # vector

# ! convention to change the argument in jula (for mutating the argument)
function change!(x::AbstractVector)
  x[end] *= 2  # means that it goes through the whole vector -> seems more last index
end

change!(a) # only gave the last one
change!(a[1:end]) ...
# how to get achange!(a[1:end])
a = rand(10)
a[1:2:end] # start by 2 to the end
a .*b #element wise multiblication
a * b #wont work if a and b are vectors
```

- julia is first index

```julia
# local statement - to be sure that variable is local than global - as in bash
env = Environment(5, 100)
trebuchet = Trebuchet(500, pi/4); # ; important to add otherwise will call the visualisations methods within 2function ... so will report an error
#! weird I did not get an error
```

define size
using macro

@which size ... macro that parse the julia code and tell you output (kind of write source code for your) -> gives module where size is defined
@macroexpand @which size # gives which is called

@time size(a) # gives time and memory when function is run

@macroexpand @time size(a) # gives the code that is run

@doc size # gives the doc string

```julia
function Base.size(trebuchet::Trebuchet)
  return tuple(2) # or just write (2) - julia will understand its a tuple
end

```

search doc julia interface and conditionals

- need to get the indexes and ...

```julia
? getindex
function  Base.getindex(trebuchet::Trebuchet, i::Int)
  if i == 1
    return trebuchet.counterweight
  elseif i == 2
    return trebuchet.release_angle
  else
    # throw(BoundsError(trebuchet, i))
    error("Trebuchet only accepts indices 1 and 2m yours is $i")
  end
end

Int # we see its a shortcut for Int64
trebuchet = Trebuchet(500, pi/4)
size(trebuchet) # ok error probably did not define it
getindex(trebuchet, 2)
trebuchet[2]

supertypes(Trebuchet) # gives the hierarchy of types

using LinearAlgebra
dot(trebuchet, trebuchet) # dot product equivalent to .*
trebuchet + [2,2]
trebuchet + [2,2,2] # error one by one
trebuchet .+ 2
trebuchet . trebuchet # did not work (missing something )
```

````

```julia
function Base.setindex!(trebuchet::Trebuchet, value, i::Int)
  if i == 1
    trebuchet.counterweight = value
  elseif i == 2
    trebuchet.release_angle = value
  else
    error("Trebuchet only accepts indices 1 and 2, yours is $i")
  end
end


````

```julia
# need iterator because to elements
@time size(a) shoot_distance(trebuchet)
@time shoot_distance(trebuchet, env) # environment not defined
```

- package benchmarktools - proper time to estimate the time used to run the function

```julia
add BenchmarkTools
@benchmark shoot_distance(trebuchet, env)
using BenchmarkTools
@benchmark shoot_distance(trebuchet, env)


methods(setindex) # so basically set index - adds a method that will work with those types
```

seems to include compile time also .... runs many times ... so better estimation

### Interfaces and conditionals

### Loops

```julia
N = 10
weights =[rand() * 500 for _ = 1:N]  # list comprehension
@code_llvm rand()  # gives the detail

distances = [(w, a) => shoot_distance(Trebuchet(w,a), env) for (w,a) in zip(weights, angles) ] # weight and angle pointing at shoot_distance  (some misspelling here)
```

```julia
add ForwardDiff # already in Trebuchet
using ForwardDiff: gradient
? gradient

function distance_from_target(trebuchet)
  shoot_distance(env.wind, trebuchet[2], trebuchet[1]) - env.target_distance
end

grad = function gradient(shoot_distance, Trebuchet(500, 0,25pi))) # gives the gradient of the function

imprecise_trebuchet = Trebuchet(500, 0.25pi)


?
better_trebuchet = imprecise_trebuchet - 0.05 grad # gradient descent
```

```julia
# course online
function aim(trebuchet, environment; N = 5, η = 0.05)
           better_trebuchet = copy(trebuchet)
           for _ in 1:N
               grad = gradient(x -> (shoot_distance([environment.wind, x[2], x[1]])
                                     - environment.target_distance),
                               better_trebuchet)
               better_trebuchet -= η * grad
           end
           return Trebuchet(better_trebuchet[1], better_trebuchet[2])
       end
```

! immutable struc - cannot be updated so if used in functions eg cannot write a +=! if a is immutable ?
Question about memory place and update - replacement variable ... (copy vs hard copy)

```julia
imprecise_trebuchet = Trebuchet(500.0, 0.25pi);
better_trebuchet = aim(imprecise_trebuchet, env)
```

## Smarter way to store functions

- store in file (cf code cleaned)

```julia
include("code_cleaned.jl")
# look at the methods

#run
imprecise_trebuchet = Trebuchet(500.0, 0.25pi)
environment = Environment(5, 100)
precise_trebuchet = aim(imprecise_trebuchet, environment)
shoot_distance(precise_trebuchet, environment)
```

- then can go to create this as a module - which can be icluded and used
- then modules can go into packages
  See lesson for that
  names(MyModule)
  MyModule.some_private_function # for those that are not exported - how to use those

add /path/to/package (then can say use the packages) # in packages can do that

- benefit julia - very simple to create packages
  - automatically generated from files

# pycall run python in julia # eg plotting ... for plots

# run julia in python

using Plots
add PyPlot

For R ..
https://cran.r-project.org/web/packages/JuliaCall/readme/README.html

Julia - for algorithms - helpfull to write closer to algorithms (eg. maths symbols ...)

discourse.julialang.org/ # forum
carpentries-incubator.github.io/julia-novice/ # course
docs.julialang.org/ # documentation

Feedback form:
nettskjema.no/a/384654
