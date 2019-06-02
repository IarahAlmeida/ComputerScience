% Iarah Gonçalves de Almeida
% David Walter Jansen

% definição dos parâmetros
% pasta padrão
defaultFolder = 'C:\Users\Iarah\Desktop\cameraNoise\';
% pasta que contém as imagens com luz artificial
artificialLightFolder = dir([defaultFolder 'withArtificialLight\*.jpg']);
% pasta que contém as imagens sem luz artificial
noArtificialLightFolder = dir([defaultFolder 'noArtificialLight\*.jpg']);

[stdAL, sigmaAL, meanAL] = EstimateNoise(artificialLightFolder);
[stdNoAL, sigmaNoAL, meanNoAL] = EstimateNoise(noArtificialLightFolder);

[r, c] = size(meanAL);
middleLineMeanALPlus = zeros(1, c);
middleLineMeanALMinus = zeros(1, c);
middleLineMeanNoALPlus = zeros(1, c);
middleLineMeanNoALMinus = zeros(1, c);
for k = 1 : c
    middleLineMeanALPlus(1, k) = meanAL(r / 2, k) + sigmaAL(r / 2, k);
    middleLineMeanALMinus(1, k) = meanAL(r / 2, k) - sigmaAL(r / 2, k);
    middleLineMeanNoALPlus(1, k) = meanNoAL(r / 2, k) + sigmaNoAL(r / 2, k);
    middleLineMeanNoALMinus(1, k) = meanNoAL(r / 2, k) - sigmaNoAL(r / 2, k);
end

PlusMinusAL = middleLineMeanALPlus - middleLineMeanALMinus;
worstCasePlusMinusAL = max(PlusMinusAL);
meanPlusMinusAL = mean(PlusMinusAL);
disp(worstCasePlusMinusAL);
disp(meanPlusMinusAL);

PlusMinusNoAL = middleLineMeanNoALPlus - middleLineMeanNoALMinus;
worstCasePlusMinusNoAL = max(PlusMinusNoAL);
meanPlusMinusNoAL = mean(PlusMinusNoAL);
disp(worstCasePlusMinusNoAL);
disp(meanPlusMinusNoAL);

signal = mean(meanAL(:));
noise = mean(sigmaAL(:));
snrAL = signal / noise;
snrDbAL = 10 * log10 (signal / noise);
fprintf('Média do sinal com luz artificial (signal): %f\n', signal);
fprintf('Desvio padrão médio do sinal com luz artificial (noise): %f\n', noise);
fprintf('Relação sinal-ruído com luz artificial (SNR): %f\n', snrAL);
fprintf('Relação sinal-ruído em decibéis com luz artificial (SNR_dB): %f\n', snrDbAL);

signal = mean(meanNoAL(:));
noise = mean(sigmaNoAL(:));
snrNoAL = signal / noise;
snrDbNoAL = 10 * log10 (signal / noise);
fprintf('Média do sinal sem luz artificial (signal): %f\n', signal);
fprintf('Desvio padrão médio do sinal sem luz artificial (noise): %f\n', noise);
fprintf('Relação sinal-ruído sem luz artificial (SNR): %f\n', snrNoAL);
fprintf('Relação sinal-ruído em decibéis sem luz artificial (SNR_dB): %f\n', snrDbNoAL);

% plotagem
figure(1);
subplot(2, 1, 1);
p = plot(1 : c, middleLineMeanALPlus, 1 : c, middleLineMeanALMinus);
p(1).LineWidth = 0.3;
p(2).LineWidth = 0.3;
legend('somado', 'subtraído');
legend('boxoff');
title('Estimação do ruído de aquisição médio nas imagens com luz artificial (desvio padrão)')
xlabel('Linha do meio da média das imagens')
ylabel('Valores de brilho')
subplot(2, 1, 2);
p = plot(1 : c, middleLineMeanNoALPlus, '-', 1 : c, middleLineMeanNoALMinus, '-');
p(1).LineWidth = 0.3;
p(2).LineWidth = 0.3;
legend('somado', 'subtraído');
legend('boxoff');
title('Estimação do ruído de aquisição médio nas imagens sem luz artificial (desvio padrão)')
xlabel('Linha do meio da média das imagens') 
ylabel('Valores de brilho')
print(figure(1), 'C:\Users\Iarah\Desktop\cameraNoise\graph1', '-bestfit', '-dpdf', '-r0');

% histograma
% geração de imagens para análise com luz artificial
ImgPlusAL = uint8(round(meanAL + sigmaAL));
ImgMinusAL = uint8(round(meanAL - sigmaAL));
% plotagem dos histogramas
figure(2);
subplot(2, 1, 1);
imhist(ImgPlusAL);
legend('Somado');
legend('boxoff');
title('Histograma da imagem média com luz artificial')
ylabel('Quantidade de pixels')
subplot(2, 1, 2);
imhist(ImgMinusAL);
legend('Subtraído');
legend('boxoff');
title('Histograma da imagem média com luz artificial')
ylabel('Quantidade de pixels')
% geração de imagens para análise sem luz artificial 
ImgPlusNoAL = uint8(round(meanNoAL + sigmaNoAL));
ImgMinusNoAL = uint8(round(meanNoAL - sigmaNoAL));
% plotagem dos histogramas
figure(3);
subplot(2, 1, 1);
imhist(ImgPlusNoAL);
legend('Somado');
legend('boxoff');
title('Histograma da imagem média sem luz artificial')
ylabel('Quantidade de pixels')
subplot(2, 1, 2);
imhist(ImgMinusNoAL);
legend('Subtraído');
legend('boxoff');
title('Histograma da imagem média sem luz artificial')
ylabel('Quantidade de pixels')

