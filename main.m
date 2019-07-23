clear all;objects = imaqfind; delete(objects);
close all
clc

posx = 30;
posy = 30;
puntuacion = 0;

Video = videoinput('winvideo', 1,'MJPG_160x120');
set(Video,'FramesPerTrigger',Inf); 
set(Video,'returnedcolorspace','rgb')
start(Video);
[y,Fs] = audioread('hola.wav');
player = audioplayer(y,Fs);
play(player);
area_juego = imread('titulo1.JPG');
fundido(area_juego,0)
font_size = 12;
font_name = 'Bauhaus 93';
clear player;
[y,Fs] = audioread('cuadrar.wav');
player = audioplayer(y,Fs);

while(1)
    play(player);
    [posx,posy] = inicio_juego(Video, posx, posy);
    [posx,posy,puntuacion] = entorno_juego(Video, posx, posy, puntuacion);
end