function [posx,posy] = inicio_juego(Video, posx, posy)

area_juego = imread('inicio.JPG');
area_juego = imresize(area_juego,[240 320]);
fundido(area_juego,1);
% font_size = 12;
% color = [220 220 220]/255;
% font_name = 'Bauhaus 93';
Rectangulo = rectangle('Position',[30 95 49 50],'FaceColor','green');
%text(90,80,'Posicione un circulo rojo', 'FontSize', font_size, 'Color', color, 'FontName', font_name);
%text(90,100,'frente a la camara', 'FontSize', font_size, 'Color', color, 'FontName', font_name);
%text(90,120,'Mueva el cuadro rojo dentro', 'FontSize', font_size, 'Color', color, 'FontName', font_name);
%text(90,140,'del cuadro verde para INICIAR', 'FontSize', font_size, 'Color', color, 'FontName', font_name);
%text(90,160,'No lo mueva de esa posicion', 'FontSize', font_size, 'Color', color, 'FontName', font_name);

while(1)
    
    if(posx>40 && posx<60)
        if(posy>105 && posx<120)
            break;
        end
    end
    
    [posx, posy, cuadro_rojo] = recuadro_rojo(Video, posx, posy);
        
    set(cuadro_rojo,'Visible','off');
         
end

set(Rectangulo,'Visible','off');

a = uint8(area_juego);
a = imresize(a,[280 320]);
fundido(a,0);

imagen_fondo = imread('fondo.jpg');
imagen_fondo = imresize(imagen_fondo,[280 320]);

fundido(imagen_fondo,1);