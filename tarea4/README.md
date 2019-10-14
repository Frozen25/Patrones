# Tarea4

- [Tarea4](#tarea4)
  - [Scikit Learn y SVM](#scikit-learn-y-svm)
    - [Creación y entrenamiento de SVM](#creación-y-entrenamiento-de-svm)
    - [Clasificación de imagen arbitraria con SVM](#clasificación-de-imagen-arbitraria-con-svm)
  - [Keras y Deep Learning](#keras-y-deep-learning)
    - [Creación y entrenamiento de la red](#creación-y-entrenamiento-de-la-red)
    - [Clasificación de imagen arbitraria con keras](#clasificación-de-imagen-arbitraria-con-keras)
  - [Dependencias](#dependencias)

Abrir una consola desde la carpeta principal.

## Scikit Learn y SVM

Navegue a la carpeta de SVM. Esta se encuentra dentro de la carpeta `src`.

```(console)
cd src/svm
```

### Creación y entrenamiento de SVM

Para la creación de diferentes SVM, con distintos parámetros y kernels, puede ejecutar:

```(console)
$ python3 test_svm.py
Classifier info:
        Kernal: *kernel type*
        Degree: *polinomal degree*
        Cost: *penalty cost*
        Gamma: *kernel coeficient*
        Tolerance: *error margin*
        Max_Iter: *max number of iterations*

Start learning at *date-time*
Stop learning *date-time*
Elapsed learning *time*

File save: *filename*.sav

Classification report for classifier SVC(C=X, cache_size=X,
        class_weight=X, coef0=X, decision_function_shape=X,
        degree=X, gamma=X, kernel=X, max_iter=X, probability=X,
        random_state=X, shrinking=X, tol=X, verbose=X):
                precision   recall  f1-score  support

           0        X         X        X         X
           1        X         X        X         X
           2        X         X        X         X
           3        X         X        X         X
           4        X         X        X         X
           5        X         X        X         X
           6        X         X        X         X
           7        X         X        X         X
           8        X         X        X         X
           9        X         X        X         X

    accuracy                           X         X
   macro avg        X        X         X         X
weighted avg        X        X         X         X

Confusion matrix:
[[X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]
 [X   X   X   X   X   X   X   X   X   X]]

Accuracy=X
```

\*_Puede tomar tiempo en realizar todas las pruebas. X es cualquier valor._

Cada SVM generado se guarda en la carpeta `resources`, ubicada dentro del mismo directorio.

El nombre de cada archivo se basa según las propiedades elegidas en la creación (kernel, grado polinomial, penalidad, gamma, tolerancia, máximas iteraciones).

### Clasificación de imagen arbitraria con SVM

Para clasificar una imagen, es necesario tener algún SVM entrenado y guardado en un `.sav`, como los generados en el punto anterior.

```(console)
$ python3 test_image_svm.py
Enter classifier to use:
```

Se inserta el nombre del archivo del SVM que desea usar (ej: svm*poly_5_3_0.05_0.001*-1.sav). Una vez se carga el clasificador, se abre una ventana utilizando tkinter en donde se puede dibujar con el puntero.

El boceto se guarda en `number.png` en la carpeta `resources`. Cada vez que se guarda una imagen, el resultado de la predicción se muestra en la consola.

## Keras y Deep Learning

Navegue a la carpeta de SVM. Esta se encuentra dentro de la carpeta `src`.

```(console)
cd src/svm
```

### Creación y entrenamiento de la red

Para la creación de la red neuronal, ejecutar:

```(console)
python3 train.py
```

Se solicitará si se desea utilizar la configuración por defecto:

```(console)
Default configuration? (0-1):
```

Si se elige '0', se preguntará por la cantidad de capas:

```(console)
Enter amount of layers (1-100):
```

Luego se preguntará por la fución de activación de la capa por agregar

```(console)
For layer #, relu or sigmoid?:
```

Por último se solicitará la cantidad de neuronas de la capa por agregar

```(console)
Enter the number of neurons (1-200):
```

Al final del entrenamiento se muestra la matriz de confusión y los valores de precisión y pérdida finales.

### Clasificación de imagen arbitraria con keras

Para clasificar una imagen, es necesario tener la red generada en el punto anterior.

```(console)
python3 test.py
```

Se abre una ventana en donde se puede dibujar con el puntero un número.

Al hacer clic en el botón "Predict" el dibujo se guarda como `number.png` en la carpeta `resources`. Cada vez que se guarda una imagen, el resultado de la predicción se muestra en la consola.

## Dependencias

- Python3
- OpenCV
- tkinter
- PIL
- Scikit
- numpy
