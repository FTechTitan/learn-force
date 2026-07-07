-- ============================================================================
--  Mueve el curso Python de hardcode frontend a Supabase.
--  La app queda alimentada por public.courses/course_modules/course_items.
-- ============================================================================

alter table public.courses
  add column if not exists media jsonb not null default '{}'::jsonb;

alter table public.course_modules
  add column if not exists media jsonb not null default '{}'::jsonb;

insert into public.courses
  (id, title, subtitle, description, emoji, sort_order, is_published, media)
values (
  'python-de-a-poco',
  'Python de a poco',
  'Aprende programando · curso UAI',
  'Ejercicios de programación Python corregidos automáticamente.',
  '🐍',
  10,
  true,
  '{"titulo":"Podcast del curso","sub":"Repaso técnico en audio de toda la materia: condicionales, ciclos y listas, con sintaxis, ejemplos y errores comunes.","audio":"https://bipsvhxsvfzfwzufucfg.supabase.co/storage/v1/object/public/media/curso-podcast.mp3"}'::jsonb
)
on conflict (id) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  emoji = excluded.emoji,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media;

delete from public.course_items where course_id = 'python-de-a-poco';
delete from public.course_modules
where course_id = 'python-de-a-poco' and id not in ('condicionales', 'ciclos', 'listas', 'anidados', 'matrices');

insert into public.course_modules
  (id, course_id, title, emoji, intro, theory, sort_order, is_published, media)
