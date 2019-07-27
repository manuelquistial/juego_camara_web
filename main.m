%--------------------------------------------------------------------------
%------- The Hardest World Game Son ---------------------------------------
%------- Por: Daniel Lopez    david.fernandez@udea.edu.co -----------------
%-------      CC 71629489 -------------------------------------------------     
%-------      Estudiantes de Ingenieria Electronica UdeA ------------------
%------- Por: Manuel Quistial    manuel.quistial@udea.edu.co --------------
%-------      CC 1113533874 -----------------------------------------------  
%-------      Estudiantes de Ingenieria Electronica UdeA ------------------
%------- Curso Procesamiento digital de Imagenes --------------------------
%------- V1 Julio de 2019 -------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%-- 1. Inicializo el sistema ----------------------------------------------
%--------------------------------------------------------------------------

clear all   % Inicializa todas las variables
close all   % Cierra todas las ventanas, archivos y procesos abiertos
clc         % Limpia la ventana de comandos

objects = imaqfind; delete(objects);

%--------------------------------------------------------------------------
%-- 2. Paso de obtencion de video, imagenes y audios  ---------------------
%--------------------------------------------------------------------------

%-- Se toma el video desde la camara

Video = videoinput('winvideo', 2,'YUY2_160x120');   % Obtiene datos de la camara
set(Video,'FramesPerTrigger', Inf);                 % Captura de frames desde el incio hasta el final o hasta que se llene el buffer
set(Video,'returnedcolorspace','rgb')               % Determina la camputa de la imagen rn RGB
start(Video);                                       % Inicializa captura del video

%-- Se toma e inicializa el audio hola guardado en la carpeta juego_camara_web

[y,Fs] = audioread('hola.wav');  % Carga los datos del audio hola y su frecuencia                         
player = audioplayer(y,Fs);      % Crea un objeto audioplayer con los datos del audio hola y su frecuencia
play(player);                    % Inicializa el audio hola

%-- Se toma la imagen titulo1 guardado en la carpeta juego_camara_web

area_juego = imread('titulo1.JPG');  % Carga los datos que contiene la imagen titulo1

%-- Se inicializa la imagen titulo1 y finaliza audio hola

fundido(area_juego,0)   % Esconde en difuminado la imagen titulo1, pasando 0 como segundo parametro
clear player;           % Detiene reproduccion de audio hola

%-- Se toma el audio cuadrar guardado en la carpeta juego_camara_web

[y,Fs] = audioread('cuadrar.wav');  % Carga los datos del audio cuadrar y su frecuencia 
player = audioplayer(y,Fs);         % Crea un objeto audioplayer con los datos del audio cuadrar y su frecuencia

%--------------------------------------------------------------------------
%-- 3. Paso de inicio de juego y su jugabilidad  ---------------------
%--------------------------------------------------------------------------

%-- Inicializo posicion de recuadro rojo

posx = 30;  % Inicializa posicion en x del cuadro rojo en la pantalla de juego
posy = 30;  % Inicializa posicion en y del cuadro rojo en la pantalla de juego

%-- Loop infinito que contiene inicio y jugabiliad del juego
while(1)
    play(player); % Inicializa el audio cuadrar
    [posx,posy] = inicio_juego(Video, posx, posy);  % Inicializa entorno del juego
    [posx,posy] = entorno_juego(Video, posx, posy); % Inicializa jugabilidad del juego
end