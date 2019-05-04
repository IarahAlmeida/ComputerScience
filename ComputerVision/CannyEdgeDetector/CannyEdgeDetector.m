% Iarah Gon�alves de Almeida

% Algoritmo de detec��o de bordas de Canny
img = imread('ASpaceOdyssey.jpg');
CannyEdgeDetector(img);

function B = FiveByFiveGaussianFilter(A)
    % defini��o dos par�metros
    k = 2;
    sigma = 1.4;
    H = zeros(((2 * k) + 1), ((2 * k) + 1));
    W = 0;
    % c�lculo do kernel Gaussiano
    for i = 1 : 5
        for j = 1 : 5
            squaredDistance = (i - (k + 1))^2 + (j - (k + 1))^2;
            exp = (-1 * (squaredDistance / (2 * sigma^2)));
            H(i, j) = (1 / (2 * pi * (sigma^2)))^exp;
            W = W + H(i, j);
        end
    end
    % normaliza��o
    H = H / W;
    % convolu��o da imagem pelo coeficiente Gaussiano
    B = conv2(A, H, 'same');
end

function [G, Gx, Gy, theta] = Sobel(A)
    % defini��o dos par�metros
    [r, c] = size(A);
    xMask = [-1 0 1; -2 0 2; -1 0 1];
    yMask = [1 2 1; 0 0 0; -1 -2 -1];
    % convolu��o da imagem pelas m�scaras, que gera
    % os gradientes vertical e horizontal
    Gx = conv2(A, xMask, 'same');
    Gy = conv2(A, yMask, 'same');
    % gera��o do gradiente de magnitude
    G = sqrt((Gx.^2) + (Gy.^2));
    % gera��o do �ngulo (dire��o) dos gradientes
    theta = atan2(Gy, Gx);
end

function B = GetDirections(A)
    [r, c] = size(A);
    B = zeros(r, c);
    % adiciona 360� para cada valor negativo da imagem,
    % tornando-a totalmente positiva, o que ser� �til no
    % c�lculo das dire��es
    for i = 1 : r
        for j = 1 : c
            if (A(i, j) < 0) 
                A(i, j) = A(i, j) + 360;
            end
        end
    end
    % arredonda as dire��es para uma das 4 dire��es padronizadas (0�, 45�,
    % 90�, 135�), o que facilita o c�lculo na pr�xima etapa
    for i = 1  : r
        for j = 1 : c
            % de -22.5� (que ao ser convertido para o positivo tornou-se
            % 337.5�, por exemplo) a 22� e de 157.5� a 202.5� etc.
            if ((A(i, j) >= 0 ) && (A(i, j) < 22.5) || (A(i, j) >= 157.5) && (A(i, j) < 202.5) || (A(i, j) >= 337.5) && (A(i, j) <= 360))
                B(i, j) = 0;
            elseif ((A(i, j) >= 22.5) && (A(i, j) < 67.5) || (A(i, j) >= 202.5) && (A(i, j) < 247.5))
                B(i, j) = 45;
            elseif ((A(i, j) >= 67.5 && A(i, j) < 112.5) || (A(i, j) >= 247.5 && A(i, j) < 292.5))
                B(i, j) = 90;
            elseif ((A(i, j) >= 112.5 && A(i, j) < 157.5) || (A(i, j) >= 292.5 && A(i, j) < 337.5))
                B(i, j) = 135;
            end
        end
    end
end

function B = NonMaximumSupression(G, directions)
    % defini��o de par�metros
    [r, c] = size(directions);
    B = zeros(r, c);
    % dilui as bordas da imagem, definindo a intensidade de cada pixel de acordo
    % com o pixel mais forte que est� mesma dire��o do seu gradiente de magnitude
    for i = 2 : r - 1 % n�o verifica as bordas para n�o sair dos �ndices m�nimos e m�ximos
        for j = 2 : c - 1
            % vertical (0�), portanto verifica os vizinhos das colunas mais
            % pr�ximas
            if (directions(i, j) == 0)
                B(i, j) = (G(i, j) == max([G(i, j), G(i, j + 1), G(i, j - 1)]));
            % diagonal (45�), portanto verifica os vizinhos da linha abaixo e
            % coluna anterior ou da linha acima e coluna posterior
            elseif (directions(i, j) == 45)
                B(i, j) = (G(i, j) == max([G(i, j), G(i + 1, j - 1), G(i - 1, j + 1)]));
            % horizontal (90�), portanto verifica os vizinhos das linhas
            % mais pr�ximas
            elseif (directions(i, j) == 90)
                B(i, j) = (G(i, j) == max([G(i, j), G(i + 1, j), G(i - 1, j)]));
            % diagonal (135�), portanto verifica os vizinhos da linha
            % abaixo e coluna posterior ou da linha acima e coluna anterior
            elseif (directions(i, j) == 135)
                B(i, j) = (G(i, j) == max([G(i, j), G(i + 1, j + 1), G(i - 1, j - 1)]));
            end
        end
    end
    B = B.*G;