values
  ('condicionales', 'python-de-a-poco', 'Condicionales', '🔀', 'Los condicionales le dan <b>inteligencia</b> al programa: permiten decidir qué instrucciones ejecutar según una condición lógica (<code>if</code>, <code>elif</code>, <code>else</code>).', '
<p>La forma básica de un condicional en Python:</p>
<pre><code>if condicion:
    # se ejecuta si la condición es VERDADERA
else:
    # se ejecuta si la condición es FALSA</code></pre>
<p>Solo el <code>if</code> lleva una condición explícita. El <code>else</code> es
"todo lo demás". Para varias decisiones usamos <code>elif</code>:</p>
<pre><code>if nota &gt;= 4.0:
    print("Aprobado")
elif nota &gt;= 3.0:
    print("En riesgo")
else:
    print("Reprobado")</code></pre>
<p>Operadores de comparación: <code>==  !=  &lt;  &gt;  &lt;=  &gt;=</code>.
Operadores lógicos para combinar condiciones: <code>and</code>, <code>or</code>,
<code>not</code>.</p>', 10, true, '{"video":"https://bipsvhxsvfzfwzufucfg.supabase.co/storage/v1/object/public/media/condicionales.mp4","presentacion":"presentaciones/condicionales.html"}'::jsonb),
  ('ciclos', 'python-de-a-poco', 'Ciclos', '🔁', 'Un ciclo permite <b>repetir</b> instrucciones. Python tiene dos: <code>while</code> (repite mientras se cumpla una condición) y <code>for</code> (recorre un rango o una secuencia).', '
<p><b>while</b> — repite mientras la condición sea verdadera:</p>
<pre><code>contador = 0
while contador &lt; 5:
    print(contador)
    contador = contador + 1</code></pre>
<p><b>for</b> con <code>range</code> — más compacto cuando sabés cuántas veces:</p>
<pre><code>for i in range(1, 6):      # genera 1, 2, 3, 4, 5
    print(i)

range(inicio, fin, paso)   # fin NO se incluye</code></pre>
<p>Ojo con el <b>caso de borde</b>: si la condición del while es falsa desde el
inicio, el bloque no se ejecuta nunca.</p>', 20, true, '{"video":"https://bipsvhxsvfzfwzufucfg.supabase.co/storage/v1/object/public/media/ciclos.mp4","presentacion":"presentaciones/ciclos.html"}'::jsonb),
  ('listas', 'python-de-a-poco', 'Listas', '📋', 'Una <b>lista</b> agrupa muchos valores en una sola variable. Se accede a cada elemento por su <b>índice</b> (empezando en 0).', '
<p>Crear y acceder:</p>
<pre><code>numeros = [10, 20, 30]
print(numeros[0])     # 10  (primer elemento)
print(numeros[-1])    # 30  (último elemento)
print(len(numeros))   # 3   (cantidad de elementos)</code></pre>
<p>Modificar:</p>
<pre><code>numeros.append(40)    # agrega al final -> [10,20,30,40]
numeros[0] = 99       # cambia un elemento
</code></pre>
<p>Recorrer:</p>
<pre><code>for x in numeros:
    print(x)

suma = 0
for x in numeros:
    suma = suma + x</code></pre>', 30, true, '{"video":"https://bipsvhxsvfzfwzufucfg.supabase.co/storage/v1/object/public/media/listas.mp4","presentacion":"presentaciones/listas.html"}'::jsonb),
  ('anidados', 'python-de-a-poco', 'Ciclos anidados', '🔳', 'Un <b>ciclo anidado</b> es un ciclo dentro de otro. El ciclo externo repite líneas; el interno repite elementos dentro de cada línea. Sirve para dibujar patrones, tablas y recorrer dos dimensiones.', '
<p>Un <code>for</code> dentro de otro <code>for</code>. Por cada vuelta del ciclo
externo, el interno hace <b>todas</b> sus vueltas:</p>
<pre><code>for i in range(1, 4):       # externo: 3 filas
    for j in range(1, 6):   # interno: 5 columnas
        print("#", end="")  # end="" -> no salta de línea
    print("")               # salta a la línea siguiente</code></pre>
<p>Imprime:</p>
<pre><code>#####
#####
#####</code></pre>
<p>La clave: <code>print("algo", end="")</code> escribe <b>sin</b> saltar de línea,
y un <code>print("")</code> al final del ciclo interno cierra la fila.</p>', 40, true, '{}'::jsonb),
  ('matrices', 'python-de-a-poco', 'Matrices', '🔢', 'Una <b>matriz</b> es una lista de listas (2 dimensiones): tiene filas y columnas. Se accede a cada dato con dos índices: <code>M[i][j]</code> (fila <code>i</code>, columna <code>j</code>).', '
<p>Crear y acceder:</p>
<pre><code>M = [[1, 2, 3],
     [4, 5, 6]]
print(M[0][0])   # 1   (fila 0, columna 0)
print(M[1][2])   # 6   (fila 1, columna 2)
M[0][1] = 99     # modifica un elemento</code></pre>
<p>Tamaño:</p>
<pre><code>len(M)      # 2  -> número de filas
len(M[0])   # 3  -> número de columnas de la fila 0</code></pre>
<p>Recorrer con <b>ciclos dobles</b>:</p>
<pre><code>for i in range(len(M)):
    for j in range(len(M[i])):
        print(M[i][j])</code></pre>', 50, true, '{}'::jsonb)
on conflict (id) do update set
  course_id = excluded.course_id,
  title = excluded.title,
  emoji = excluded.emoji,
  intro = excluded.intro,
  theory = excluded.theory,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media;

insert into public.course_items
  (id, course_id, module_id, type, title, level, statement_html, hint, starter, tests, options, correct_answer, explanation, solution_html, sort_order, is_published)
values
  ('cond-01', 'python-de-a-poco', 'condicionales', 'code', '¿Mayor de edad?', 1, '
<p>Pide al usuario su <b>edad</b> (un número entero). Si es <b>menor de 18</b>,
muestra el mensaje <code>Eres menor de edad</code>. Si tiene 18 o más, muestra
<code>Eres mayor de edad</code>.</p>', 'Usá int(input()) para leer la edad como número, después un if/else.', 'edad = int(input("Ingresa tu edad: "))
# Tu código acá:
', '[{"stdin":["15"],"expect":["menor de edad"]},{"stdin":["18"],"expect":["mayor de edad"]},{"stdin":["40"],"expect":["mayor de edad"]}]'::jsonb, '[]'::jsonb, null, null, null, 10, true),
  ('cond-02', 'python-de-a-poco', 'condicionales', 'code', 'Promedio de dos notas', 1, '
<p>Pide <b>dos notas</b> (números, pueden tener decimales), calcula el promedio y
muestra:</p>
<ul>
<li><code>Felicitaciones, vas camino a aprobar</code> si el promedio es ≥ 4.0</li>
<li><code>Atencion, vas camino a reprobar</code> si está entre 3.0 y 4.0</li>
<li><code>Pocas posibilidades de aprobar</code> si es menor a 3.0</li>
</ul>', 'Leé con float(input()). Promedio = (n1+n2)/2. Usá if / elif / else.', 'n1 = float(input("Nota 1: "))
n2 = float(input("Nota 2: "))
# Tu código acá:
', '[{"stdin":["5","6"],"expect":["camino a aprobar"]},{"stdin":["3.5","3.5"],"expect":["camino a reprobar"]},{"stdin":["2","1"],"expect":["pocas posibilidades"]}]'::jsonb, '[]'::jsonb, null, null, null, 20, true),
  ('cond-03', 'python-de-a-poco', 'condicionales', 'code', '¿B divide a A?', 2, '
<p>Pide dos enteros <b>A</b> y <b>B</b>. Si la división <code>A / B</code> es
exacta (el resto es 0), muestra <code>B divide exactamente a A</code>. En caso
contrario, muestra <code>B no divide a A</code>.</p>', 'El resto se obtiene con el operador módulo %. Si A % B == 0, divide exacto.', 'A = int(input("A: "))
B = int(input("B: "))
# Tu código acá:
', '[{"stdin":["10","5"],"expect":["divide exactamente"]},{"stdin":["10","3"],"expect":["no divide"]},{"stdin":["20","4"],"expect":["divide exactamente"]}]'::jsonb, '[]'::jsonb, null, null, null, 30, true),
  ('cond-04', 'python-de-a-poco', 'condicionales', 'code', 'Tres números ordenados', 2, '
<p>Pide <b>tres números</b> y muéstralos ordenados de <b>mayor a menor</b>,
separados por espacios en una sola línea. Ej: para 3, 9, 5 debe imprimir
<code>9 5 3</code>.</p>', 'Podés usar muchos if/else, o crear una lista y usar sorted(lista, reverse=True).', 'a = int(input())
b = int(input())
c = int(input())
# Tu código acá:
', '[{"stdin":["3","9","5"],"expect":["9 5 3"]},{"stdin":["1","2","3"],"expect":["3 2 1"]},{"stdin":["7","7","1"],"expect":["7 7 1"]}]'::jsonb, '[]'::jsonb, null, null, null, 40, true),
  ('cond-05', 'python-de-a-poco', 'condicionales', 'code', 'Sensor de temperatura', 3, '
<p>Un sensor mide la temperatura en <b>grados Fahrenheit</b>. Pide el valor en
Fahrenheit, conviértelo a Celsius con la fórmula:</p>
<pre><code>Celsius = (Fahrenheit - 32) / 1.8</code></pre>
<p>Luego muestra el valor en Celsius y un mensaje:</p>
<ul>
<li><code>Hace frio</code> si Celsius &lt; 15</li>
<li><code>Temperatura agradable</code> si está entre 15 y 25</li>
<li><code>Hace calor</code> si Celsius &gt; 25</li>
</ul>', 'Primero calculá celsius, imprimilo, y después decidí el mensaje con if/elif/else.', 'f = float(input("Temperatura en Fahrenheit: "))
# Tu código acá:
', '[{"stdin":["50"],"expect":["10","frio"]},{"stdin":["68"],"expect":["20","agradable"]},{"stdin":["95"],"expect":["35","calor"]}]'::jsonb, '[]'::jsonb, null, null, null, 50, true),
  ('ciclo-01', 'python-de-a-poco', 'ciclos', 'code', 'Los primeros 10 pares', 1, '
<p>Muestra por pantalla los <b>primeros 10 números pares</b> (empezando del 2),
cada uno en una línea: 2, 4, 6, ... 20.</p>', 'for i in range(1, 11): el par es i*2. O recorré range(2, 21, 2).', '# Tu código acá:
', '[{"stdin":[],"expect":["2","4","6","8","10","12","14","16","18","20"]}]'::jsonb, '[]'::jsonb, null, null, null, 10, true),
  ('ciclo-02', 'python-de-a-poco', 'ciclos', 'code', 'Los primeros N pares', 2, '
<p>Pide un número <b>N</b> al usuario y muestra los <b>primeros N números
pares</b>, uno por línea.</p>', 'for i in range(1, N+1): imprimí i*2.', 'n = int(input("¿Cuántos pares? "))
# Tu código acá:
', '[{"stdin":["3"],"expect":["2","4","6"]},{"stdin":["5"],"expect":["2","4","6","8","10"]}]'::jsonb, '[]'::jsonb, null, null, null, 20, true),
  ('ciclo-03', 'python-de-a-poco', 'ciclos', 'code', 'Del A al B', 2, '
<p>Pide dos enteros <b>A</b> y <b>B</b> y muestra todos los números entre ellos
(ambos incluidos), uno por línea. Si A &lt; B en orden <b>creciente</b>; si
A &gt; B en orden <b>decreciente</b>.</p>', 'Si A<=B usá range(A, B+1). Si A>B usá range(A, B-1, -1).', 'A = int(input("A: "))
B = int(input("B: "))
# Tu código acá:
', '[{"stdin":["1","4"],"expect":["1","2","3","4"]},{"stdin":["3","1"],"expect":["3","2","1"]}]'::jsonb, '[]'::jsonb, null, null, null, 30, true),
  ('ciclo-04', 'python-de-a-poco', 'ciclos', 'code', 'Suma hasta el -1', 2, '
<p>Pide números enteros al usuario, uno por uno, y ve sumándolos. Cuando el
usuario ingresa <b>-1</b>, deja de pedir y muestra la suma total con el formato
<code>Suma: X</code>. El -1 <b>no</b> se suma. Si el primer número es -1, la suma
es 0.</p>', 'Usá while: leé un número, mientras sea distinto de -1 sumá y leé otro.', 'suma = 0
n = int(input("Número (-1 para terminar): "))
# Tu código acá (usá un while):
', '[{"stdin":["5","10","3","-1"],"expect":["Suma: 18"]},{"stdin":["-1"],"expect":["Suma: 0"]},{"stdin":["100","-1"],"expect":["Suma: 100"]}]'::jsonb, '[]'::jsonb, null, null, null, 40, true),
  ('ciclo-05', 'python-de-a-poco', 'ciclos', 'code', 'Factorial', 3, '
<p>Pide un entero <b>n</b> y calcula su <b>factorial</b>:
<code>n! = n × (n-1) × ... × 2 × 1</code>. Muestra <code>Factorial: X</code>.
Recordá que <code>0! = 1</code>.</p>', 'Empezá con resultado=1 y multiplicá por cada i de 1 a n con un for.', 'n = int(input("n: "))
# Tu código acá:
', '[{"stdin":["5"],"expect":["Factorial: 120"]},{"stdin":["0"],"expect":["Factorial: 1"]},{"stdin":["6"],"expect":["Factorial: 720"]}]'::jsonb, '[]'::jsonb, null, null, null, 50, true),
  ('ciclo-06', 'python-de-a-poco', 'ciclos', 'code', '¿Es primo?', 3, '
<p>Pide un entero positivo <b>P</b> y determina si es <b>primo</b> (solo divisible
por 1 y por sí mismo). Muestra <code>Es primo</code> o <code>No es primo</code>.</p>', 'Contá cuántos divisores tiene entre 1 y P. Si tiene exactamente 2, es primo. Ojo: 1 no es primo.', 'P = int(input("P: "))
# Tu código acá:
', '[{"stdin":["7"],"expect":["es primo"]},{"stdin":["10"],"expect":["no es primo"]},{"stdin":["1"],"expect":["no es primo"]},{"stdin":["13"],"expect":["es primo"]}]'::jsonb, '[]'::jsonb, null, null, null, 60, true),
  ('ciclo-07', 'python-de-a-poco', 'ciclos', 'code', 'Número palíndromo', 4, '
<p>Pide un número entero y determina si es <b>palíndromo</b> (se lee igual al
derecho y al revés, ej: 131, 7887). Muestra <code>Es palindromo</code> o
<code>No es palindromo</code>.</p>', 'Convertí el número a texto con str(numero) y comparalo con su reverso texto[::-1].', 'n = input("Número: ")
# Tu código acá:
', '[{"stdin":["131"],"expect":["es palindromo"]},{"stdin":["123"],"expect":["no es palindromo"]},{"stdin":["7887"],"expect":["es palindromo"]}]'::jsonb, '[]'::jsonb, null, null, null, 70, true),
  ('lista-01', 'python-de-a-poco', 'listas', 'code', 'Guardar 5 números', 1, '
<p>Pide al usuario <b>5 números</b>, guárdalos en una lista y al final muestra la
lista completa con <code>print(lista)</code>.</p>', 'Creá una lista vacía []. Con un for de 5 vueltas, leé un número y usá .append().', 'numeros = []
# Tu código acá:
', '[{"stdin":["1","2","3","4","5"],"expect":["[1, 2, 3, 4, 5]"]}]'::jsonb, '[]'::jsonb, null, null, null, 10, true),
  ('lista-02', 'python-de-a-poco', 'listas', 'code', 'Promedio de N números', 2, '
<p>Pide un número <b>N</b>, luego pide N números, guárdalos en una lista, calcula
el <b>promedio</b> y muéstralo con el formato <code>Promedio: X</code>.</p>', 'Sumá todos con sum(lista) y dividí por len(lista). O sumá dentro del for.', 'n = int(input("¿Cuántos números? "))
numeros = []
# Tu código acá:
', '[{"stdin":["3","10","20","30"],"expect":["Promedio: 20"]},{"stdin":["2","4","6"],"expect":["Promedio: 5"]}]'::jsonb, '[]'::jsonb, null, null, null, 20, true),
  ('lista-03', 'python-de-a-poco', 'listas', 'code', '¿Dónde está el número?', 2, '
<p>Tenés esta lista ya creada:</p>
<pre><code>lista = [4, 8, 2, 8, 5, 8, 1]</code></pre>
<p>Pide un número al usuario y muestra <b>todas las posiciones (índices)</b> donde
aparece, una por línea con el formato <code>Posicion: i</code>. Si no aparece,
muestra <code>No se encuentra</code>.</p>', 'Recorré con índice: for i in range(len(lista)). Llevá una bandera de ''encontrado''.', 'lista = [4, 8, 2, 8, 5, 8, 1]
buscado = int(input("Número a buscar: "))
# Tu código acá:
', '[{"stdin":["8"],"expect":["Posicion: 1","Posicion: 3","Posicion: 5"]},{"stdin":["7"],"expect":["no se encuentra"]},{"stdin":["4"],"expect":["Posicion: 0"]}]'::jsonb, '[]'::jsonb, null, null, null, 30, true),
  ('lista-04', 'python-de-a-poco', 'listas', 'code', 'Producto punto', 3, '
<p>Tenés dos listas (vectores) del mismo largo:</p>
<pre><code>a = [2, 9, 3, 10, 10]
b = [3, 7, 5, 1, 6]</code></pre>
<p>Calcula el <b>producto punto</b>: suma de los productos elemento a elemento
(<code>a[0]*b[0] + a[1]*b[1] + ...</code>) y muestra
<code>Producto punto: X</code>. (Para el ejemplo da 154.)</p>', 'Acumulá en una variable: for i in range(len(a)): suma += a[i]*b[i].', 'a = [2, 9, 3, 10, 10]
b = [3, 7, 5, 1, 6]
# Tu código acá:
', '[{"stdin":[],"expect":["Producto punto: 154"]}]'::jsonb, '[]'::jsonb, null, null, null, 40, true),
  ('lista-05', 'python-de-a-poco', 'listas', 'code', 'Contar frecuencias', 4, '
<p>Tenés esta lista de números entre 0 y 5:</p>
<pre><code>lista = [2, 1, 2, 1, 3, 2, 2, 5, 3, 2, 3, 0, 1, 2, 3]</code></pre>
<p>Muestra, para cada número del 0 al 5, cuántas veces aparece, con el formato
<code>Numero N: veces</code> (una línea por número, incluso si aparece 0 veces).</p>', 'for n in range(6): contá cuántas veces n está en la lista con lista.count(n).', 'lista = [2, 1, 2, 1, 3, 2, 2, 5, 3, 2, 3, 0, 1, 2, 3]
# Tu código acá:
', '[{"stdin":[],"expect":["Numero 0: 1","Numero 1: 3","Numero 2: 6","Numero 3: 4","Numero 4: 0","Numero 5: 1"]}]'::jsonb, '[]'::jsonb, null, null, null, 50, true),
  ('lista-06', 'python-de-a-poco', 'listas', 'code', 'Ordenar con Bubble Sort', 5, '
<p>Tenés esta lista desordenada:</p>
<pre><code>lista = [5, 1, 4, 2, 8]</code></pre>
<p>Ordénala de <b>menor a mayor</b> implementando vos mismo el algoritmo
<b>bubble sort</b> (¡sin usar <code>sorted()</code> ni <code>.sort()</code>!) y
muestra la lista ordenada con <code>print(lista)</code>.</p>', 'Dos for anidados: comparás pares vecinos lista[j] y lista[j+1], si están al revés los intercambiás.', 'lista = [5, 1, 4, 2, 8]
# Tu código acá (bubble sort):
', '[{"stdin":[],"expect":["[1, 2, 4, 5, 8]"]}]'::jsonb, '[]'::jsonb, null, null, null, 60, true),
  ('anid-01', 'python-de-a-poco', 'anidados', 'code', 'Rectángulo de #', 1, '
<p>Pide al usuario el número de <b>filas</b> y de <b>columnas</b> y dibuja un
rectángulo de símbolos <code>#</code> de ese tamaño. Para 3 filas y 5 columnas:</p>
<pre><code>#####
#####
#####</code></pre>', 'Ciclo externo = filas, interno = columnas. Usá print("#", end="") y un print("") al cerrar cada fila.', 'filas = int(input("Filas: "))
columnas = int(input("Columnas: "))
# Tu código acá:
', '[{"stdin":["3","5"],"expect":["#####","#####","#####"]},{"stdin":["2","2"],"expect":["##","##"]}]'::jsonb, '[]'::jsonb, null, null, null, 10, true),
  ('anid-02', 'python-de-a-poco', 'anidados', 'code', 'Triángulo creciente', 2, '
<p>Pide un número <b>N</b> y dibuja un triángulo donde la fila <code>i</code> tiene
<code>i</code> asteriscos. Para N = 4:</p>
<pre><code>*
**
***
****</code></pre>', 'La fila i tiene i asteriscos: el ciclo interno debe ir de 1 a i.', 'n = int(input("N: "))
# Tu código acá:
', '[{"stdin":["3"],"expect":["*","**","***"]},{"stdin":["4"],"expect":["*","**","***","****"]}]'::jsonb, '[]'::jsonb, null, null, null, 20, true),
  ('anid-03', 'python-de-a-poco', 'anidados', 'code', 'Escalera de asteriscos', 2, '
<p>Pide el número de <b>escalones</b> y dibújalos: el escalón <code>i</code> tiene
<code>2 × i</code> asteriscos. Para 4 escalones:</p>
<pre><code>**
****
******
********</code></pre>', 'Para el escalón i (de 1 a escalones), imprimí 2*i asteriscos con end=''''.', 'escalones = int(input("Escalones: "))
# Tu código acá:
', '[{"stdin":["4"],"expect":["**","****","******","********"]},{"stdin":["2"],"expect":["**","****"]}]'::jsonb, '[]'::jsonb, null, null, null, 30, true),
  ('anid-04', 'python-de-a-poco', 'anidados', 'code', 'Patrón de números', 3, '
<p>Pide un número <b>N</b> y muestra este patrón (la fila <code>i</code> lista los
números de 1 a <code>i</code>, separados por un espacio). Para N = 3:</p>
<pre><code>1
1 2
1 2 3</code></pre>', 'En la fila i, recorré j de 1 a i e imprimí print(j, end=" "). Cerrá con print("").', 'n = int(input("N: "))
# Tu código acá:
', '[{"stdin":["3"],"expect":["1","1 2","1 2 3"]},{"stdin":["4"],"expect":["1","1 2","1 2 3","1 2 3 4"]}]'::jsonb, '[]'::jsonb, null, null, null, 40, true),
  ('anid-05', 'python-de-a-poco', 'anidados', 'code', 'Tabla de f(x) = suma de k²', 3, '
<p>Pide un valor <b>inferior</b> y uno <b>superior</b> de x. Para cada x en ese
rango (ambos incluidos), calcula <code>f(x) = 0² + 1² + ... + x²</code> y muestra
una línea <code>x f(x)</code>. Ejemplo con inferior 2 y superior 5:</p>
<pre><code>2 5
3 14
4 30
5 55</code></pre>', 'Ciclo externo recorre x; ciclo interno suma k*k para k de 0 a x. Imprimí print(x, suma).', 'inferior = int(input("Inferior: "))
superior = int(input("Superior: "))
# Tu código acá:
', '[{"stdin":["2","5"],"expect":["2 5","3 14","4 30","5 55"]},{"stdin":["0","1"],"expect":["0 0","1 1"]}]'::jsonb, '[]'::jsonb, null, null, null, 50, true),
  ('anid-06', 'python-de-a-poco', 'anidados', 'code', 'Suma de factoriales', 4, '
<p>Pide un entero <b>N</b> y calcula la serie
<code>1! + 2! + 3! + ... + N!</code>. Muestra <code>Suma: X</code>.
(Para N = 3 da 1 + 2 + 6 = 9.)</p>', 'Ciclo externo i de 1 a N; ciclo interno calcula i! multiplicando de 1 a i; acumulá esos factoriales.', 'n = int(input("N: "))
# Tu código acá:
', '[{"stdin":["3"],"expect":["Suma: 9"]},{"stdin":["4"],"expect":["Suma: 33"]},{"stdin":["1"],"expect":["Suma: 1"]}]'::jsonb, '[]'::jsonb, null, null, null, 60, true),
  ('mat-01', 'python-de-a-poco', 'matrices', 'code', 'Dimensiones de la matriz', 1, '
<p>Tenés esta matriz ya creada:</p>
<pre><code>M = [[1, 2, 3], [4, 5, 6]]</code></pre>
<p>Muestra cuántas filas y columnas tiene, con el formato:</p>
<pre><code>Filas: 2
Columnas: 3</code></pre>', 'len(M) son las filas; len(M[0]) son las columnas de la primera fila.', 'M = [[1, 2, 3], [4, 5, 6]]
# Tu código acá:
', '[{"stdin":[],"expect":["Filas: 2","Columnas: 3"]}]'::jsonb, '[]'::jsonb, null, null, null, 10, true),
  ('mat-02', 'python-de-a-poco', 'matrices', 'code', 'Suma de todos los elementos', 2, '
<p>Suma <b>todos</b> los elementos de esta matriz y muestra <code>Suma: X</code>:</p>
<pre><code>M = [[1, 2], [3, 4], [5, 6]]</code></pre>
<p>(El resultado es 21.)</p>', 'Acumulá en una variable recorriendo con dos for: suma = suma + M[i][j].', 'M = [[1, 2], [3, 4], [5, 6]]
# Tu código acá:
', '[{"stdin":[],"expect":["Suma: 21"]}]'::jsonb, '[]'::jsonb, null, null, null, 20, true),
  ('mat-03', 'python-de-a-poco', 'matrices', 'code', 'Promedio por fila', 2, '
<p>Para esta matriz de notas, calcula el <b>promedio de cada fila</b> y muéstralo
con el formato <code>Fila i promedio: X</code> (una línea por fila):</p>
<pre><code>notas = [[7, 6, 5], [4, 5, 6], [1, 2, 3]]</code></pre>
<p>Por ejemplo, la primera fila debe mostrar <code>Fila 0 promedio: 6.0</code>.</p>', 'Para cada fila i (que es la lista notas[i]) usá sum(notas[i]) / len(notas[i]). Imprimí con print("Fila", i, "promedio:", promedio).', 'notas = [[7, 6, 5], [4, 5, 6], [1, 2, 3]]
# Tu código acá:
', '[{"stdin":[],"expect":["Fila 0 promedio: 6.0","Fila 1 promedio: 5.0","Fila 2 promedio: 2.0"]}]'::jsonb, '[]'::jsonb, null, null, null, 30, true),
  ('mat-04', 'python-de-a-poco', 'matrices', 'code', 'El número mayor', 3, '
<p>Encuentra el <b>elemento más grande</b> de esta matriz y muéstralo como
<code>Maximo: X</code>:</p>
<pre><code>M = [[3, 8, 1], [9, 2, 7]]</code></pre>', 'Guardá un ''mayor'' con el primer elemento y comparalo con cada M[i][j] recorriendo la matriz.', 'M = [[3, 8, 1], [9, 2, 7]]
# Tu código acá:
', '[{"stdin":[],"expect":["Maximo: 9"]}]'::jsonb, '[]'::jsonb, null, null, null, 40, true),
  ('mat-05', 'python-de-a-poco', 'matrices', 'code', 'Suma de la diagonal', 3, '
<p>En esta matriz <b>cuadrada</b>, suma la <b>diagonal principal</b> (los elementos
<code>M[0][0]</code>, <code>M[1][1]</code>, <code>M[2][2]</code>) y muestra
<code>Diagonal: X</code>:</p>
<pre><code>M = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]</code></pre>
<p>(La diagonal suma 1 + 5 + 9 = 15.)</p>', 'La diagonal son los M[i][i]: un solo for con range(len(M)) y sumás M[i][i].', 'M = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
# Tu código acá:
', '[{"stdin":[],"expect":["Diagonal: 15"]}]'::jsonb, '[]'::jsonb, null, null, null, 50, true),
  ('mat-06', 'python-de-a-poco', 'matrices', 'code', 'Matriz identidad', 4, '
<p>Pide un entero <b>N</b> y construí la <b>matriz identidad</b> de N×N (1 en la
diagonal, 0 en el resto), guardándola en una lista de listas. Muéstrala con
<code>print(M)</code>. Para N = 3:</p>
<pre><code>[[1, 0, 0], [0, 1, 0], [0, 0, 1]]</code></pre>', 'Por cada fila i creá una lista de N ceros y poné un 1 en la posición i (fila[i] = 1); luego append a M.', 'n = int(input("N: "))
M = []
# Tu código acá:
', '[{"stdin":["3"],"expect":["[[1, 0, 0], [0, 1, 0], [0, 0, 1]]"]},{"stdin":["2"],"expect":["[[1, 0], [0, 1]]"]}]'::jsonb, '[]'::jsonb, null, null, null, 60, true)
on conflict (id) do update set
  course_id = excluded.course_id,
  module_id = excluded.module_id,
  type = excluded.type,
  title = excluded.title,
  level = excluded.level,
  statement_html = excluded.statement_html,
  hint = excluded.hint,
  starter = excluded.starter,
  tests = excluded.tests,
  options = excluded.options,
  correct_answer = excluded.correct_answer,
  explanation = excluded.explanation,
  solution_html = excluded.solution_html,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
