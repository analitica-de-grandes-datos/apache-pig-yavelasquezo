/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
-- carga de datos desde la carpeta local
-- lines = LOAD 'data.tsv' AS (line:CHARARRAY);

lines = LOAD 'data.tsv' AS (letra:chararray, fecha:chararray, numero:int);

-- ordenar
ordered_data = ORDER lines BY letra, numero asc;


-- escribe el archivo de salida en el sistema local
STORE ordered_data INTO 'output' USING PigStorage(',');
