# Banco de preguntas - Estadistica Aplicada

Fuente revisable para agregar preguntas al curso `estadistica-aplicada` en Supabase.

- 50 preguntas de verdadero/falso.
- 50 preguntas de alternativas.
- IDs pensados para cargar como `course_items`: `est-vf-extra-01` a `est-vf-extra-50` y `est-alt-extra-01` a `est-alt-extra-50`.

## Verdadero/Falso

1. **[est-vf-extra-01]** Si `P(A)=0,4` y `P(A^c)=0,6`, entonces A y su complemento son mutuamente excluyentes.
   - Respuesta: Verdadero
   - Pista: Un evento y su complemento no pueden ocurrir al mismo tiempo.
   - Explicacion: `A ∩ A^c` es el conjunto vacio, por eso son mutuamente excluyentes.

2. **[est-vf-extra-02]** Si `P(A ∪ B)=P(A)+P(B)`, entonces necesariamente A y B son independientes.
   - Respuesta: Falso
   - Pista: Esa igualdad aparece cuando la interseccion es cero.
   - Explicacion: La igualdad indica que `P(A ∩ B)=0`, es decir, eventos mutuamente excluyentes, no independencia.

3. **[est-vf-extra-03]** Dos eventos independientes con probabilidad positiva no pueden ser mutuamente excluyentes.
   - Respuesta: Verdadero
   - Pista: Compara `P(A ∩ B)` con `P(A)P(B)`.
   - Explicacion: Si son independientes, `P(A ∩ B)=P(A)P(B)>0`; si fueran excluyentes, la interseccion valdria 0.

4. **[est-vf-extra-04]** Si `P(A|B)=P(A)`, entonces B no cambia la probabilidad de A.
   - Respuesta: Verdadero
   - Pista: Esa es una forma de expresar independencia.
   - Explicacion: Cuando condicionar por B deja igual la probabilidad de A, B no aporta informacion probabilistica sobre A.

5. **[est-vf-extra-05]** Si `P(B)=0`, entonces `P(A|B)` esta bien definida y vale 0.
   - Respuesta: Falso
   - Pista: Revisa el denominador de la probabilidad condicional.
   - Explicacion: `P(A|B)=P(A ∩ B)/P(B)` solo se define si `P(B)>0`.

6. **[est-vf-extra-06]** La regla general de union es `P(A ∪ B)=P(A)+P(B)-P(A ∩ B)`.
   - Respuesta: Verdadero
   - Pista: Hay que corregir el doble conteo de la interseccion.
   - Explicacion: Al sumar `P(A)+P(B)`, la interseccion se cuenta dos veces; por eso se resta una vez.

7. **[est-vf-extra-07]** Si A es subconjunto de B, entonces `P(A) <= P(B)`.
   - Respuesta: Verdadero
   - Pista: Todo resultado de A tambien pertenece a B.
   - Explicacion: Por monotonia de la probabilidad, un evento contenido en otro no puede tener mayor probabilidad.

8. **[est-vf-extra-08]** Si `P(A)=0,7` y `P(B)=0,6`, entonces A y B no pueden ser mutuamente excluyentes.
   - Respuesta: Verdadero
   - Pista: Si fueran excluyentes, la union sumaria 1,3.
   - Explicacion: La probabilidad de una union no puede superar 1; como `0,7+0,6>1`, deben intersectar.

9. **[est-vf-extra-09]** En una particion del espacio muestral, los eventos son disjuntos entre si y su union cubre todo el espacio.
   - Respuesta: Verdadero
   - Pista: Una particion separa todos los casos posibles sin solaparlos.
   - Explicacion: Las particiones permiten usar probabilidad total porque dividen el espacio en casos excluyentes y exhaustivos.

10. **[est-vf-extra-10]** La formula de probabilidad total exige que los eventos condicionantes sean independientes.
    - Respuesta: Falso
    - Pista: Lo importante es que formen una particion.
    - Explicacion: Se requiere una particion con probabilidades positivas, no independencia entre los eventos de la particion.

11. **[est-vf-extra-11]** Bayes permite invertir una probabilidad condicional usando informacion previa y verosimilitudes.
    - Respuesta: Verdadero
    - Pista: Bayes relaciona `P(A|B)` con `P(B|A)`.
    - Explicacion: La formula de Bayes actualiza la probabilidad de una causa o hipotesis despues de observar evidencia.

