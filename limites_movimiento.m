function [posx, posy] = limites_movimiento(a, b)
if (a > 33 && a<79)
    posx = a;
    if (b < 97)
        posy = 97+7;       
    elseif (b > 143)
        posy = 143 - 7;
    else
        posy = b;
    end
end

if (a > 79 && a < 280)
    posx = a;
    if(b < 22)
        posy = 22 + 7;
    elseif (b > 218)
        posy = 218 - 7;
    else
        posy = b;
    end
end

if (a <= 33)
    posx = 33 + 7;
    if(b < 97)
        posy = 97 + 7;
    elseif (b > 143)
        posy = 143 - 7;
    else
        posy = b;
    end
end

if(a >= 278)
    posx = 278 - 7;
    if (b < 22)
        posy = 22 + 7;
    elseif (b > 218)
        posy = 218-7;
    else 
        posy = b;
    end
end