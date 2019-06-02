% Índice
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

% Máscara ponderada de tamanho 3
mask3 = [1, 3, 1];
% Máscara ponderada de tamanho 5
mask5 = [1, 3, 5, 3, 1];
% Máscara ponderada de tamanho 7
mask7 = [1, 3, 5, 7, 5, 3, 1];

% Entrada A
ya = [5, 5, 5, 6, 4, 5, 5, 18, 22, 20, 20, 21, 19, 4, 4, 3, 4, 4, 5, 7];
% Entrada B
yb = [2, 4, 6, 8, 10, 12, 14, 16, 18, 18, 18, 16, 14, 12, 10, 8, 6, 4, 2, 2];
% Entrada C
yc = [10, 10, 10, 10, 20, 20, 20, 20, 10, 10, 10, 10, 20, 20, 20, 20, 10, 10, 10, 10];

% Filtro da média
disp("Filtro da média");
    % Com tamanho 3
ya3mean = MeanFilter(ya, 3);
yb3mean = MeanFilter(yb, 3);
yc3mean = MeanFilter(yc, 3);
    % Resultado
disp("Entrada A, tamanho 3")
disp(ya3mean);
disp("Entrada B, tamanho 3")
disp(yb3mean);
disp("Entrada C, tamanho 3")
disp(yc3mean);
    % Com tamanho 5
ya5mean = MeanFilter(ya, 5);
yb5mean = MeanFilter(yb, 5);
yc5mean = MeanFilter(yc, 5);
    % Resultado
disp("Entrada A, tamanho 5")
disp(ya5mean);
disp("Entrada B, tamanho 5")
disp(yb5mean);
disp("Entrada C, tamanho 5")
disp(yc5mean);
    % Com tamanho 7
ya7mean = MeanFilter(ya, 7);
yb7mean = MeanFilter(yb, 7);
yc7mean = MeanFilter(yc, 7);
    % Resultado
disp("Entrada A, tamanho 7")
disp(ya7mean);
disp("Entrada B, tamanho 7")
disp(yb7mean);
disp("Entrada C, tamanho 7")
disp(yc7mean);

% Filtro da mediana
disp("Filtro da mediana");
    % Com tamanho 3
ya3median = MedianFilter(ya, 3);
yb3median = MedianFilter(yb, 3);
yc3median = MedianFilter(yc, 3);
    % Resultado
disp("Entrada A, tamanho 3")
disp(ya3median);
disp("Entrada B, tamanho 3")
disp(yb3median);
disp("Entrada C, tamanho 3")
disp(yc3median);
    % Com tamanho 5
ya5median = MedianFilter(ya, 5);
yb5median = MedianFilter(yb, 5);
yc5median = MedianFilter(yc, 5);
    % Resultado
disp("Entrada A, tamanho 5")
disp(ya5median);
disp("Entrada B, tamanho 5")
disp(yb5median);
disp("Entrada C, tamanho 5")
disp(yc5median);
    % Com tamanho 7
ya7median = MedianFilter(ya, 7);
yb7median = MedianFilter(yb, 7);
yc7median = MedianFilter(yc, 7);
    % Resultado
disp("Entrada A, tamanho 7")
disp(ya7median);
disp("Entrada B, tamanho 7")
disp(yb7median);
disp("Entrada C, tamanho 7")
disp(yc7median);

% Filtro da média ponderada
disp("Filtro da média ponderada");
    % Com tamanho 3
ya3weightedmean = WeightedMeanFilter(ya, mask3);
yb3weightedmean = WeightedMeanFilter(yb, mask3);
yc3weightedmean = WeightedMeanFilter(yc, mask3);
    % Resultado
disp("Entrada A, tamanho 3")
disp(ya3weightedmean);
disp("Entrada B, tamanho 3")
disp(yb3weightedmean);
disp("Entrada C, tamanho 3")
disp(yc3weightedmean);
    % Com tamanho 5
ya5weightedmean = WeightedMeanFilter(ya, mask5);
yb5weightedmean = WeightedMeanFilter(yb, mask5);
yc5weightedmean = WeightedMeanFilter(yc, mask5);
    % Resultado
disp("Entrada A, tamanho 5")
disp(ya5weightedmean);
disp("Entrada B, tamanho 5")
disp(yb5weightedmean);
disp("Entrada C, tamanho 5")
disp(yc5weightedmean);
    % Com tamanho 7
ya7weightedmean = WeightedMeanFilter(ya, mask7);
yb7weightedmean = WeightedMeanFilter(yb, mask7);
yc7weightedmean = WeightedMeanFilter(yc, mask7);
    % Resultado
disp("Entrada A, tamanho 7")
disp(ya7weightedmean);
disp("Entrada B, tamanho 7")
disp(yb7weightedmean);
disp("Entrada C, tamanho 7")
disp(yc7weightedmean);

% Plotagem
% Filtro da média
    % Entrada A
