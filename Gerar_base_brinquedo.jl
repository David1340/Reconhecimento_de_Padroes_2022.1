using PyPlot
using DelimitedFiles
using LinearAlgebra
close("all")

escala = Diagonal([2,5]);
viés = [0;0];
n = 50;
c3 = escala*rand(2,n) .+ viés;
aux = c3;
escala = Diagonal([2,2]);
viés = [8;0.5];
c3 = escala*rand(2,n) .+ viés;
c3 = [aux c3];
c3 = [c3;3*ones(1,2*n)];

escala = Diagonal([2,2]);
viés = [4;0.5];
c2 = escala*rand(2,n) .+ viés;
c2 = [c2;2*ones(1,n)];

escala = Diagonal([4,2]);
viés = [5;3];
c1 = escala*rand(2,n) .+ viés;
c1 = [c1;1*ones(1,n)];

pygui(true);
scatter(c3[1,:],c3[2,:],color = "blue");
scatter(c2[1,:],c2[2,:],color = "red");
scatter(c1[1,:],c1[2,:],color = "yellow");

base = [c3';c1';c2'];
base = round.(base,digits = 2);
writedlm("bases/base_brinquedo.txt",base);