12. **[est-vf-extra-12]** Si una prueba medica tiene alta sensibilidad, entonces necesariamente tiene alta especificidad.
    - Respuesta: Falso
    - Pista: Sensibilidad y especificidad miden errores distintos.
    - Explicacion: Una prueba puede detectar muchos enfermos y aun asi producir muchos falsos positivos.

13. **[est-vf-extra-13]** La sensibilidad corresponde a `P(test positivo | enfermo)`.
    - Respuesta: Verdadero
    - Pista: Sensibilidad mide deteccion de casos reales.
    - Explicacion: Es la probabilidad de que la prueba salga positiva dado que la persona tiene la condicion.

14. **[est-vf-extra-14]** La especificidad corresponde a `P(test negativo | sano)`.
    - Respuesta: Verdadero
    - Pista: Especificidad mide deteccion de sanos.
    - Explicacion: Es la probabilidad de descartar correctamente a una persona que no tiene la condicion.

15. **[est-vf-extra-15]** Si una enfermedad es muy poco frecuente, un test positivo puede tener bajo valor predictivo positivo.
    - Respuesta: Verdadero
    - Pista: Considera la tasa base.
    - Explicacion: Con baja prevalencia, los falsos positivos pueden pesar mucho aun con un test razonablemente bueno.

16. **[est-vf-extra-16]** En conteo, si una decision tiene m opciones y otra independiente tiene n opciones, el total combinado es `m+n`.
    - Respuesta: Falso
    - Pista: Para decisiones sucesivas se multiplica.
    - Explicacion: El principio multiplicativo da `m*n` combinaciones cuando ambas decisiones se realizan.

17. **[est-vf-extra-17]** Si importa el orden, normalmente se usan permutaciones o variaciones.
    - Respuesta: Verdadero
    - Pista: Ordenar ABC no es lo mismo que BAC.
    - Explicacion: Cuando el orden cambia el resultado, se cuentan arreglos ordenados.

18. **[est-vf-extra-18]** En combinaciones, elegir A y B es distinto de elegir B y A.
    - Respuesta: Falso
    - Pista: En combinaciones no importa el orden.
    - Explicacion: Las combinaciones cuentan grupos, no secuencias.

19. **[est-vf-extra-19]** `C(n,k)=C(n,n-k)`.
    - Respuesta: Verdadero
    - Pista: Elegir k incluidos equivale a elegir n-k excluidos.
    - Explicacion: La simetria combinatoria dice que ambas formas cuentan lo mismo.

20. **[est-vf-extra-20]** Al lanzar dos dados justos, hay 12 resultados equiprobables si se suman los puntos.
    - Respuesta: Falso
    - Pista: Considera pares ordenados, no solo sumas.
    - Explicacion: Hay 36 pares ordenados equiprobables; las sumas no tienen todas la misma cantidad de formas.

21. **[est-vf-extra-21]** En una variable binomial, los ensayos deben tener la misma probabilidad de exito.
    - Respuesta: Verdadero
    - Pista: La probabilidad p se mantiene fija.
    - Explicacion: La binomial asume numero fijo de ensayos, independencia y probabilidad de exito constante.

22. **[est-vf-extra-22]** En una binomial `X ~ Bin(n,p)`, la esperanza es `np`.
    - Respuesta: Verdadero
    - Pista: Suma de n ensayos Bernoulli.
    - Explicacion: Cada ensayo tiene esperanza p, por linealidad la suma tiene esperanza `np`.

23. **[est-vf-extra-23]** En una binomial `X ~ Bin(n,p)`, la varianza es `np`.
    - Respuesta: Falso
    - Pista: Falta el factor de fracaso.
    - Explicacion: La varianza binomial es `np(1-p)`.

24. **[est-vf-extra-24]** Una variable aleatoria discreta puede tomar valores contables.
    - Respuesta: Verdadero
    - Pista: Piensa en conteos: 0, 1, 2, ...
    - Explicacion: Las variables discretas toman un conjunto finito o numerable de valores.

25. **[est-vf-extra-25]** Para cualquier variable aleatoria, la suma de probabilidades de todos sus valores posibles debe ser 1.
    - Respuesta: Falso
    - Pista: Eso aplica directamente a variables discretas.
    - Explicacion: En variables continuas se integran densidades; probabilidades puntuales suelen ser 0.

26. **[est-vf-extra-26]** En una distribucion continua, `P(X=a)=0` para un punto exacto.
    - Respuesta: Verdadero
    - Pista: La probabilidad se mide en intervalos.
    - Explicacion: En modelos continuos, un punto aislado tiene area cero bajo la curva.

