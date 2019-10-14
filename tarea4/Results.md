# Análisis de resultados

- [Análisis de resultados](#análisis-de-resultados)
  - [SVM](#svm)
    - [Resumen de los resultados SVM](#resumen-de-los-resultados-svm)
    - [Resultados completos SVM](#resultados-completos-svm)
  - [Red Neuronal](#red-neuronal)
    - [Resumen de los resultados de la red](#resumen-de-los-resultados-de-la-red)
    - [Resultados completos Red](#resultados-completos-red)
    - [Comparación contra SVM](#comparación-contra-svm)

## SVM

### Resumen de los resultados SVM

En esta sección, sólo se considera la precisión de cada SVM y el tiempo durador en ser entrenada. Los detalles completos de los valores usados para cada entrenamiento de pueden encontrar en los [Resultados completos SVM](#resultados-completos-svm).

En la primera prueba, se compara el kernel polinomial contra los demás tipos de kernels que Scikit tiene a disposición.

| Kernel       | Accuracy       | Elapsed Time |
| ------------ | -------------- | ------------ |
| Polynomial\* | 0.9760606061\* | 0:03:03\*    |
| Lineal       | 0.9231601732   | 0:04:49      |
| RBF          | 0.9813419913   | 0:14:27      |
| Sigmoid      | 0.347012987    | 0:18:54      |

Table: Comparación de distintos tipos de kernels para SVM

Se puede observar que el polinomial presenta los mejores resultados, junto con el menor tiempo de entrenamiento. El lineal dura casi 2min más y posee un rendimiento de aproximadamente 5% peor; el RBF mejora la precisión a costa de aumentar el triple el tiempo de entrenamiento. El sigmoide es el de peor resultados.

Se utiliza el kernel polinomial para ver la variación de los demás parámetros debido al desempeño obtenido. También se utiliza esta corrida como control, denotado por un (\*).

| Degree (Poly) | Accuracy       | Elapsed Time |
| ------------- | -------------- | ------------ |
| 3\*           | 0.9760606061\* | 0:03:03\*    |
| 1             | 0.9383549784   | 0:03:25      |
| 5             | 0.9624242424   | 0:03:53      |
| 10            | 0.8970562771   | 0:07:51      |
| 25            | 0.7251948052   | 0:17:46      |

Table: Comparación de distintos grados polinomiales

La función parece tener una forma cuadrática, pues para valores $>5$ se obtienen resultados notablemente peores; además, para valores $<3$ se tiene una tendencia decreciente.

| Penalty (Poly) | Accuracy       | Elapsed Time |
| -------------- | -------------- | ------------ |
| 5\*            | 0.9760606061\* | 0:03:03\*    |
| 0.001          | 0.9346320346   | 0:13:11      |
| 50             | 0.9760606061   | 0:03:09      |
| 500            | 0.9760606061   | 0:03:19      |
| 5000           | 0.9760606061   | 0:03:38      |

Table: Comparación de distintos costes de penalización

El comportamiento con respecto a la variación de costo es creciente hasta que se llega a un techo en el cual no se logra obtener una mejora.

| Gamma (Poly) | Accuracy       | Elapsed Time |
| ------------ | -------------- | ------------ |
| 0.01\*       | 0.9760606061\* | 0:03:03\*    |
| 0.005        | 0.9612987013   | 0:07:47      |
| 0.1          | 0.9760606061   | 0:03:05      |
| 1            | 0.9760606061   | 0:03:07      |
| 10           | 0.9760606061   | 0:03:02      |

Table: Comparación de distintos coeficientes de kernel

Ocurre una conducta similar entre el cambio de gamma por valores mayores y la penalización. Para valores más cercanos a $0$ sucede un detrimento de la precisión; para valores mayores al de control, se choca contra un techo de desempeño.

Con respecto al tiempo, existe una mejora casi despresiable cuando se alcanza el techo.

### Resultados completos SVM

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.05, kernel='linear', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2184    1   16    6    4   26   21    2    5    2]
 [   0 2554   11   10    1    5    1    6   12    3]
 [  16   35 2149   23   25   10   24   22   36   10]
 [  14   16   52 2179    3   54    3   19   24   19]
 [   5    6   27    3 2003    8    9   13    6   64]
 [  25   15   13   88   10 1869   29    5   41   12]
 [  13    4   52    5   27   41 2148    1    3    0]
 [   3   10   50   24   28    8    0 2294    1   37]
 [  23   36   29   77    7   60   20   16 1902   26]
 [  15   23   18   28   69   13    0   73   19 2043]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.05, kernel='rbf', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2242    1    9    0    2    1    6    1    4    1]
 [   0 2582    9    4    1    0    0    4    2    1]
 [   2    5 2312    4    3    1    2   11    8    2]
 [   1    0   24 2317    0    9    0    8   15    9]
 [   2    2    7    0 2101    0    3    5    1   23]
 [   3    1    2   17    4 2061    9    0    7    3]
 [   2    1    2    0    6    6 2274    0    3    0]
 [   1    8   19    0    6    1    0 2404    2   14]
 [   3    7   10    9    4    7    2    6 2144    4]
 [  13    7    6   12   12    3    1    9    6 2232]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.05, kernel='sigmoid', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[1540  152   18   11    7  140   22    9  214  154]
 [   1 1502    1   14    0   10    7    1  687  380]
 [ 222  823  474   16   26   17  184   18  337  233]
 [ 151  807   24  664    4  113   26   10  270  314]
 [  70  138   66   41  828   76    7    0   42  876]
 [ 250  323    7  236   27  241   32    8  283  700]
 [ 153  413  369   16   78   89  721    0   96  359]
 [  72  238   23   75  153   46    0  781   28 1039]
 [ 104 1363   65   67   19   78   12    2  281  205]
 [ 133  352   67  117  449  105    1   59   34  984]]
```

- Classification report for classifier SVC(C=5, degree=1,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2206    1   10    1    6   19   15    1    7    1]
 [   0 2567    7   10    1    4    0    5    7    2]
 [  18   21 2189   20   18    7   21   15   31   10]
 [   9   14   49 2205    3   45    1   18   25   14]
 [   5    9   18    1 2032    4    6    7    5   57]
 [  12   16    7   76   11 1907   31    6   36    5]
 [   4    5   33    2   16   25 2206    0    3    0]
 [   2    9   49    9   24    6    0 2317    1   38]
 [  14   32   16   68    9   54   10   11 1963   19]
 [  15   22   13   24   58    6    0   66   13 2084]]
```

- Classification report for classifier SVC(C=5, degree=5,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2223   11    7    0    1    9    7    3    5    1]
 [   0 2566    9   15    0    0    1    3    5    4]
 [  20   49 2232    5    4    3    3   14   17    3]
 [   9   22   27 2270    1   15    1    7   20   11]
 [   4   20    6    1 2076    0    1    5    6   25]
 [  13   19    5   27    4 2001   13    0   13   12]
 [  12   17   10    0    9    9 2228    0    6    3]
 [   3   21   19    2   12    2    0 2374    7   15]
 [   9   25   10   28    5   20    2    5 2082   10]
 [  19   24    7   14   22    6    0   14   15 2180]]
```

- Classification report for classifier SVC(C=5, degree=10,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2169   84    0    0    0    4    3    2    4    1]
 [   1 2537    8   16    4    0    1    7   25    4]
 [  52  181 2053    4    5    1    4   17   29    4]
 [  40  150   29 2079    1   14    0   14   38   18]
 [  16  120    8    1 1961    0    0    2    6   30]
 [  54  168    5   73   12 1695    6    3   53   38]
 [  76  107   17    3   32    8 2024    0   20    7]
 [  14  131   20    2   28    1    0 2201   15   43]
 [  38  122    7   34   12   26    1    3 1940   13]
 [  36  102    4   14   37    4    1   20   20 2063]]
```

- Classification report for classifier SVC(C=5, degree=25,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[1989  255    3    0    0   12    3    2    2    1]
 [  10 2471    2   25    5    0    4   26   35   25]
 [ 126  618 1441   18   11    6    3   50   70    7]
 [ 132  524   10 1598    0   19    0   24   46   30]
 [  29  467   16    1 1563    0    0    2    3   63]
 [ 125  576    2  165   17 1038   15    4   61  104]
 [ 226  382   16    3  106   10 1513    0   20   18]
 [  15  363    8    3   26    1    0 1949    4   86]
 [ 162  449    8   30   18   48    5   18 1423   35]
 [  62  309    1    7   68    1    0   79    7 1767]]
```

- Classification report for classifier SVC(C=0.001, degree=3,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2171    7    6    0    3   50   17    1    9    3]
 [   0 2568    5    9    2    4    1    2    8    4]
 [  10   88 2149    7   23   11    9   31   14    8]
 [   4   55   32 2142    0   77    4   32   20   17]
 [   2   37    9    0 2037    1    6    5    4   43]
 [   7   32    5   28    6 2000   17    3    6    3]
 [   8   51    2    0   14   27 2189    0    3    0]
 [   3   78   23    1   13    3    0 2296    5   33]
 [   6   69   13   41   15   54    9   11 1953   25]
 [  15   48    7   25   53   13    1   45    9 2085]]
```

- Classification report for classifier SVC(C=50, degree=3,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=500, degree=3,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=5000, degree=3,
  gamma=0.05, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.005, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2210    1    7    0    3   25    8    2    8    3]
 [   0 2571    8    9    2    0    1    3    7    2]
 [   5   34 2237    5   11   15    6   18   14    5]
 [   3   21   27 2237    0   44    2   18   19   12]
 [   3   12    6    0 2078    0    3    6    5   31]
 [   3    7    3   23    5 2041   13    2    8    2]
 [   3   13    1    0   10   16 2248    0    3    0]
 [   1   38   21    1   12    2    0 2356    4   20]
 [   4   25   11   22   12   39    5   10 2062    6]
 [  12   18    5   18   33   10    0   31    8 2166]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=0.1, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=1, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

- Classification report for classifier SVC(C=5, degree=3,
  gamma=10, kernel='poly', max_iter=-1, tol=0.001)

```()
Confusion matrix:
[[2236    1    7    0    3    3    9    2    5    1]
 [   0 2582    7    5    0    0    0    5    2    2]
 [  11   13 2286    3    4    4    5   11    9    4]
 [   3    1   28 2305    1   17    0    5   14    9]
 [   4    4    4    2 2100    0    2    8    3   17]
 [   6    5    3   21    4 2042   10    0    9    7]
 [   1    1    2    0    8    9 2268    0    3    2]
 [   1    9   19    2    9    1    0 2401    2   11]
 [   4   11    8   20    4   18    4    8 2111    8]
 [  12    8    4   15   16    5    0   15   10 2216]]
```

## Red Neuronal

### Resumen de los resultados de la red

En esta sección solo se consideran los valores de pérdida y precisión de los modelos probados de configuración de la red neuronal. Los detalles completos de las configuraciones y todas las métricas para cada entrenamiento de pueden encontrar en los [Resultados completos Red](#resultados-completos-red).

| Model Number | Accuracy     | Loss         |
| ------------ | ------------ | ------------ |
| 15           | 0.9708217072 | 0.0938597477 |
| 11           | 0.9717056454 | 0.1071203510 |
| 13           | 0.9694682312 | 0.1133420477 |

Table: Comparación de precisión y pérdida de los mejores modelos encontrados

### Resultados completos Red

Model 1:

- Layers:
  - 50 Neurons, Activation: Sigmoid
  - 50 Neurons, Activation: ReLu
- Epochs: 10
- Metrics:
  - Recall: 0.9679542892
  - Acc: 0.9680705229

### Comparación contra SVM

Las mejores configuraciones encontradas para SVM y Red neuronal están dadas por:

- SVM
  - Kernel: Polynomial
  - Degree: 3
  - Penalty: 5
  - Gamma: 0.01
  - Precisión resultante: 0.9760606061
- Red neuronal
  - Primera capa: 60 neuronas, activación: ReLu
  - Segunda capa: 60 neuronas, activación: Sigmoide
  - Precisión resultante: 0.9708217072

Se puede observar que hay una diferencia de precisiones menor al 1%.

- F1: 0.9680124026
- Loss: 0.1088766529

En esta sección se detalla la configuración de cada uno de los entrenamientos realizados, así como las métricas de Exhaustividad, Precisión, valor F1 y pérdida. Además se adjunta a cada entrenamiento la matriz de confusión resultante.
