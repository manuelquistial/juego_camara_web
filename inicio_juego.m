%--------------------------------------------------------------------------
%-- 4. Paso de inicio de juego --------------------------------------------
%--------------------------------------------------------------------------

% Esta funcion determina los parametros iniciales del juego,
% permitiendole al jugador ambientarse antes de inicar el juego.
% Recibe los datos del video y la posicion en que se encuentre el cuadro
% rojo al incializar la funcion. Retorna la posicion en que se encuentre el
% cuadro rojo al finalizar el llamado de la funcion

function [posx,posy] = inicio_juego(Video, posx, posy)

%-- Se inicializan las imagenes de fondo

area_juego = imread('inicio.JPG');              % Carga los datos que contiene la imagen inicio
area_juego = imresize(area_juego,[240 320]);    % Escala la imagen inicio al tamaño de la zona de juego (240, 320)
fundido(area_juego,1);                          % Muestra en difuminado la imagen inicio, pasando 1 como segundo parametro
Rectangulo = rectangle('Position',[30 95 49 50],'FaceColor','green');   % Inicializa zona de posicion para inicio de juego como un restangulo de color verde

%-- Loop que determina la posicion de cuadro rojo en la parte inicial para ambientar al jugador

while(1)
    
    %-- Determina ubicacion del cuadro rojo en zona del cuadro verde
    
    if(posx>40 && posx<60)          %  Posicion en x del cuadro rojo, determinado por ancho de cuadro verde
        if(posy>105 && posy<120)    %  Posicion en y del cuadro rojo, determinado por alto de cuadro verde
            break;                  %   Al posicionarze en la zona del cuadro verde, sale del loop while
        end
    end
    
    %-- Determina la posicion del cuadro rojo en la zona de juego, dependiendo de la posicion de la figura azul que este frente a la camara
    
    [posx, posy, cuadro_rojo] = recuadro_rojo(Video, posx, posy); % Retorna posicion del cuadro rojo y su objeto 
    set(cuadro_rojo,'Visible','off');       % Esconde cuadro rojo para mostrarlo en la nueva posicion
         
end

%-- Se inicializa la zona e imagenes pertinentes a la zona de juego

set(Rectangulo,'Visible','off');    % Esconde cuadro verde de zonoa de juego

fundido(area_juego,0);  % Esconde en difuminado la imagen inicio, pasando 0 como segundo parametro

imagen_fondo = imread('fondo.jpg');                 % Carga los datos que contiene la imagen fondo
imagen_fondo = imresize(imagen_fondo,[280 320]);    % Escala la imagen fondo al tamaño de la zona de juego (240, 320)

fundido(imagen_fondo,1);    % Muestra en difuminado la imagen fondo, pasando 1 como segundo parametro