/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

-- cargo los datos
lines = LOAD 'data.csv' USING PigStorage(',') AS (numero:int, nombre:CHARARRAY, apellido:CHARARRAY, fecha:CHARARRAY, color:CHARARRAY, num:int);

selectcolor = FOREACH lines GENERATE color;

bcolor = FILTER selectcolor BY NOT ($0 matches '.*b.*');

--dump selectcolor;

-- escribe el archivo de salida en el sistema local
STORE bcolor INTO 'output';
