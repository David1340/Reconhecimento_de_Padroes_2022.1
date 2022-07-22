function logistica(x::Real)
    return one(x)/(one(x) + exp(-x))
end