end

function B = Hysteresis(A)
    % defini��o de par�metros
    [r, c] = size(A);
    B = zeros(r, c);
    ThreshL = 0.075 * max(max(A));
    ThreshH = 0.175 * max(max(A));
    % classifica pixels em bordas (0) ou n�o bordas (1) e julga os demais de acordo
    % com seus vizinhos
    for i = 1  : r
        for j = 1 : c
            % se � definitivamente n�o borda � transformado em um pixel branco
            if (A(i, j) < ThreshL)
                B(i, j) = 1;
            % se � definitivamente borda � transformado em um pixel preto
            elseif (A(i, j) > ThreshH)
                B(i, j) = 0;
            else
                % caso nenhum dos casos acima mas possua um vizinho
                % definitivamente borda, tamb�m � considerado borda e
                % transformado em um pixel preto
                if (A(i + 1, j) > ThreshH || A(i - 1, j) > ThreshH || A(i, j + 1) > ThreshH || A(i, j - 1) > ThreshH || A(i - 1, j - 1) > ThreshH || A(i - 1, j + 1) > ThreshH || A(i + 1, j + 1) > ThreshH || A(i + 1, j - 1) > ThreshH)
                    B(i, j) = 0;
                % caso n�o tenha pelo menos um vizinho definitivamente
                % borda, � considerado n�o borda e transformado em um pixel
                % branco
                else
                    B(i, j) = 1;
                end
            end
        end
    end
    % todos os pixels considerados n�o bordas recebem o bit 255 (branco),
    % emquanto as bordas permanecem bit 0 (preto)
    B = uint8(B.*255);
end

function CannyEdgeDetector(img)
    subplot(3,3,1);
    imshow(img);
    title('Imagem original');
    
    % 1. Convers�o da imagem para tons de cinza
    % converte a imagem para tons de cinza
    % cada pixel possui 8 bits com valores de 0 a 255
    I = rgb2gray(img);
    subplot(3,3,2);
    imshow(I);
    title('Imagem em tons de cinza');
    
    % 2. Borr�o Gaussiano
    % reduz ru�do atrav�s de um filtro gaussiano antes do restante
    % do processamento da imagem
    % sigma padr�o definido com valor 1.4
    B1 = FiveByFiveGaussianFilter(I);
    subplot(3,3,3);
    imshow(uint8(B1));
    title('Imagem ap�s filtro Gaussiano');
    
    % 3. Gradientes de intensidade
    % utiliza o filtro Sobel para adquirir os gradientes vertical (Gx),
    % horizontal (Gy) e de magnitude (G), bem como a dire��o do gradiente
    % (theta)
    [G, Gx, Gy, theta] = Sobel(B1);
    % converte o theta para graus, a fim de facilitar os c�lculos
    % posteriores
    theta = theta * 180 / pi;
    subplot(3,3,4)
    imshow(uint8(G));
    title('G'); 
    subplot(3,3,5)
    imshow(uint8(Gx));
    title('Gx');
    subplot(3,3,6);
    imshow(uint8(Gy));
    title('Gy');  
    % Dire��es
    directions = GetDirections(theta);
    % plotagem
    subplot(3,3,7);
    imagesc(uint8(directions));
    title('Dire��es');
    
    % 4. Supress�o de n�o m�ximos
    % afina as bordas da imagem de acordo com o gradiente de magnitude e
    % dire��o
    B2 = NonMaximumSupression(G, directions);
    % plotagem
    subplot(3,3,8);
    imshow(uint8(B2));
    title('Supress�o de n�o m�ximos');
    
    % 5. Limiar de histerese
    % define quais pixels s�o definitivamente bordas, quais s�o
    % definitivamente n�o-bordas e, para os indecisos, define como borda se
    % tiver um vizinho que � definitivamente borda
    B3 = Hysteresis(B2);
    subplot(3,3,9);
    imshow(B3);
    title('Imagem ap�s o detector de bordas Canny');
    figure, imshow(B3);
    title('Resultado ap�s o detector de bordas Canny');
end