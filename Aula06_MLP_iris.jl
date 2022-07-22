using PyPlot
using DelimitedFiles
using LinearAlgebra
include(pwd() * "\\funcoes.jl")

pygui(true)
close("all")
println("New run")

#Leitura e tratamento dos dados
dados = readdlm("bases/iris.txt");
idcs = findall(x-> x == 1.0,dados[:,end]);
x1 = dados[idcs,1:4];
idcs = findall(x-> x == 2.0,dados[:,end]);
x2 = dados[idcs,1:4];
idcs = findall(x-> x == 3.0,dados[:,end]);
x3 = dados[idcs,1:4];

#Montanto matriz x e yd
x = [x1' x2' x3'];
x = [x;ones(1,size(x,2))];
n = size(x1',2)
y1 = ones(3,n).*[1;0;0];

n = size(x2',2)
y2 = ones(3,n).*[0;1;0];

n = size(x3',2)
y3 = ones(3,n).*[0;0;1];

yd = [y1 y2 y3];

#Inicialização do método
w1 = randn(100,5)
w2 = randn(3,101)
alpha = 10^-2
ciclos = 20
N = size(x,2)
kmax = ciclos*N
eqm = zeros(1,ciclos+1)

y = logistica.(w2*[tanh.((w1*x)); ones(1,N)])
eqm1 = sum((yd - y).^2)/size(yd,2)
eqm[1] = eqm1;
println("EQM inicial: ", eqm1)
for c in 1:ciclos
    global idcs, eqm, w2, w1, N,y
    idcs = sortperm(rand(150))
    for n in idcs
        global w1, w2, x, y, a1, yd, e, alpha, grad1, grad2, idcs
        a1 = tanh.(w1*x[:,n])
        y = logistica.(w2*[a1 ; 1])
        e = yd[:,n]-y
        grad1 = (((w2'*(-e.*(1 .-y).*y))[1:end-1]).*(1 .- a1.^2))*x[:,n]'
        w1 = w1 - alpha*grad1
        grad2 = (-e.*(1 .-y).*y)*[a1;1]'
        w2 = w2 - alpha*grad2
    end
    y = logistica.(w2*[tanh.((w1*x)); ones(1,N)])
    eqm[c+1] = sum((yd - y).^2)/size(yd,2)
end

y = logistica.(w2*[tanh.((w1*x)); ones(1,N)])
eqm2 = sum((yd - y).^2)/size(yd,2)
println("EQM final: ", eqm2)

#Contangem de acertos
y_d = zeros(1,size(y,2))
y_ = zeros(1,size(y,2))

j = 0
while(j < size(y,2))
    global j
    y_[j+1]  = argmax(y[:,j+1])
    y_d[j+1] = argmax(yd[:,j+1])
    j = j+1
end

i = 0
cont = 0
while(i < size(y,2))
    global i,cont,y_,y_d
    i = i +1
    if(y_[i] == y_d[i])
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