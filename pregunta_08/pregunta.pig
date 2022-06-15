/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- cargo los datos
lines = LOAD 'data.tsv' AS (letra:CHARARRAY, letrasMinusculas:BAG{t:TUPLE(a:CHARARRAY)}, claves:[]);

extraigocolumna = FOREACH lines GENERATE FLATTEN(letrasMinusculas) AS letra, FLATTEN(KEYSET(claves)) AS tres;

grp = GROUP extraigocolumna by (letra, tres);

--Describe grp;

cuenta = FOREACH grp GENERATE group, COUNT(extraigocolumna);

STORE cuenta INTO 'output' USING PigStorage(',');