figure(1);
subplot(3, 1, 1);
p = plot(x, ya, '.-', x, ya3mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, ya, '.-', x, ya5mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, ya, '.-', x, ya7mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada B
figure(2);
subplot(3, 1, 1);
p = plot(x, yb, '.-', x, yb3mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yb, '.-', x, yb5mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yb, '.-', x, yb7mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada C
figure(3);
subplot(3, 1, 1);
p = plot(x, yc, '.-', x, yc3mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yc, '.-', x, yc5mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yc, '.-', x, yc7mean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
% Filtro da mediana
    % Entrada A
figure(4);
subplot(3, 1, 1);
p = plot(x, ya, '.-', x, ya3median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da mediana de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, ya, '.-', x, ya5median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da mediana de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, ya, '.-', x, ya7median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da mediana de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada B
figure(5);
subplot(3, 1, 1);
p = plot(x, yb, '.-', x, yb3median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da mediana de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yb, '.-', x, yb5median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da mediana de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yb, '.-', x, yb7median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da mediana de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada C
figure(6);
subplot(3, 1, 1);
p = plot(x, yc, '.-', x, yc3median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da mediana de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yc, '.-', x, yc5median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da mediana de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yc, '.-', x, yc7median, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da mediana de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
% Filtro da média ponderada
    % Entrada A
figure(7);
subplot(3, 1, 1);
p = plot(x, ya, '.-', x, ya3weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média ponderada de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, ya, '.-', x, ya5weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média ponderada de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, ya, '.-', x, ya7weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada A com filtro da média ponderada de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada B
figure(8);
subplot(3, 1, 1);
p = plot(x, yb, '.-', x, yb3weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média ponderada de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yb, '.-', x, yb5weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média ponderada de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yb, '.-', x, yb7weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada B com filtro da média ponderada de tamanho 7')
xlabel('Índices') 
ylabel('Valores')
    % Entrada C
figure(9);
subplot(3, 1, 1);
p = plot(x, yc, '.-', x, yc3weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média ponderada de tamanho 3')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 2);
p = plot(x, yc, '.-', x, yc5weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média ponderada de tamanho 5')
xlabel('Índices') 
ylabel('Valores')
subplot(3, 1, 3);
p = plot(x, yc, '.-', x, yc7weightedmean, '.-');
p(1).LineWidth = 1.3;
p(2).LineWidth = 0.3;
legend('Original', 'Filtrado');
legend('boxoff');
title('Entrada C com filtro da média ponderada de tamanho 7')
xlabel('Índices') 
ylabel('Valores')

% Função para aplicar o filtro da média
function y = MeanFilter(v, sz)
[r, c] = size(v);
assert(r == 1, 'Vetor deve ter uma única linha.');
assert(mod(sz, 2) ~= 0, 'Máscara deve ter tamanho ímpar.');
assert(length(v) >= sz, 'Vetor deve ter tamanho maior ou igual à máscara.');
% ignorando bordas
edge = floor(sz / 2);
y = v;
vLength = length(v);
for i = 1 : edge
    y(i) = v(i);
    y(vLength) = v(vLength);
    vLength = vLength - 1;
end
% filtrando valores
for i = edge + 1 : length(v) - edge
    k = 1;
    parcialArray = zeros(1, sz);
    for j = i - edge : i + edge
        parcialArray(k) = v(j);
        k = k + 1;
    end
    y(i) = round(mean(parcialArray));
end
end

% Função para aplicar o filtro da mediana
function y = MedianFilter(v, sz)
[r, c] = size(v);
assert(r == 1, 'Vetor deve ter uma única linha.');
assert(mod(sz, 2) ~= 0, 'Máscara deve ter tamanho ímpar.');
assert(length(v) >= sz, 'Vetor deve ter tamanho maior ou igual à máscara.');
% ignorando bordas
edge = floor(sz / 2);
y = v;
vLength = length(v);
for i = 1 : edge
    y(i) = v(i);
    y(vLength) = v(vLength);
    vLength = vLength - 1;
end
% filtrando valores
for i = edge + 1 : length(v) - edge
    k = 1;
    parcialArray = zeros(1, sz);
    for j = i - edge : i + edge
        parcialArray(k) = v(j);
        k = k + 1;
    end
    y(i) = median(parcialArray);
end
end

% Função para aplicar o filtro da média ponderada
function y = WeightedMeanFilter(v, mask)
[r, c] = size(v);
assert(r == 1, 'Vetor deve ter uma única linha.');
[r, c] = size(mask);
assert(r == 1, 'Máscara deve ter uma única linha.');
assert(length(v) >= length(mask), 'Vetor deve ter tamanho maior ou igual à máscara.');
assert(mod(length(mask), 2) ~= 0, 'Máscara deve ter tamanho ímpar.');
% ignorando bordas
edge = floor(length(mask) / 2);
y = zeros(1, length(v));
vLength = length(v);
for i = 1 : edge
    y(i) = v(i);
    y(vLength) = v(vLength);
    vLength = vLength - 1;
end
% filtrando valores
for i = edge + 1 : length(v) - edge
    k = 1;
    parcialArray = zeros(1, length(mask));
    divisor = 0;
    for j = i - edge : i + edge
        parcialArray(k) = v(j) * mask(k);
        divisor = divisor + mask(k);
        k = k + 1;
    end
    y(i) = round(sum(parcialArray) / divisor);
end
end