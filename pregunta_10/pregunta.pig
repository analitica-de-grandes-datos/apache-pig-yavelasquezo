/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
---asigno los datos 
lines = LOAD 'data.csv' USING PigStorage(',') AS (numero:int, nombre:CHARARRAY, apellido:CHARARRAY, fecha:CHARARRAY, color:CHARARRAY, num:int);

columna = FOREACH lines GENERATE apellido, COUNT(TOKENIZE(REPLACE(apellido,'',' '))) as letter;

orden = ORDER columna BY letter desc, apellido asc;

s = LIMIT orden 5;

-- saco archivo al local
STORE s INTO 'output' USING PigStorage(',');