27. **[est-vf-extra-27]** La media muestral siempre coincide con la mediana muestral.
    - Respuesta: Falso
    - Pista: Revisa una muestra asimetrica.
    - Explicacion: La media usa magnitudes; la mediana usa posicion central. Pueden diferir bastante.

28. **[est-vf-extra-28]** La mediana es mas resistente a valores extremos que la media.
    - Respuesta: Verdadero
    - Pista: Cambia un dato muy grande y observa que pasa.
    - Explicacion: Un outlier puede arrastrar la media, pero suele afectar menos la posicion central.

29. **[est-vf-extra-29]** La varianza nunca puede ser negativa.
    - Respuesta: Verdadero
    - Pista: Se calcula con desviaciones al cuadrado.
    - Explicacion: Al promediar cuadrados, el resultado es mayor o igual a cero.

30. **[est-vf-extra-30]** Si todos los datos de una muestra son iguales, la desviacion estandar es 0.
    - Respuesta: Verdadero
    - Pista: No hay dispersion.
    - Explicacion: Todas las desviaciones respecto de la media son cero.

31. **[est-vf-extra-31]** Un histograma y un grafico de barras siempre representan lo mismo.
    - Respuesta: Falso
    - Pista: Uno se usa para variables cuantitativas agrupadas.
    - Explicacion: El histograma representa intervalos de una variable cuantitativa; el grafico de barras suele representar categorias.

32. **[est-vf-extra-32]** La correlacion mide necesariamente causalidad.
    - Respuesta: Falso
    - Pista: Asociacion no implica causa.
    - Explicacion: Dos variables pueden moverse juntas por azar, por una tercera variable o por causalidad inversa.

33. **[est-vf-extra-33]** El coeficiente de correlacion de Pearson siempre esta entre -1 y 1.
    - Respuesta: Verdadero
    - Pista: Sus extremos representan relacion lineal perfecta.
    - Explicacion: Pearson se normaliza por las desviaciones estandar, por eso queda acotado en ese rango.

34. **[est-vf-extra-34]** Una correlacion cercana a 0 descarta cualquier relacion entre dos variables.
    - Respuesta: Falso
    - Pista: Pearson detecta relacion lineal.
    - Explicacion: Puede existir una relacion no lineal fuerte aunque la correlacion lineal sea baja.

35. **[est-vf-extra-35]** El sesgo de seleccion puede producir conclusiones equivocadas aun con muchos datos.
    - Respuesta: Verdadero
    - Pista: Mas datos sesgados siguen siendo sesgados.
    - Explicacion: Si la muestra no representa a la poblacion, aumentar el tamano no corrige automaticamente el sesgo.

36. **[est-vf-extra-36]** A mayor tamano muestral, el error estandar de la media tiende a disminuir.
    - Respuesta: Verdadero
    - Pista: El denominador incluye `sqrt(n)`.
    - Explicacion: El error estandar de la media es `sigma/sqrt(n)` o `s/sqrt(n)`.

37. **[est-vf-extra-37]** El teorema central del limite dice que los datos originales siempre son normales.
    - Respuesta: Falso
    - Pista: Habla de la distribucion de medias muestrales.
    - Explicacion: Bajo condiciones adecuadas, la media muestral se aproxima a normal aunque los datos originales no lo sean.

38. **[est-vf-extra-38]** Un intervalo de confianza del 95% significa que el parametro tiene 95% de probabilidad de estar en ese intervalo ya calculado.
    - Respuesta: Falso
    - Pista: En enfoque frecuentista, el parametro es fijo.
    - Explicacion: El 95% describe el metodo: en muchas muestras, cerca del 95% de los intervalos construidos contendrian el parametro.

39. **[est-vf-extra-39]** Si se aumenta el nivel de confianza, manteniendo todo lo demas constante, el intervalo suele hacerse mas ancho.
    - Respuesta: Verdadero
    - Pista: Para estar mas seguro, necesitas cubrir mas.
    - Explicacion: Un mayor nivel de confianza usa un valor critico mayor, aumentando el margen de error.

40. **[est-vf-extra-40]** Un p-valor pequeno es evidencia contra la hipotesis nula.
    - Respuesta: Verdadero
    - Pista: Compara con el nivel de significancia.
    - Explicacion: Un p-valor pequeno indica que los datos observados serian raros si la nula fuera cierta.

41. **[est-vf-extra-41]** El p-valor es la probabilidad de que la hipotesis nula sea verdadera.
    - Respuesta: Falso
    - Pista: Es una probabilidad de datos, no de hipotesis.
    - Explicacion: El p-valor se calcula suponiendo la nula verdadera; no entrega directamente `P(H0 verdadera)`.

