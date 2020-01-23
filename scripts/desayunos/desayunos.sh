#!/bin/sh

# abre con el browser predeterminado una pagina aleatoria y suelta al
# proceso de la terminal

( $BROWSER "$( shuf -n 1 ./desayunos )" &> /dev/null & )
