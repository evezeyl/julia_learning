using Pkg
Pkg.activate("projects/trebuchet")
import Trebuchet as Trebuchets
using ForwardDiff: gradient

mutable struct Trebuchet <: AbstractVector{Float64}
    counterweight::Float64
    release_angle::Float64
end

Base.size(::Trebuchet) = tuple(2)

function Base.getindex(trebuchet::Trebuchet, i::Int)
    if i == 1
        return trebuchet.counterweight
    elseif i == 2
        return trebuchet.release_angle
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i == 1
        trebuchet.counterweight = v
    elseif i == 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

struct Environment
    wind::Float64
    target_distance::Float64
end
# hum ... why to do that twice ?
function shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function shoot_distance(trebuchet::Trebuchet, env::Environment)
    shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

function aim(trebuchet::Trebuchet, environment::Environment; ε=1e-1, η=0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
    while abs(hit(better_trebuchet)) > ε
        grad = gradient(hit, better_trebuchet)
        better_trebuchet -= η * grad
    end
    return Trebuchet(better_trebuchet[1], better_trebuchet[2])
end
