# -*- coding: utf-8 -*-
"""
Created on Fri Apr 12 20:03:45 2019

@author: Iarah
"""

import numpy as np
import random as rd
import math

"""
Definição de parâmetros
"""
tests = 30 # número de vezes para executar o algoritmo genético
iterations = 100 # número máximo de gerações
individuals = 20 # número máximo de indivíduos na população
genes = 2 # quantidade de genes por cromossomo (dimensão do indivíduo)
minGeneValue = -5.12 # valor mínimo do gene
maxGeneValue = 5.12 # valor máximo do gene
mutationChance = 0.1 # chance de um indivíduo sofrer mutação
crossing = False # flag para habilitar a fase de cruzamento
crossoverChance = 0.9 # chance dos pais selecionados terem filhos
polarizedCrossover = False # estratégia utilizada no cruzamento
alpha = 0.9 # porcentagem do gene utilizado no cruzamento
updateChance = 0.9 # chance de um indivíduo gerado no cruzamento ser escolhido para pertencer à população

# funções usadas na avaliação
def rastrigin(X, **kwargs):
    A = kwargs.get('A')
    [row, col] = X.shape
    fx = np.zeros(row)
    for i in range(row):
        for j in range(col):
            fx[i] += X[i, j]**2 - A * np.cos(2 * math.pi * X[i, j])
    return A * col + fx

def invert(fx):
    h = 10**-0.2 - min(fx); # deslocamento
    return 1 / (fx + h);

"""
Inicialização
Cria a população inicial cujos cromossomos são gerados aleatoriamente,
conforme parâmetros previamente definidos.
"""
def initialGeneration():
    global individuals
    global genes
    global minGeneValue
    global maxGeneValue
    return np.random.uniform(minGeneValue, maxGeneValue, (individuals, genes))

"""
Avaliação
Define o grau de adaptação de cada indivíduo (fitness) a partir da função
de Rastrigin.
"""
def avaliation(population):
    return rastrigin(population, A = 10)

"""
Seleção
Seleciona indivíduos para permanecerem na população ou reproduzirem através do
método de torneio 2 a 2.
Dois indivíduos são escolhidos aleatoriamente para participarem do torneio,
onde o de maior aptidão (fitness) é escolhido para permanecer na população ou
reproduzir.
A seleção é feita tantas vezes quanto necessário para manter o mesmo número
de indivíduos.
"""
def selection(population, fitness):
    global individuals
    global genes
    tournament = np.zeros(len(fitness))
    for i in range(len(fitness)):
        idx1 = rd.randint(0, len(fitness) - 1)
        idx2 = rd.randint(0, len(fitness) - 1)
        if fitness[idx1] > fitness[idx2]:
            tournament[i] = idx1
        else:
            tournament[i] = idx2
    selectedPopulation = np.zeros((individuals, genes))
    for i in range(individuals):
        idx = int(tournament[i])
        selectedPopulation[i, :] = population[idx, :]
    return selectedPopulation

"""
Cruzamento
Gera a mesma quantidade de indivíduos da população cruzando genes,
onde dois indivíduos da geração atual são selecionados aleatoriamente e
cada um é responsável por passar parte dos genes ao filho gerado
"""
def crossover(population):
    global individuals
    global polarizedCrossover
    global crossoverChance
    global alpha
    [row, col] = population.shape
    children = np.zeros((row, col))
    if (polarizedCrossover == True):
        count = 0
        while (count < individuals):
            if rd.random() <= crossoverChance:
                idx1 = rd.randint(0, row - 1)
                idx2 = rd.randint(0, row - 1)
                children[count, :] = alpha * population[idx1, :] + (1 - alpha) * population[idx2, :]
                count = count + 1
                children[count, :] = (1 - alpha) * population[idx1, :] + alpha * population[idx2, :]
                count = count + 1
    else:
        for i in range(individuals):
            idx1 = rd.randint(0, row - 1)
            idx2 = rd.randint(0, row - 1)
            aux = int(col / 2)
            children[i, 0 : aux] = population[idx1][0 : aux]
            children[i, aux : col] = population[idx2][aux : col]
    return children

