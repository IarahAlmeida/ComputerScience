# -*- coding: utf-8 -*-
"""
Created on Sun May  5 12:57:23 2019

@author: Iarah
"""

import numpy as np
import pandas as pd
import random as rd
from sklearn.datasets import load_boston
from sklearn.datasets import load_iris

"""
Definição de parâmetros
"""
k = 3 # número de vizinhos que influenciarão a decisão
clusterize = False # flag para definir se o KNN será utilizado para classificação (base iris) ou regressão (base boston)
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
calcula a distância euclidiana entre o ponto p e o ponto q
"""
def EuclideanDistance(p, q):
    n = len(p)
    distance = 0
    for i in range(n):
        distance += np.square(p[i] - q[i])
    return np.sqrt(distance)

"""
Designação inicial dos centros
de forma aleatória, seleciona k instâncias para serem os clusters centrais
iniciais
"""
def GetInitialCentroids(dataSet, k):
    centers = []
    uniqueDataSet = [list(x) for x in set(tuple(x) for x in dataSet)]
    uniqueSet = True
    if len(dataSet) > len(uniqueDataSet):
        uniqueSet = False
    for i in range(k):
        tempCenter = rd.choice(dataSet)
        if (tempCenter not in centers):
            centers.append(tempCenter)
        elif (uniqueSet == True):
            i -= 1
    return centers

"""
Atualização de clusters
encontra o cluster mais próximo de dada instância e designa esta instância para
este cluster
"""
def ClusterAssignment(dataSet, centers, clusters):
    for i in range(len(dataSet)):
        minDistance = float("inf")
        for j in range(len(centers)):
            distance = EuclideanDistance(dataSet[i], centers[j])
            if (distance < minDistance):
                minDistance = distance
                clusters[i] = j

"""
Atualização de centros
atualiza o ponto central do cluster para a média das instâncias daquele cluster
se um cluster estiver vazio, um novo centro é escolhido aleatoriamente
"""
def UpdateCentroid(dataSet, centers, clusters):
    dim = len(dataSet[0])
    control = False
    for i in range(len(centers)):
        newCenter = np.zeros(dim)
        members = 0
        for j in range(len(dataSet)):
            if (clusters[j] == i):
                for k in range(dim):
                    newCenter[k] += dataSet[j][k]
                members += 1
        for j in range(dim):
            if members != 0:
                newCenter[j] = newCenter[j] / float(members) 
            else: 
                newCenter = rd.choice(dataSet)
                control = True
        centers[i] = newCenter
    return centers, control

"""
KNN
utliza a base de dados iris para classificação e a de boston para regressão
para precisão, indica uma porcentagem para a classificação e um erro para a regressão
"""
def KMeans(dataSet, k):
    global classify
    if (len(dataSet) < k):
        print('K is set to a value bigger than total instances!')
        return;
    centers = GetInitialCentroids(dataSet, k)
    clusters = np.zeros(len(dataSet))
    previousClusters = - np.ones(len(dataSet)) # para checar convergência
    iteration = 0
    maxIterations = 1000
    control = True
    convergence = False
    while (control):
        previousClusters = list(clusters)
        # atualiza os clusters
        ClusterAssignment(dataSet, centers, clusters)
        # checa se convergiu
        centers, control = UpdateCentroid(dataSet, centers, clusters)
        # aumenta a quantidade de iterações efetuadas
        convergence = True
        for i in range(len(clusters)):
            if (clusters[i] != previousClusters[i]):
                convergence = False
                break
        iteration += 1
        if (iteration > maxIterations):
            print('Iteration limit reached!')
            break
        elif (convergence and not(control)):
            print('Converged!')
            break
        else:
            control = True
    return clusters, centers

"""
Tratamento dos dados
faz com que cada instância fique no formato [valor1, valor2, ..., valorN, target]
"""
if (clusterize == True):
    iris = load_iris() # carrega o conjunto de dados
    df = pd.DataFrame(iris.data) # transforma para dataframe
    df = df.astype('float64') # converte os valores para float
    df.columns = iris.feature_names # define o nome das colunas
else:
    boston = load_boston() # carrega o conjunto de dados
    df = pd.DataFrame(boston.data)  # transforma para dataframe
    df = df.astype('float64') # converte os valores para float
    df.columns = boston.feature_names # define o nome das colunas
dataSet = df.values.tolist()

"""
Execução
"""
clusters, centers = KMeans(dataSet, k)
print(clusters)
#print(centers)

"""
Referências
http://konukoii.com/blog/2017/01/15/5-min-tutorial-k-means-clustering-in-python/
"""