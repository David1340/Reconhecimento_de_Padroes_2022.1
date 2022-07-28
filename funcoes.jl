logistica(x::Real) = one(x)/(one(x) + exp(-x))
relu(x::Real) = x > 0 ? x : 0