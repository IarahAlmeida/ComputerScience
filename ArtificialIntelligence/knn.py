# -*- coding: utf-8 -*-
"""
Created on Fri May  2 15:57:55 2019

@author: Iarah
"""

import numpy as np
import pandas as pd
import random as rd
import operator as op
from sklearn.datasets import load_boston
from sklearn.datasets import load_iris

"""
Definição de parâmetros
"""
k = 3 # número de vizinhos que influenciarão a decisão
classify = False # flag para definir se o KNN será utilizado para classificação (base iris) ou regressão (base boston)
splitChance = 0.66 # porcentagem de dados que farão parte do conjunto de treinamento

"""
Divisão dos dados
divide os dados em dois conjuntos, de forma que uma dada porcentagem de amostras
fiquem no conjunto de treinamento e o restante no conjunto de teste
"""
def SplitDataset(df, splitChance):
    trainingSet = []
    testSet = []
    df_list = df.values.tolist()
    for i in range(len(df)):
        if (rd.random() < splitChance):
            trainingSet.append(df_list[i])
        else:
            testSet.append(df_list[i])
    return trainingSet, testSet

"""
Distância Euclidiana
calcula a distância euclidiana entre o ponto p e o ponto q, desconsiderando a
coluna 'class' ou 'price'
"""
def EuclideanDistance(p, q):
    n = len(p) - 1 # desconsidera a última coluna ('class' ou 'price')
    distance = 0
    for i in range(n):
        distance += np.square(p[i] - q[i])
    return np.sqrt(distance)

"""
Vizinhos mais próximos
calcula a distância euclidiana da instância de teste para as amostras do
conjunto de treinamento e, com base nessa distância, ordena as amostras e
seleciona os k vizinhos mais próximos
"""
def GetNeighbors(trainingSet, testInstance, k):
    distances = []
    for i in range(len(trainingSet)):
        distance = EuclideanDistance(trainingSet[i], testInstance)
        distances.append((distance, trainingSet[i]))
    neighbors = [i[1] for i in sorted(distances)[:k]]
    return neighbors

"""
Classificação
dentre os vizinhos mais próximos, retorna a classe de maior ocorrência
"""
def Classification(neighbors):
	votes = {}
	for i in range(len(neighbors)):
		response = neighbors[i][-1]
		if response in votes:
			votes[response] += 1
		else:
			votes[response] = 1
	sortedVotes = sorted(votes.items(), key = op.itemgetter(1), reverse = True)
	return sortedVotes[0][0]

"""
Regressão
dentre os vizinhos mais próximos, retorna a média do preço
"""
def Regression(neighbors):
    tempSum = 0
    for row in neighbors:
        tempSum += row[-1]
    return tempSum / len(neighbors)

"""
Precisão de classificação
retorna a porcentagem das classes preditas corretamente
"""
def GetClassificationAccuracy(testSet, predictions):
	correct = 0
	for i in range(len(testSet)):
		if testSet[i][-1] == predictions[i]:
			correct += 1
	return correct / float(len(testSet))

"""
Precisão de regressão
retorna o erro (raiz do erro quadrático médio ou root mean squared error - RMSE)
entre os preços reais e os preditos
"""
def GetRegressionAccuracy(testSet, predictions):
    error = 0
    for row in range(len(testSet)):
        error += np.square((testSet[row][-1] - predictions[row]))
    error /= len(testSet)
    return np.sqrt(error)

"""
KNN
utliza a base de dados iris para classificação e a de boston para regressão
para precisão, indica uma porcentagem para a classificação e um erro para a regressão
"""
def KNN(trainingSet, testSet, k):
    global classify
    if (len(trainingSet) < k):
        print('K is set to a value bigger than total instances!')
        return;
    predictions = []
    for i in range(len(testSet)):
        neighbors = GetNeighbors(trainingSet, testSet[i], k)
        if (classify == True):
            result = Classification(neighbors)
        else:
            result = Regression(neighbors)
        predictions.append(result)
        #print('Predito:', result, 'Real:', testSet[i][-1])
    if (classify == True):
        accuracy = GetClassificationAccuracy(testSet, predictions)
        print('Accuracy (bigger is better):', accuracy)
    else:
        accuracy = GetRegressionAccuracy(testSet, predictions)
        print('Accuracy (lower is better):', accuracy)

"""
Tratamento dos dados
faz com que cada instância fique no formato [valor1, valor2, ..., valorN, target]
"""
if (classify == True):
    iris = load_iris() # carrega o conjunto de dados
    df = pd.DataFrame(iris.data) # transforma para dataframe
    df = df.astype('float64') # converte os valores para float
    df.columns = iris.feature_names # define o nome das colunas
    df['class'] = iris.target # insere a coluna de classificação sob o nome 'class'
else:
    boston = load_boston() # carrega o conjunto de dados
    df = pd.DataFrame(boston.data)  # transforma para dataframe
    df = df.astype('float64') # converte os valores para float
    df.columns = boston.feature_names # define o nome das colunas
    df['price'] = boston.target # insere a coluna de regressão sob o nome 'price'
trainingSet = []
testSet = []
trainingSet, testSet = SplitDataset(df, splitChance)

"""
Execução
"""
KNN(trainingSet, testSet, k)

"""
Referências
https://machinelearningmastery.com/tutorial-to-implement-k-nearest-neighbors-in-python-from-scratch/
"""