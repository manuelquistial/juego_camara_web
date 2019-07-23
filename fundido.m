function fundido(imagen,reves)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[fil,col] = size(imagen);
matriz = uint8(zeros(fil,col/3));
b(:,:,1) = matriz;
b(:,:,2) = matriz;
b(:,:,3) = matriz;
aux = imagen;
if(reves == 1)
    imagen = b;
    b = aux;
end

for i = 0:0.1:1
    c = b.*i + imagen.*(1-i);
    imshow(c);
    
end

end