"""
Mutação
Perturba uma parte da população, com uma variação de mais ou menos 5%
"""
def mutation(population):
    global mutationChance
    [row, col] = population.shape
    mutatedPopulation = np.zeros((row, col))
    for i in range(row):
        if rd.random() <= mutationChance:
            if rd.random() > 0.5:
                if rd.random() > 0.5:
                    mutatedPopulation[i, :] = population[i, :] * 1.05
                else:
                    mutatedPopulation[i, :] = population[i, :] * 0.95
            else:
                if rd.random() < 0.5:
                    mutatedPopulation[i, :] = population[i, :] * -1.05
                else:
                    mutatedPopulation[i, :] = population[i, :] * -0.95
        else:
            mutatedPopulation[i, :] = population[i, :]
    return mutatedPopulation

"""
Atualização
Mantém a melhor parte dos filhos gerados e a melhor parte dos pais da população
anterior
"""
def update(population, mutatedPopulation):
    global updateChance
    [row, col] = population.shape
    finalPopulation = np.zeros((row, col))
    count = 0
    for i in range(row):
        if rd.random() <= updateChance:
            Z = avaliation(mutatedPopulation)
            bestMutatedIndividual = np.argmin(Z)
            finalPopulation[count, :] = mutatedPopulation[bestMutatedIndividual, :]
            mutatedPopulation = mutatedPopulation[np.setdiff1d(np.arange(mutatedPopulation.shape[0]), bestMutatedIndividual)]
            count = count + 1
    while (count < individuals):
        Z = avaliation(population)
        bestIndividual = np.argmin(Z)
        finalPopulation[count, :] = population[bestIndividual, :]
        population = population[np.setdiff1d(np.arange(population.shape[0]), bestIndividual)]
        count = count + 1
    return finalPopulation

"""
Algoritmo genético
"""
def geneticAlgorithm():
    global iterations
    global crossing
    global polarizedCrossover
    # população inicial
    population = initialGeneration()
    # gerações
    for i in range(iterations):
        Z = avaliation(population)
        fitness = invert(Z)
        #bestIndividual = np.argmin(Z)
        #bestFitness = fitness[bestIndividual]
        #print("Melhor indivíduo da geração {}:".format(i + 1), population[bestIndividual, :], "Fitness:", bestFitness)
        selectedPopulation = selection(population, fitness)
        if crossing == False:
            mutatedPopulation = mutation(selectedPopulation)
            population = update(selectedPopulation, mutatedPopulation)
        else:
            if (polarizedCrossover == True):
                children = crossover(selectedPopulation)
                mutatedChildren = mutation(children)
                population = update(selectedPopulation, mutatedChildren)
            else:
                # técnica de atualização: substitui a geração anterior pelos filhos gerados
                children = crossover(selectedPopulation)
                mutatedChildren = mutation(children)
                population = mutatedChildren
    return population

"""
Executa o algoritmo genético e indica, de acordo com a última geração, o
melhor indivíduo e seu respectivo fitness.
Ao final, exibe a média dos melhores indivíduos gerados nos testes
"""
individualMean = 0
for i in range(tests):
    finalPopulation = geneticAlgorithm()
    Z = avaliation(finalPopulation)
    fitness = invert(Z)
    bestIndividual = np.argmax(fitness)
    bestFitness = fitness[bestIndividual]
    print("Melhor indivíduo:", finalPopulation[bestIndividual, :], "\tFitness", bestFitness, "\tÍndice", bestIndividual)
    individualMean = individualMean + sum(abs(finalPopulation[bestIndividual, :]))

print('Média dos melhores indivíduos dos testes:', individualMean / (tests * genes))