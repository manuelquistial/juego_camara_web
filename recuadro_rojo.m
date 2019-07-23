function [pos_x,pos_y, cuadro_rojo] = recuadro_rojo(Video, posx, posy)

cuadro_rojo = rectangle('Position', [posx - 7, posy - 7, 14, 14],'FaceColor', 'red','LineWidth', 2,'EdgeColor',1/255*[114 30 30]);
    
%%Camara 
solo_rojo = getsnapshot(Video);
solo_rojo = flip(solo_rojo,2); 
solo_rojo = imsubtract(solo_rojo(:,:,1),rgb2gray(solo_rojo));
solo_rojo = medfilt2(solo_rojo, [3 3]);
solo_rojo = im2bw(solo_rojo, 0.2);
[matriz, elem] = bwlabel(solo_rojo);
cuadro_rojos = solo_rojo;
bandera_disk = 0;
[filas, col] = size(matriz);

for i = 1:elem
    temp = zeros(filas,col); % se crea una matriz en blanco que almacenará cada objeto segmentado
    temp(matriz==1) = 1; % todos los valores donde la matriz sea 1 los cambia por 1

    area = sum(temp(:)); % suma todos los unos que representan al objeto y se obtiene el area
    %% condicional para descartar los objetos que no nos interesan (solo se capturan objetos con area mayor a 400px)
    if(area > 100)
        cuadro_rojos = temp; %guardamos el objeto segmentado y binarizamos en la posicion j de la celda
        bandera_disk = 1;
    end
end

cuadro_rojos = imresize(cuadro_rojos,[240 320]);

if(bandera_disk ==1)
    centro{1} = regionprops(cuadro_rojos,'Centroid'); %%me saca el centroide
else
    centro{1}.Centroid(1) = posx;
    centro{1}.Centroid(2) = posy;
end

%a = posx; b = posy;    
pos_x = centro{1}.Centroid(1); 
pos_y = centro{1}.Centroid(2);
pause(0.0000000001)

