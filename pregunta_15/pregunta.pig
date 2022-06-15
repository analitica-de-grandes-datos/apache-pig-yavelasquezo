/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
-- cargo los datos
lines = LOAD 'data.csv' USING PigStorage(',') AS (numero:int, nombre:CHARARRAY, apellido:CHARARRAY, fecha:CHARARRAY, color:CHARARRAY, num:int);

selectcolor = FOREACH lines GENERATE nombre, color;

--describe selectcolor; 

bcolor = FILTER selectcolor BY ($0 matches '.*Z.*') AND ($1 matches '.*blue.*');

--dump bcolor;

-- escribe el archivo de salida en el sistema local
STORE bcolor INTO 'output' USING PigStorage(' ');