42. **[est-vf-extra-42]** Rechazar H0 al 5% significa aceptar automaticamente que H1 es verdadera con 95% de probabilidad.
    - Respuesta: Falso
    - Pista: No confundas significancia con probabilidad posterior.
    - Explicacion: El test controla una regla de decision; no asigna probabilidad directa a las hipotesis.

43. **[est-vf-extra-43]** Un error tipo I consiste en rechazar una hipotesis nula que en realidad es verdadera.
    - Respuesta: Verdadero
    - Pista: Tipo I se asocia con falso positivo.
    - Explicacion: Se declara un efecto o diferencia cuando en realidad la nula era correcta.

44. **[est-vf-extra-44]** Un error tipo II consiste en no rechazar una hipotesis nula falsa.
    - Respuesta: Verdadero
    - Pista: Tipo II se asocia con falso negativo.
    - Explicacion: El test no detecta un efecto o diferencia que si existe.

45. **[est-vf-extra-45]** La potencia de un test es `1 - beta`.
    - Respuesta: Verdadero
    - Pista: Beta es probabilidad de error tipo II.
    - Explicacion: La potencia es la probabilidad de rechazar H0 cuando H0 es falsa.

46. **[est-vf-extra-46]** Si el intervalo de confianza para una diferencia de medias contiene 0, suele no haber evidencia significativa de diferencia al nivel asociado.
    - Respuesta: Verdadero
    - Pista: Cero representa ausencia de diferencia.
    - Explicacion: Si 0 es plausible dentro del intervalo, no se descarta la igualdad al nivel correspondiente.

47. **[est-vf-extra-47]** En una regresion lineal simple, la pendiente indica el cambio esperado en Y por una unidad adicional de X.
    - Respuesta: Verdadero
    - Pista: Interpreta `Y = a + bX`.
    - Explicacion: La pendiente b mide el cambio promedio esperado en la respuesta cuando X aumenta en una unidad.

48. **[est-vf-extra-48]** Un R cuadrado alto garantiza que el modelo es causalmente correcto.
    - Respuesta: Falso
    - Pista: Ajuste no es causalidad.
    - Explicacion: R cuadrado mide proporcion de variabilidad explicada en la muestra, no validez causal.

49. **[est-vf-extra-49]** Estandarizar una variable consiste en restar su media y dividir por su desviacion estandar.
    - Respuesta: Verdadero
    - Pista: Es el calculo del puntaje z.
    - Explicacion: La transformacion `z=(x-media)/desviacion` deja la variable en unidades de desviacion estandar.

50. **[est-vf-extra-50]** Si dos variables tienen la misma media, entonces necesariamente tienen la misma dispersion.
    - Respuesta: Falso
    - Pista: Media y dispersion resumen aspectos distintos.
    - Explicacion: Dos conjuntos pueden tener igual centro y varianzas muy distintas.

## Alternativas

1. **[est-alt-extra-01]** Si `P(A)=0,35`, cuanto vale `P(A^c)`?
   - a) 0,35
   - b) 0,65
   - c) 1,35
   - d) 0
   - Respuesta: b
   - Pista: Usa la regla del complemento.
   - Explicacion: `P(A^c)=1-P(A)=1-0,35=0,65`.

2. **[est-alt-extra-02]** Si `P(A)=0,5`, `P(B)=0,4` y `P(A∩B)=0,2`, cuanto vale `P(A∪B)`?
   - a) 0,7
   - b) 0,9
   - c) 0,2
   - d) 1,1
   - Respuesta: a
   - Pista: Usa la regla general de union.
   - Explicacion: `0,5+0,4-0,2=0,7`.

3. **[est-alt-extra-03]** Si `P(A∩B)=0,12` y `P(B)=0,30`, cuanto vale `P(A|B)`?
   - a) 0,04
   - b) 0,18
   - c) 0,40
   - d) 2,50
   - Respuesta: c
   - Pista: Divide la interseccion por la probabilidad del evento condicionante.
   - Explicacion: `P(A|B)=0,12/0,30=0,40`.

4. **[est-alt-extra-04]** Si A y B son independientes, `P(A)=0,6` y `P(B)=0,5`, cuanto vale `P(A∩B)`?
   - a) 0,10
   - b) 0,30
   - c) 0,60
   - d) 1,10
   - Respuesta: b
   - Pista: Para independencia se multiplican probabilidades.
   - Explicacion: `P(A∩B)=0,6*0,5=0,30`.

