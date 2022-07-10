#Nesta aula aprendemos:
#   i)Instalar os pacotes necessários para a disciplina
#   ii)Plotar imagens
#   iii)Visualizar dados 3D

#Instalação dos pacotes:
#using Pkg
#Pkg.add("PyPlot")
#Pkg.add("DelimitedFiles")

using PyPlot
using DelimitedFiles

pygui(true) #Ele é necessário apenas no vs code criação de figuras

#pwd() #Mostra o diretorio atual
#cd("C:\\Documentos\\David UFS\\9º semestre\\Reconhecimento de padrões\\Julia") #troca o diretorio em que estmamos

close("all") #Fecha todas as figuras

x = readdlm("bases/numeros.txt",Float16); #Lê o arquivo numeros.txt, caso esteja no linux troque Float16 por Float64

y = reshape(x[7,1:end-1],(16,16)); #Cria uma matriz (16 x 16) a partir das 16^2 colunas da linha 7 da matriz x
figure() #Abri uma figura
imshow(y') #Plota uma imagem a partir da transposta da matriz y 

figure() #Abri uma figura
x2 = readdlm("bases/iris.txt",Float16); #Ler o arquivo iris.txt
idcs = findall(x-> x == 1.0,x2[:,end]); #Encontra os índices das linhas de x2 as quais tem como última coluna 
#o valor igual a 1.0 
y1 = x2[idcs,:]; #Armazena em y2 as linhas listadas no vetor idcs

#Repete o mesmo para 2.0, e 3.0
idcs = findall(x-> x == 2.0,x2[:,end]);
y2 = x2[idcs,:];

idcs = findall(x-> x == 3.0,x2[:,end]);
y3 = x2[idcs,:];

#Plote 3D dos dados, com cores diferentes
scatter3D(y1[:,1],y1[:,2],y1[:,3],color = "red")
scatter3D(y2[:,1],y2[:,2],y2[:,3],color = "black")
scatter3D(y3[:,1],y3[:,2],y3[:,3],color = "blue")

#Leitura de uma imagem e seu plot
figure()
x3 = imread("Imagens sinteticas/para_raios0.png");
imshow(x3)