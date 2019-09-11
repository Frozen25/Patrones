Para ejecutar los ejercicios, asegúrese que los siguientes archivos se encuentren en la misma carpeta:

	>escazu32.dat		>t2lot.m		>t2stoch.m

1. Abra la terminal en la carpeta donde se encuentren los archivos con click derecho.
2. Ejecute el programa de octave en la terminal mediante el comando octave-cli
3. Ejecute la prueba de descenso de gradiente por lotes al ejecutar: t2lot
	3.1 Inserte los puntos iniciales del mapa tridimensional mediante la consola. Se le solicitarán los puntos x, y, z
	3.2 El resultado de la corrida corresponde a tres gráficas: la trayectoria de minimización en el espacio paramétrico; la curva inicial junto a las intermadias hacia la solición optima y la evolución del error con diferentes tasas de aprendizaje.

4. Para ejecutar la prueba utilizando descenso de gradiente estocástico, ejecute: t2stoch
	4.1 Realice los mismos pasos que el punto 3