5. **[est-alt-extra-05]** Si A y B son mutuamente excluyentes, `P(A)=0,25` y `P(B)=0,30`, cuanto vale `P(A∩B)`?
   - a) 0
   - b) 0,075
   - c) 0,25
   - d) 0,55
   - Respuesta: a
   - Pista: Eventos excluyentes no ocurren juntos.
   - Explicacion: La interseccion de eventos mutuamente excluyentes es vacia.

6. **[est-alt-extra-06]** Una bolsa tiene 3 bolas rojas y 2 azules. Si se extrae una al azar, cual es la probabilidad de roja?
   - a) 2/5
   - b) 3/5
   - c) 3/2
   - d) 1/5
   - Respuesta: b
   - Pista: Casos favorables sobre casos totales.
   - Explicacion: Hay 3 rojas de 5 bolas totales, entonces la probabilidad es `3/5`.

7. **[est-alt-extra-07]** Se lanzan dos monedas justas. Cual es la probabilidad de obtener exactamente una cara?
   - a) 1/4
   - b) 1/2
   - c) 3/4
   - d) 1
   - Respuesta: b
   - Pista: Lista los cuatro resultados equiprobables.
   - Explicacion: Los casos favorables son cara-sello y sello-cara: 2 de 4.

8. **[est-alt-extra-08]** Al lanzar un dado justo, cual es la probabilidad de obtener un numero par?
   - a) 1/6
   - b) 1/3
   - c) 1/2
   - d) 2/3
   - Respuesta: c
   - Pista: Los pares son 2, 4 y 6.
   - Explicacion: Hay 3 resultados pares de 6 posibles, `3/6=1/2`.

9. **[est-alt-extra-09]** Al lanzar dos dados justos, cual es la probabilidad de que la suma sea 7?
   - a) 1/12
   - b) 1/9
   - c) 1/6
   - d) 7/36
   - Respuesta: c
   - Pista: Cuenta pares ordenados que suman 7.
   - Explicacion: Hay 6 pares favorables de 36: `6/36=1/6`.

10. **[est-alt-extra-10]** Cuantos codigos de 3 digitos se pueden formar con digitos 0-9 si se permite repeticion?
    - a) 30
    - b) 100
    - c) 720
    - d) 1000
    - Respuesta: d
    - Pista: Hay 10 opciones en cada posicion.
    - Explicacion: `10*10*10=1000`.

11. **[est-alt-extra-11]** Cuantas formas hay de ordenar 4 personas en una fila?
    - a) 4
    - b) 12
    - c) 16
    - d) 24
    - Respuesta: d
    - Pista: Es una permutacion de 4 elementos.
    - Explicacion: `4! = 24`.

12. **[est-alt-extra-12]** Cuantas formas hay de elegir 2 personas de un grupo de 5, sin importar el orden?
    - a) 10
    - b) 20
    - c) 25
    - d) 5
    - Respuesta: a
    - Pista: Usa combinaciones.
    - Explicacion: `C(5,2)=5*4/2=10`.

13. **[est-alt-extra-13]** Cuantos arreglos ordenados de 2 letras distintas se pueden formar con A, B, C, D?
    - a) 6
    - b) 8
    - c) 12
    - d) 16
    - Respuesta: c
    - Pista: Para la primera hay 4 opciones y para la segunda quedan 3.
    - Explicacion: `4*3=12`.

14. **[est-alt-extra-14]** Una clave tiene 2 letras distintas de 5 posibles y luego 1 digito de 10 posibles. Cuantas claves hay si importa el orden de las letras?
    - a) 50
    - b) 100
    - c) 200
    - d) 250
    - Respuesta: c
    - Pista: Multiplica las decisiones sucesivas.
    - Explicacion: `5*4*10=200`.

15. **[est-alt-extra-15]** En una binomial con `n=10` y `p=0,3`, cual es la esperanza?
    - a) 0,3
    - b) 3
    - c) 7
    - d) 10
    - Respuesta: b
    - Pista: Usa `E(X)=np`.
    - Explicacion: `10*0,3=3`.

16. **[est-alt-extra-16]** En una binomial con `n=20` y `p=0,5`, cual es la varianza?
    - a) 5
    - b) 10
    - c) 20
    - d) 25
    - Respuesta: a
    - Pista: Usa `np(1-p)`.
    - Explicacion: `20*0,5*0,5=5`.

