using PyPlot
using DelimitedFiles
using LinearAlgebra
include(pwd() * "\\funcoes.jl")

pygui(true)
close("all")
println("New run")

#Leitura e tratamento dos dados
dados = readdlm("bases/numeros.txt");
x = dados[:,:]';
x[end,:] .= 1;
N = size(x,2)
#Montanto matriz x e yd
yd = zeros(10,N)

for i = 1:N
    yd[Int(dados[i,end])+1,i] = 1
end

#Inicialização do método
#w1 = 0.1*randn(432,257)
#w2 = 0.1*randn(48,433)
w1 = 0.1*randn(80,257)
w2 = 0.1*randn(40,81)
w3 = 0.1*randn(20,41)
w4 = 0.1*randn(10,21)
alpha = 10^-3
ciclos = 150

eqm = zeros(1,ciclos+1)

y = tanh.(w4*[tanh.(w3*[tanh.(w2*[tanh.((w1*x)); ones(1,N)]) ;  ones(1,N)]) ; ones(1,N)])
eqm1 = sum((yd - y).^2)/size(yd,2)
eqm[1] = eqm1;
println("EQM inicial: ", eqm1)
for c in 1:ciclos
    #println(c)
    global idcs, eqm, w1, w2, w3, w4,N,x,yd
    local y
    idcs = sortperm(rand(N))
    for n in idcs
        global w1, w2, w3, w4,x,yd,alpha
        local y,e1, e2, e3,a1,a2,a3,e,grad1,grad2,grad3
        a1 = tanh.(w1*x[:,n])
        a2 = tanh.(w2*[a1;1])
        a3 = tanh.(w3*[a2;1])
        y = tanh.(w4*[a3;1])

        e = yd[:,n]-y

        e4 = -e.*(1 .-y.^2)
        e3 = ((w4'*e4)[1:end-1]).*(1 .- a3.^2)
        e2 = ((w3'*e3)[1:end-1]).*(1 .- a2.^2)
        e1 = ((w2'*e2)[1:end-1]).*(1 .- a1.^2)

        println(sqrt(sum(e1.^2)))
        grad1 = e1*x[:,n]'
        grad2 = e2*[a1;1]'
        grad3 = e3*[a2;1]'
        grad4 = e4*[a3;1]'

        w1 = w1 - alpha*grad1
        w2 = w2 - alpha*grad2
        w3 = w3 - alpha*grad3
        w4 = w4 - alpha*grad4
    end

    y = tanh.(w4*[tanh.(w3*[tanh.(w2*[tanh.((w1*x)); ones(1,N)]) ;  ones(1,N)]) ; ones(1,N)])
    eqm[c+1] = sum((yd - y).^2)/size(yd,2)
end

y = tanh.(w4*[tanh.(w3*[tanh.(w2*[tanh.((w1*x)); ones(1,N)]) ;  ones(1,N)]) ; ones(1,N)])
eqm2 = sum((yd - y).^2)/size(yd,2)
println("EQM final: ", eqm2)

#Contangem de acertos
yd2 = dados[:,end]' .+1
y2 = zeros(1,size(y,2))

j = 0
while(j < size(y,2))
    global j
    y2[j+1]  = argmax(y[:,j+1])
    j = j+1
end

i = 0
cont = 0
while(i < size(y,2))
    global i,cont,y2,yd2
    i = i +1
    if(y2[i] == yd2[i])
        global cont
        cont = cont +1
    end
end

println("Taxa de acerto:",  round(cont/size(y,2) * 100,digits = 2),"%")
plot(0:ciclos,eqm[1,:])
#New run 
#EQM inicial: 1.2765598296376395
#EQM final: 0.0292526826418642
#Taxa de acerto:97.33