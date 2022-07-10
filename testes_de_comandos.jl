#Testes básicos para se familiarizar com a linguagem
#using Plots

print("\n","\n","\n")
println("************New run***************")

#Exemplos de operações matemáticas básicas
a = 2
println("a = 2")
b = 3
println("b = 3")
println("a + b = ",a + b,'\n')
println("a - b = ",a - b,'\n')
println("a * b = ",a * b,'\n')
println("a / b = ",a / b,'\n')
println("a^2 = ",a ^ b,'\n')
println("sqrt(a) = ", sqrt(a))

a = 2.1
println("a = ",a)

#Exemplo de criação de matriz (3 x 2) e (2 x 3)
#Diferente do matlab não pode ser usado ',' para separar elementos de uma mesma linha
x = [1 2; 3 4; 5 6];
println("x", x)
y = [1 0 0; 0 0 0];
println("y", y)
x * y

x = [2 1 ; 0 4]
inv(x)
x*inv(x)
println(x')

for i in [1 2 3 4 5 6]
    println(i)
    println("i = $(i)")
end

println(typeof(a))
a = round(Int,a)
println(typeof(a))

a = LinRange(2.5,10,2)

for i in LinRange(0,10,5)
    println(i)
    println("i = $(i)")
end

a = 1 + 7im
b = 9 + 3im
y = a + b
abs(y)
angle(y)
x = LinRange(0,2*pi,20)
y = cos.(x)
println(x[end])

plot(x,y)