17. **[est-alt-extra-17]** Si `X ~ Bin(3,0,5)`, cual es `P(X=0)`?
    - a) 0,125
    - b) 0,250
    - c) 0,375
    - d) 0,500
    - Respuesta: a
    - Pista: Cero exitos significa tres fracasos.
    - Explicacion: `(0,5)^3=0,125`.

18. **[est-alt-extra-18]** Si `X ~ Bin(4,0,5)`, cual es `P(X=2)`?
    - a) 0,125
    - b) 0,250
    - c) 0,375
    - d) 0,500
    - Respuesta: c
    - Pista: Usa `C(4,2)(0,5)^2(0,5)^2`.
    - Explicacion: `6*(0,5)^4 = 6/16 = 0,375`.

19. **[est-alt-extra-19]** Si una maquina A produce 70% con 2% defectos y B produce 30% con 5% defectos, cual es `P(defecto)`?
    - a) 0,014
    - b) 0,015
    - c) 0,029
    - d) 0,070
    - Respuesta: c
    - Pista: Pondera cada tasa por su proporcion de produccion.
    - Explicacion: `0,70*0,02 + 0,30*0,05 = 0,029`.

20. **[est-alt-extra-20]** En el caso anterior, si una pieza es defectuosa, cual formula corresponde a `P(A|defecto)`?
    - a) `P(A)P(defecto|A)/P(defecto)`
    - b) `P(defecto)/P(A)`
    - c) `P(A)+P(defecto)`
    - d) `P(A)/P(defecto|A)`
    - Respuesta: a
    - Pista: Usa Bayes.
    - Explicacion: Bayes da `P(A|D)=P(A)P(D|A)/P(D)`.

21. **[est-alt-extra-21]** Una prueba tiene sensibilidad 0,90. Que significa?
    - a) `P(enfermo | positivo)=0,90`
    - b) `P(positivo | enfermo)=0,90`
    - c) `P(negativo | sano)=0,90`
    - d) `P(sano | negativo)=0,90`
    - Respuesta: b
    - Pista: Sensibilidad es detectar enfermos.
    - Explicacion: Sensibilidad es la probabilidad de positivo dado que la persona esta enferma.

22. **[est-alt-extra-22]** Una prueba tiene especificidad 0,95. Que significa?
    - a) `P(negativo | sano)=0,95`
    - b) `P(positivo | sano)=0,95`
    - c) `P(sano | negativo)=0,95`
    - d) `P(enfermo | positivo)=0,95`
    - Respuesta: a
    - Pista: Especificidad es detectar sanos.
    - Explicacion: Es la probabilidad de negativo dado que la persona esta sana.

23. **[est-alt-extra-23]** Para los datos 2, 4, 6, 8, cual es la media?
    - a) 4
    - b) 5
    - c) 6
    - d) 8
    - Respuesta: b
    - Pista: Suma y divide por 4.
    - Explicacion: `(2+4+6+8)/4=20/4=5`.

24. **[est-alt-extra-24]** Para los datos 1, 3, 9, cual es la mediana?
    - a) 1
    - b) 3
    - c) 4,33
    - d) 9
    - Respuesta: b
    - Pista: Ordena y toma el valor central.
    - Explicacion: El valor central de 1, 3, 9 es 3.

25. **[est-alt-extra-25]** Para los datos 2, 2, 2, 2, cual es la desviacion estandar?
    - a) 0
    - b) 1
    - c) 2
    - d) 4
    - Respuesta: a
    - Pista: No hay variacion entre datos.
    - Explicacion: Todos los valores coinciden con la media, por eso la dispersion es cero.

26. **[est-alt-extra-26]** Cual medida es mas resistente a outliers?
    - a) Media
    - b) Mediana
    - c) Rango
    - d) Varianza
    - Respuesta: b
    - Pista: Piensa en una observacion extremadamente grande.
    - Explicacion: La mediana depende de la posicion central y suele cambiar menos ante extremos.

27. **[est-alt-extra-27]** Si todos los datos se multiplican por 10, que ocurre con la media?
    - a) Se divide por 10
    - b) No cambia
    - c) Se multiplica por 10
    - d) Se suma 10
    - Respuesta: c
    - Pista: La media conserva cambios de escala.
    - Explicacion: Multiplicar todos los datos por una constante multiplica la media por esa constante.

28. **[est-alt-extra-28]** Si a todos los datos se les suma 5, que ocurre con la desviacion estandar?
    - a) Aumenta en 5
    - b) Disminuye en 5
    - c) Se multiplica por 5
    - d) No cambia
    - Respuesta: d
    - Pista: La dispersion relativa al centro queda igual.
    - Explicacion: Sumar una constante desplaza todos los datos, pero no cambia las distancias entre ellos.

