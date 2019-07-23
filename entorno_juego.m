function [posx,posy,puntuacion] = entorno_juego(Video, posx, posy, puntuacion)

existe1 = 0;
existe2 = 0;
existe3 = 0;
existe4 = 0;
bandera = 1;
salir = 0;
font_size = 12;
color = [220 220 220]/255;
font_name = 'Bauhaus 93';
text(20,250,'Vidas: ', 'FontSize', font_size, 'Color', color, 'FontName', font_name);
text(220,250,'Puntos: ', 'FontSize', font_size, 'Color', color, 'FontName', font_name);

%% Se configuran los parametros del fondo
for i=80:8:272
    for j = 20:8:212
        if(bandera == 1)
            rectangle('Position',[i j 8 8],'FaceColor',[1, 1, 1])
        else
            rectangle('Position',[i j 8 8],'FaceColor',[0.8, 0.8, 0.8]);
        end
        bandera = -bandera;
    end
end

%% Lineas que rodean el escenario
rectangle('Position',[30 95 49 50],'FaceColor',[0.494, 0.827, 0.576]);
rectangle('Position',[79 18 0 76], 'LineWidth',3);
rectangle('Position',[79 19 201 0], 'LineWidth',3);
rectangle('Position',[79 145 0 77], 'LineWidth',3);
rectangle('Position',[79 221 201 0], 'LineWidth',3);
rectangle('Position',[281 18 0 204], 'LineWidth',3);
rectangle('Position',[30 95 50 0], 'LineWidth',3);
rectangle('Position',[30 145 50 0], 'LineWidth',3);
rectangle('Position',[30 95 0 50], 'LineWidth',3);

%% Se configuran las circunferencias objetivo 
alimento1 = rectangle('Position', [130-5, 70-5, 10, 10], 'Curvature', [1 1],'FaceColor', [255/255 145/255 18/255],'LineWidth',2,'EdgeColor',[255/255 18/255 18/255]);
alimento2 = rectangle('Position', [130-5, 170-5, 10, 10], 'Curvature', [1 1],'FaceColor', [255/255 145/255 18/255],'LineWidth',2,'EdgeColor',[255/255 18/255 18/255]);
alimento3 = rectangle('Position', [230-5, 70-5, 10, 10], 'Curvature', [1 1],'FaceColor', [255/255 145/255 18/255],'LineWidth',2,'EdgeColor',[255/255 18/255 18/255]);
alimento4 = rectangle('Position', [230-5, 170-5, 10, 10], 'Curvature', [1 1],'FaceColor', [255/255 145/255 18/255],'LineWidth',2,'EdgeColor',[255/255 18/255 18/255]);