% plotagens 3D
[x, y] = size(ImgPlusAL);
X = 1 : x;
Y = 1 : y;
[xx, yy] = meshgrid(Y, X);

figure(4);
subplot(2, 1, 1);
mesh(xx, yy, ImgPlusAL);
title('Intensidade dos sinais com luz artificial (somado)')
xlabel('Colunas da imagem')
ylabel('Linhas da imagem')
subplot(2, 1, 2);
mesh(xx, yy, ImgMinusAL);
title('Intensidade dos sinais com luz artificial (subtraído)')
xlabel('Colunas da imagem')
ylabel('Linhas da imagem')

figure(5);
subplot(2, 1, 1);
mesh(xx, yy, ImgPlusNoAL);
title('Intensidade dos sinais sem luz artificial (somado)')
xlabel('Colunas da imagem')
ylabel('Linhas da imagem')
subplot(2, 1, 2);
mesh(xx, yy, ImgMinusNoAL);
title('Intensidade dos sinais sem luz artificial (subtraído)')
xlabel('Colunas da imagem')
ylabel('Linhas da imagem')

% cálculo para o ruído de ambiente
[sigmaEnv, meanEnv] =  IntensityNoise(meanAL, meanNoAL);
signalEnv = mean(meanEnv(:));
noiseEnv = mean(sigmaEnv(:));
snrEnv = signalEnv / noiseEnv;
snrDbEnv = 10 * log10 (signalEnv / noiseEnv);
fprintf('Média do sinal na alteração de ambiente (signal): %f\n', signalEnv);
fprintf('Desvio padrão médio do sinal na alteração de ambiente (noise): %f\n', noiseEnv);
fprintf('Relação sinal-ruído na alteração de ambiente (SNR): %f\n', snrEnv);
fprintf('Relação sinal-ruído em decibéis na alteração de ambiente (SNR_dB): %f\n', snrDbEnv);

figure(6)
mesh(xx, yy, sigmaEnv);
title('Intensidade do ruído na mudança de ambiente')
xlabel('Colunas da imagem')
ylabel('Linhas da imagem')
return;

% lê todas as imagens em uma pasta e calcula o desvio padrão dessas
% imagens, retornando o desvio padrão médio (standardDeviation), a matriz
% de desvios padrões por pixel (sigma) e a matriz de médias por pixel (E)
function [standardDeviation, sigma, E] = EstimateNoise(folder)
    [n, m] = size(folder); % 31 linhas (n), 1 coluna (m)
    for k = 1 : n
        F = fullfile(folder(k).folder, folder(k).name);
        BW = rgb2gray(imread(F));
        I = imresize(BW, 0.1);
        % salva a imagem em formato double para permitir valores acima de 255
        folder(k).data = double(I);
        if (k == 1)
            [r, c] = size(folder(k).data); % 3000 linhas 4000 colunas fica com 300 linhas 400 colunas
            sigma = zeros(r, c);
            E = zeros(r, c);
        end
        % calcula o somatório de cada pixel
        for i = 1 : r
            for j = 1 : c
                E(i, j) = E(i, j) + folder(k).data(i, j);
            end
        end
    end
    % calcula a média de cada pixel (average image brightness)
    E = E ./ n;
    % calcula a matriz de desvio padrão
    for i = 1 : r
        for j = 1 : c
            for k = 1 : n
                sigma(i, j) = sigma(i, j) + (E(i, j) - folder(k).data(i, j))^2;
            end
            sigma(i, j) = sqrt(sigma(i, j) / (n - 1));
        end
    end
    % calcula o desvio padrão médio
    signalMeanSum = 0;
    for i = 1 : r
        for j = 1 : c
            signalMeanSum = signalMeanSum + E(i, j);
        end
    end
    signalMeanMean = signalMeanSum / (r * c);
    aux = 0;
    for i = 1 : r
        for j = 1 : c
            aux = aux + (E(i, j) - signalMeanMean)^2;
        end
    end
    standardDeviation = sqrt(aux / ((r * c) - 1));
end

function [sigma, E] = IntensityNoise(E1, E2)
    [r, c] = size(E1);
    sigma = zeros(r, c);
    E = zeros(r, c);  
    % soma acumulada da intensidade de cada pixel par as duas imagens
    for i = 1 : r
        for j = 1 : c
            E(i, j) = E1(i, j) + E2(i, j);
        end
    end
    E = E ./ 2;
    % cálculo do desvio padrão
    for i = 1 : r
        for j = 1 : c
            sigma(i, j) = (E(i, j) - E1(i, j))^2 + (E(i, j) - E2(i, j))^2;
            sigma(i, j) = sqrt(sigma(i, j) / (2 - 1));
        end
    end
end