29. **[est-alt-extra-29]** Que grafico es mas adecuado para una variable cualitativa nominal?
    - a) Grafico de barras
    - b) Histograma
    - c) Diagrama de dispersion
    - d) Boxplot
    - Respuesta: a
    - Pista: Las categorias se comparan con barras separadas.
    - Explicacion: El grafico de barras muestra frecuencias por categoria.

30. **[est-alt-extra-30]** Que grafico es mas adecuado para ver relacion entre dos variables cuantitativas?
    - a) Histograma
    - b) Grafico circular
    - c) Diagrama de dispersion
    - d) Tabla de frecuencia simple
    - Respuesta: c
    - Pista: Cada punto representa un par `(x,y)`.
    - Explicacion: El scatterplot permite observar asociacion, tendencia y posibles outliers bivariados.

31. **[est-alt-extra-31]** Si la correlacion de Pearson es -0,8, que interpretacion es correcta?
    - a) Relacion lineal negativa fuerte
    - b) Relacion lineal positiva fuerte
    - c) Ausencia total de relacion
    - d) Causalidad negativa demostrada
    - Respuesta: a
    - Pista: Mira signo y magnitud.
    - Explicacion: El signo negativo indica direccion inversa y 0,8 en magnitud sugiere relacion lineal fuerte.

32. **[est-alt-extra-32]** Cual valor no puede ser una correlacion de Pearson?
    - a) -1
    - b) 0
    - c) 0,75
    - d) 1,4
    - Respuesta: d
    - Pista: Pearson esta acotado.
    - Explicacion: La correlacion debe estar entre -1 y 1.

33. **[est-alt-extra-33]** En una recta `Y = 2 + 3X`, cual es la pendiente?
    - a) 2
    - b) 3
    - c) 5
    - d) X
    - Respuesta: b
    - Pista: La pendiente multiplica a X.
    - Explicacion: En `Y=a+bX`, la pendiente es b; aqui b=3.

34. **[est-alt-extra-34]** En `Y = 2 + 3X`, cuanto se espera que cambie Y si X aumenta en 1?
    - a) Disminuye en 3
    - b) Aumenta en 2
    - c) Aumenta en 3
    - d) No cambia
    - Respuesta: c
    - Pista: Interpreta la pendiente.
    - Explicacion: La pendiente 3 indica aumento esperado de 3 unidades en Y por cada unidad adicional de X.

35. **[est-alt-extra-35]** Que representa R cuadrado en regresion lineal?
    - a) Probabilidad de causalidad
    - b) Proporcion de variabilidad de Y explicada por el modelo
    - c) Promedio de X
    - d) Error maximo del modelo
    - Respuesta: b
    - Pista: Es una medida de ajuste.
    - Explicacion: R cuadrado resume que fraccion de la variabilidad de la respuesta queda explicada por el modelo.

36. **[est-alt-extra-36]** Si una muestra tiene `n=100` y desviacion estandar `s=20`, cual es el error estandar de la media?
    - a) 0,2
    - b) 2
    - c) 10
    - d) 20
    - Respuesta: b
    - Pista: Usa `s/sqrt(n)`.
    - Explicacion: `20/sqrt(100)=20/10=2`.

37. **[est-alt-extra-37]** Si un intervalo de confianza se calcula como `media ± 1,96*EE`, que nivel aproximado se esta usando?
    - a) 50%
    - b) 68%
    - c) 95%
    - d) 99,9%
    - Respuesta: c
    - Pista: 1,96 es el valor critico normal clasico.
    - Explicacion: Para una normal estandar, 1,96 corresponde aproximadamente a 95% bilateral.

38. **[est-alt-extra-38]** Si el p-valor es 0,03 y `alpha=0,05`, que decision se toma?
    - a) Rechazar H0
    - b) No rechazar H0
    - c) Aceptar H0 como verdadera
    - d) Aumentar alpha automaticamente
    - Respuesta: a
    - Pista: Compara p-valor con alpha.
    - Explicacion: Como `0,03 < 0,05`, se rechaza H0 al 5%.

39. **[est-alt-extra-39]** Si el p-valor es 0,12 y `alpha=0,05`, que decision se toma?
    - a) Rechazar H0
    - b) No rechazar H0
    - c) Rechazar H1
    - d) Probar que H0 es verdadera
    - Respuesta: b
    - Pista: El p-valor es mayor que alpha.
    - Explicacion: No hay evidencia suficiente para rechazar H0 al 5%.