%%Posiciones de las circunferencias enemigo
rad = 12 * [-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8];
x = 180 * ones(17,1)' - rad;
y = 120 * (ones(17,1)');
x1 = 180 * (ones(17,1)');
y1 = 120 * ones(17,1)' - rad;
vel_angular = 0.2; %[rad/s]
dt = 0.5;
tetha = 0;

%% Se configura el sonido

[y,Fs] = audioread('hola.wav');
player = audioplayer(y,Fs);
play(player);

while(1)
    
    puntos = text(280,250,num2str(puntuacion), 'FontSize', font_size, 'Color', color, 'FontName', font_name);
    
    for i=1:17
        var = strcat('h',num2str(i));
        obstaculo.(var) = rectangle('Position', [x(i)-5, y(i)-5, 10, 10], 'Curvature', [1 1],'FaceColor', 'blue','LineWidth',1,'EdgeColor',[0 0 0]);
    end

    for i=1:17
        var = strcat('s',num2str(i));
        obstaculo.(var) = rectangle('Position', [x1(i)-5, y1(i)-5, 10, 10], 'Curvature', [1 1],'FaceColor', 'blue','LineWidth',1,'EdgeColor',[0 0 0]);
    end
    
    [a, b, cuadro_rojo] = recuadro_rojo(Video, posx, posy);
    
    [posx, posy] = limites_movimiento(a, b);

    %%Deteccion de colision con los enemigos
    
    R = 7+5; %radio del las circunferencias de alimento y el cubo

    for i = 1:17 %%itero sobre obstaculo
        disx = abs(posx - x(i));
        disy = abs(posy - y(i));
        distancia_x = sqrt(disx^2 + disy^2);
        disxx = abs(posx - x1(i));
        disyy = abs(posy - y1(i));
        distancia_y = sqrt(disxx^2 + disyy^2);
        if (distancia_x < R || distancia_y < R)
            area_juego = imread('game_over.jpg');
            area_juego = imresize(area_juego,[240 320]);
            %imshow(area_juego);
            %Mensaje = text(80,110,'GAME OVER!', 'FontSize', 20, 'Color', 'Red');
            clear player;
            [y,Fs] = audioread('risa.wav');
            player = audioplayer(y,Fs);
            play(player);
            bb1(:,:,1) = uint8(ones(240,320));
            bb1(:,:,2) = uint8(ones(240,320));
            bb1(:,:,3) = uint8(ones(240,320));

            %%para mostrar una escena lentamente, fundido de imagenes
            for p = 0:0.1:1
                cc1 = area_juego*p + bb1*(1-p);
                imshow(cc1);
                pause(0.00000001);
            end

            aa1 = cc1;
            imagen_fondo(:,:,1) = uint8(ones(240,320));
            imagen_fondo(:,:,2) = uint8(ones(240,320));
            imagen_fondo(:,:,3) = uint8(ones(240,320));
            cc1 = aa1/2 + imagen_fondo/2;

            for p = 0:0.1:1
                cc1 = imagen_fondo*p + aa1*(1-p);
                imshow(cc1);
                pause(0.00000001);
            end           
            salir = 1;
            break;
        end
    end
    if(salir == 1)
        break;
    end

    disx1 = abs(posx - 130);
    disx2 = abs(posx - 130);
    disx3 = abs(posx - 230);
    disx4 = abs(posx - 230);

    disy1 = abs(posy - 70);
    disy2 = abs(posy - 170);
    disy3 = abs(posy - 70);
    disy4 = abs(posy - 170);

    distancia1 = sqrt(disx1^2 + disy1^2);
    distancia2 = sqrt(disx2^2 + disy2^2);
    distancia3 = sqrt(disx3^2 + disy3^2);
    distancia4 = sqrt(disx4^2 + disy4^2);

    if (distancia1 <= R && existe1 == 0)
        puntuacion = puntuacion + 1;
        set(alimento1, 'Visible', 'off');
        existe1 = 1;
    elseif (distancia2 <= R && existe2 == 0)
        puntuacion = puntuacion + 1;
        existe2 = 1;
        set(alimento2, 'Visible', 'off');
    elseif (distancia3 <= R && existe3 == 0)
        puntuacion = puntuacion + 1;
        existe3 = 1;
        set(alimento3, 'Visible', 'off');
    elseif (distancia4 <= R && existe4 == 0)
        puntuacion = puntuacion + 1;
        existe4 = 1;
        set(alimento4, 'Visible', 'off');
    end

    if (puntuacion == 4)
        if (a > 33 && a<79)
            if (b > 97 && b < 143)
                %Ganador = text(60,200,'Has Ganado');
                %set(Ganador,'Fontsize',10,'color','blue','FontName','Chiller' )
                area_juego = imread('winner.jpg');
                area_juego = imresize(area_juego,[240 320]);
                %imshow(area_juego);
                %Mensaje = text(80,110,'GAME OVER!', 'FontSize', 20, 'Color', 'Red');
                clear player;
                [y,Fs] = audioread('win.wav');
                player = audioplayer(y,Fs);
                play(player);
                fundido(area_juego,1);
                fundido(area_juego,0);
                break;
            end
        end
    end
      
    %%Actualización de la posicion de cada enemigo

    tetha = tetha + vel_angular* dt;
    if(tetha >= 2*pi)
        tetha = tetha - 2*pi ;
    end
    for i = 1:length(x)
        x(i) = rad(i)*cos(tetha) + 180;
        x1(i) = rad(i)*cos(tetha+pi/2) + 180;
        y(i) = rad(i)*sin(tetha) + 120;
        y1(i) = rad(i)*sin(tetha+pi/2) + 120;
    end

    pause(0.0000001);

    %%Desactivar obstaculos para no sobrecargar el sistema
    for  i = 1:17
        var = strcat('h',num2str(i));
        set(obstaculo.(var),'Visible','off');
    end

    for  i = 1:17
        var = strcat('s',num2str(i));
        set(obstaculo.(var),'Visible','off');
    end

    set(cuadro_rojo,'Visible','off');
    set(puntos,'Visible','off');
end

puntuacion = 0;