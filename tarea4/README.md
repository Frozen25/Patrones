# Tarea4

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

Cada SVM generado se guarda en la carpeta `resource`, ubicada dentro del mismo directorio.

El nombre de cada archivo se basa según las propiedades elegidas en la creación (kernel, grado polinomial, penalidad, gamma, tolerancia, máximas iteraciones).

### Clasificación de imagen arbitraria

Para clasificar una imagen, es necesario tener algún SVM entrenado y guardado en un `.sav`, como los generados en el punto anterior.

```(console)
$ python3 test_image_svm.py
Enter classifier to use:
```

Se inserta el nombre del archivo del SVM que desea usar (ej: svm_poly_5_3_0.05_0.001_-1.sav). Una vez se carga el clasificador, se abre una ventana utilizando tkinter en donde se puede dibujar con el puntero.

El boceto se guarda en `number.png` en la carpeta `resource`. Cada vez que se guarda una imagen, el resultado de la predicción se muestra en la consola.

## Keras y Deep Learning

ALEXIS AQUI VA LO SUYO

## Dependencias

- Python3
- OpenCV
- tkinter
- PIL
- Scikit
- numpy