40. **[est-alt-extra-40]** Cual es un error tipo I?
    - a) No rechazar H0 falsa
    - b) Rechazar H0 verdadera
    - c) Calcular mal la media
    - d) Usar una muestra grande
    - Respuesta: b
    - Pista: Tipo I es falso positivo.
    - Explicacion: Se concluye que hay efecto cuando la nula era verdadera.

41. **[est-alt-extra-41]** Cual es un error tipo II?
    - a) Rechazar H0 verdadera
    - b) No rechazar H0 falsa
    - c) Aumentar el tamano muestral
    - d) Usar una variable cualitativa
    - Respuesta: b
    - Pista: Tipo II es falso negativo.
    - Explicacion: El test no detecta un efecto que realmente existe.

42. **[est-alt-extra-42]** La potencia de un test se define como:
    - a) `alpha`
    - b) `beta`
    - c) `1 - beta`
    - d) `1 - alpha`
    - Respuesta: c
    - Pista: Beta es error tipo II.
    - Explicacion: La potencia es la probabilidad de rechazar H0 cuando H0 es falsa.

43. **[est-alt-extra-43]** Si se aumenta el tamano muestral manteniendo la variabilidad, que suele pasar con el margen de error?
    - a) Aumenta
    - b) Disminuye
    - c) No cambia nunca
    - d) Se vuelve negativo
    - Respuesta: b
    - Pista: El error estandar baja con `sqrt(n)`.
    - Explicacion: Mas muestra reduce el error estandar y normalmente estrecha intervalos.

44. **[est-alt-extra-44]** Cual afirmacion sobre muestreo aleatorio es correcta?
    - a) Garantiza que no habra variacion muestral
    - b) Ayuda a reducir sesgos de seleccion
    - c) Hace innecesaria la estadistica
    - d) Siempre produce la media exacta poblacional
    - Respuesta: b
    - Pista: Aleatorizar mejora representatividad, no elimina azar.
    - Explicacion: El muestreo aleatorio ayuda a evitar seleccion sistematica, aunque sigue habiendo error muestral.

45. **[est-alt-extra-45]** Cual es el puntaje z de `x=80` si la media es 70 y la desviacion estandar es 5?
    - a) -2
    - b) 0
    - c) 2
    - d) 10
    - Respuesta: c
    - Pista: Usa `(x-media)/desviacion`.
    - Explicacion: `(80-70)/5=2`.

46. **[est-alt-extra-46]** Si una distribucion normal tiene media 100 y desviacion 15, aproximadamente que porcentaje cae entre 85 y 115?
    - a) 50%
    - b) 68%
    - c) 95%
    - d) 99,7%
    - Respuesta: b
    - Pista: Es una desviacion estandar alrededor de la media.
    - Explicacion: Por la regla empirica, cerca del 68% cae dentro de ±1 desviacion estandar.

47. **[est-alt-extra-47]** Que valor resume mejor el centro de una distribucion muy asimetrica con outliers?
    - a) Mediana
    - b) Media
    - c) Rango
    - d) Maximo
    - Respuesta: a
    - Pista: Busca una medida robusta.
    - Explicacion: La mediana suele representar mejor el centro cuando hay asimetria fuerte o outliers.

48. **[est-alt-extra-48]** En una tabla de frecuencias, la frecuencia relativa se obtiene:
    - a) Sumando todas las categorias
    - b) Dividiendo la frecuencia absoluta por el total
    - c) Multiplicando por la media
    - d) Restando el minimo
    - Respuesta: b
    - Pista: Es una proporcion.
    - Explicacion: La frecuencia relativa indica que fraccion del total pertenece a una categoria.

49. **[est-alt-extra-49]** Si hay 12 casos favorables de 40 posibles equiprobables, cual es la probabilidad?
    - a) 0,12
    - b) 0,24
    - c) 0,30
    - d) 0,40
    - Respuesta: c
    - Pista: Divide favorables por posibles.
    - Explicacion: `12/40=0,30`.

50. **[est-alt-extra-50]** Que significa que dos eventos sean exhaustivos?
    - a) Que no pueden ocurrir juntos
    - b) Que su union cubre todos los resultados posibles
    - c) Que son independientes
    - d) Que tienen igual probabilidad
    - Respuesta: b
    - Pista: Exhaustivo viene de cubrir todos los casos.
    - Explicacion: Un conjunto de eventos exhaustivo no deja resultados posibles fuera de su union.
