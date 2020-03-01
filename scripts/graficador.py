import matplotlib.pyplot as mtpl
import numpy as np
import sys

def prt_coordenadas(crds):
    """ imprimir un diccionario de coordenadas """
    i = 1
    print(crds['header'][0])
    for cnt in crds['contenido']:
        print(i, "  ", crds['header'][i])
        for cont in cnt:
            print("\t", cont)
        i += 1

def leer_archivo(arc):
    """ carga archivos, retorna una lista de header y contenido,
    siendo 'contenido' una lista de lineas """
    file = open(arc, "r")

    leer = False
    ret = []
    tam = 0
    contenido = []

    for line in file.readlines():

        if "+---" in line:
            leer = False
            ret += [
                {
                    "header" : header,
                    "contenido" : contenido
                }
            ]

        if leer:
            # quitar espacios, finales de linea y separar por |
            sep = " ".join(line.replace("\n", "").split()).split("|")
            if "--" not in sep[0]:
                if tam == 0:
                    header = sep
                else:
                    contenido += [sep]
                tam += 1

        if "---+" in line:
            tam = 0
            contenido = []
            leer = True
    return ret

def graf_a_coordenadas(grf):
    """ convierte los datos a un diccionario 'coordenadas', separando por columna """
    coordenadas = [[] for i in range(0, len(grf['contenido'][0])-1)]
    for cont in grf['contenido']:
        for i in range(1, len(cont)):
            val = cont[i].split("+-")
            coordenadas[i-1] += [{
                'x': cont[0],
                'y': val[0],
                'error': val[1] if len(val) > 1 else 0
            }]
    return {
        "header" : grf['header'],
        "contenido" : coordenadas
    }

def grafs_a_coordenadas(grfs):
    """ para convertir una lista de datos a coordenadas """
    coords = []
    for grf in grfs:
        coords += [graf_a_coordenadas(grf)]
    return coords


def graficar(crds):
    """ grafica con base a los diccionarios de coordenadas que se le pasen """
    mtpl.xlabel("hola")
    i = 1

    #  print(crds['header'][0])
    for cnt in crds['contenido']:
        nombre = crds['header'][0] + '-' + crds['header'][i]

        fig = mtpl.figure()

        mtpl.xlabel(crds['header'][0])
        mtpl.ylabel(crds['header'][i])
        mtpl.title(nombre)

        #  x = np.array(list(map(lambda c: c['x'], cnt)))
        #  y = np.array(list(map(lambda c: c['y'], cnt)))
        #
        #  yerr = np.array(list(map(lambda c: float(c['error']), cnt)))
        x = list(map(lambda c: float(c['x']), cnt))
        y = list(map(lambda c: float(c['y']), cnt))

        yerr = list(map(lambda c: float(c['error']), cnt))

        mtpl.errorbar(x, y, yerr=yerr)

        mtpl.scatter(x, y)

        fig.savefig(nombre + '.png')
        i += 1

for grf in grafs_a_coordenadas(leer_archivo(sys.argv[1])):
    graficar(grf)
