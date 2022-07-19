using PyPlot
using DelimitedFiles
using LinearAlgebra
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
w = randn(3,5)
alpha = 10^-3
k = 1
kmax = 1000000

y = w*x;
e = yd - y;
eqm = zeros(1,kmax)

erro_inicial = sum(e.^2)/size(y,2)
println("Eqm inicial:",erro_inicial)

#Iteração do método
aux = true
while(k < kmax +1)
    global k,w,y,x,e,aux,eqm,J
    k = k +1
    idc = rand(1:size(y,2))
    local e2 = e[:,idc]
    local x2 = x[:,idc]
    w = w + alpha*e2*x2'
    y = w*x;
    e = yd - y;
    eqm[k-1] = sum(e.^2)/size(y,2)
end

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

println("EQM final:",  round(eqm[end],digits = 4))
println("Taxa de acerto:",  round(cont/size(y,2) * 100,digits = 2))


#EQM final:0.2719
#Taxa de acerto:84.0

#k = LinRange(1,kmax,kmax);
#plot(k[:],eqm[:]);

