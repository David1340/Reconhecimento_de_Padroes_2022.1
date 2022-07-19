using PyPlot
using DelimitedFiles
using  LinearAlgebra
pygui(true)
close("all")

#Nesta aula foram estudados os conceitos de arvore de decisão e Classificadores Lineares
dados = readdlm("bases/iris.txt");
idcs = findall(x-> x == 1.0,dados[:,end]);
x1 = dados[idcs,1:4];
idcs = findall(x-> x == 2.0,dados[:,end]);
x2 = dados[idcs,1:4];
idcs = findall(x-> x == 3.0,dados[:,end]);
x3 = dados[idcs,1:4];

subplot(211)
scatter3D(x1[:,1],x1[:,2],x1[:,3],color = "yellow");
scatter3D(x2[:,1],x2[:,2],x2[:,3],color = "red");
scatter3D(x3[:,1],x3[:,2],x3[:,3],color = "blue");

#Note que nessas imagens todos os dados poderiam ser separados por meio de decisões de if e else
#Um dos critérios que são minizados por meio das decisões é a medida de entropia dos dados
#Como associar Entropia a um conjundo de dados ? (1948 =- Shannon):
#Informação após acontecer a k-enésima classe:
#I_k = log(1/p_k), onde p_k é a probabilidade do evento k acontecer
#Como há k classes precisamos calcular a média entre eles (Entropia):
#E[I] (valor esperado da variável aleatória I) = SUM_k (P_k * I_k)
#E[I] = SUM_k (P_k *  log(1/p_k)) = -SUM_k (P_k *  log(p_k)) - Entropia total de um conjunto
#Caso aja mais conjunto:
#H_total = (H1*N1 + H2*N2 +  ... Hn*Nn)/(N1 + N2 + ... Nn)

###########################Tarefa#########################

x = [x1' x2' x3'];
x = [x;ones(1,size(x,2))];
n = size(x1',2)
y1 = ones(3,n).*[1;0;0];

n = size(x2',2)
y2 = ones(3,n).*[0;1;0];

n = size(x3',2)
y3 = ones(3,n).*[0;0;1];

y = [y1 y2 y3];

w = y*x'*inv(x*x');

yc = w*x

y_new = zeros(1,size(yc,2))

y_real = zeros(1,size(yc,2))
j = 0
while(j < size(y_new,2))
    global j
    y_new[j+1]  = argmax(yc[:,j+1])#argmin(sum((yc[:,j+1] .- Matrix(I,3,3)).^2,dims = 1))[2]
    y_real[j+1] = argmax(y[:,j+1])
    j = j+1
end

idcs = findall(x-> x == 1.0,y_new[:]);
x1 = x[1:4,idcs]';
idcs = findall(x-> x == 2.0,y_new[:]);
x2 = x[1:4,idcs]';
idcs = findall(x-> x == 3.0,y_new[:]);
x3 = x[1:4,idcs]';

figure()
scatter3D(x1[:,1],x1[:,3],x1[:,4],color = "yellow");
scatter3D(x2[:,1],x2[:,3],x2[:,4],color = "red");
scatter3D(x3[:,1],x3[:,3],x3[:,4],color = "blue");


i = 0
cont = 0
while(i < size(y_real,2))
    global i,cont,y_new,y_real
    i = i +1
    if(y_new[i] == y_real[i])
        global cont
        cont = cont +1
    end
end
e = yc - y;
println("taxa de acerto:",  round(cont/size(y_real,2) * 100, digits = 4))
println("EQM: ",round(sum(e.^2)/size(y,2),digits = 4))


#taxa de acerto:84.6667
#EQM: 0.2709
