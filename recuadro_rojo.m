%--------------------------------------------------------------------------
%-- 5. Deteccion de objeto color azul en camara y acoplarlo a movimietno de cuadro rojo
%--------------------------------------------------------------------------

% Esta funcion segmenta la imagen del video, permitiendo reconocer objetos
% de color azul, determinar su posicion respecto a la zona de juego y poder
% mover el cuadro rojo segun el movimiento del objeto frente a la camara

function [pos_x,pos_y, cuadro_rojo] = recuadro_rojo(Video, posx, posy)

% -- Se determinan las propiedades para dibujar el cuadro rojo a mostar en la
% -- zona de juego dependiendo de la posicion del objeto frente a la camara

posicion = [posx - 7, posy - 7, 14, 14];
color_cuadro = 1/255*[114 30 30];
cuadro_rojo = rectangle('Position', posicion ,'FaceColor', 'red','LineWidth', 2,'EdgeColor', color_cuadro);
    
%%Camara 
solo_rojo = getsnapshot(Video);     % Retorna una imagen de un frame del video
solo_rojo = flip(solo_rojo,2);      % Retorna en 2 dimensiones la imagen tomada
solo_rojo = imsubtract(solo_rojo(:,:,3),rgb2gray(solo_rojo));   % Resta la capa de color azul de la imagen convertida en blano y negro
solo_rojo = medfilt2(solo_rojo, [3 3]);     % Realiza un filtro de media en un rango (3,3)
solo_rojo = im2bw(solo_rojo, 0.2);      % Binariza la imagen en base a la intensidad de 0.2

[matriz, elem] = bwlabel(solo_rojo);    % Retorna la imagen en una matriz de labels de 8 conexiones
cuadro_rojos = solo_rojo;               
[filas, col] = size(matriz);            % Obtiene filas y columnas de la matriz de labels

bandera_disk = 0;

for i = 1:elem
    temp = zeros(filas,col);    % Crea una matriz en blanco que almacenar� cada objeto segmentado
    temp(matriz==1) = 1;        % Todos los valores donde la matriz de label sea 1 los cambia por 1 en la matriz en blanco

    area = sum(temp(:));        % Suma todos los unos que representan al objeto y se obtiene el area
    
    %-- Condicional para descartar los objetos que no nos interesan (solo se capturan objetos con area mayor a 400px)
    
    if(area > 100)
        cuadro_rojos = temp;    % Guarda objeto segmentado
        bandera_disk = 1;
    end
end

cuadro_rojos = imresize(cuadro_rojos,[240 320]);    % Escala el objeto segmentado al tama�o de la zona de juego (240, 320)

% Si determina el objeto en la segmentacion, bandera_disk se vuelve 1 y
% determina el centroido, si no se cumple, guarda la posicion anterior.

if(bandera_disk ==1)
    centro{1} = regionprops(cuadro_rojos,'Centroid');   % Optiene el centroide del objeto segmentado
else
    centro{1}.Centroid(1) = posx;   
    centro{1}.Centroid(2) = posy;
end

pos_x = centro{1}.Centroid(1);  % Posicion en x del objeto para posicion el cuadro rojo
pos_y = centro{1}.Centroid(2);  % Posicion en y del objeto para posicion el cuadro rojo
pause(0.0000000001)             % Pausa para suavizar el cambio de posicion del cuadro rojo

