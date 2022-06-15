/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (letra:chararray, fecha:chararray, numero:int);

columna = FOREACH lines GENERATE numero;

unicos = DISTINCT columna;

s = LIMIT unicos 5;

STORE s INTO 'output' USING PigStorage(',');
