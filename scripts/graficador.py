#!/bin/python3

import sys
import matplotlib.pyplot as plt
import numpy as np

def prt_coordenadas(crds):
    """ imprimir un diccionario de coordenadas """
    i = 1
    print(crds['header'][0])
    for cnt in crds['contenido']:
        print(i, "  ", crds['header'][i])
        for cont in cnt:
            print("\t", cont)
        i += 1

# probablemente podria cargar directamente a "coordenadas", pero como que ya asi se quedo :v
def leer_archivo(arc):
    """ carga archivos, retorna una lista de tablas con 'header' y 'contenido',
    siendo 'contenido' una lista de lineas """
    file = open(arc, "r")

    leer = False
    tablas = []
    tam = 0
    lineas = []

    for line in file.readlines():

        if "+---" in line:
            leer = False
            # guarda la nueva tabla
            tablas += [
                {
                    "header" : header,
                    "contenido" : lineas
                }
            ]

        if leer:
            # quitar espacios, finales de linea y separar por |
            sep = " ".join(line.replace("\n", "").split()).split("|")
            if "--" not in sep[0]:
                if tam == 0:
                    header = sep
                else:
                    lineas += [sep]
                tam += 1

        if "---+" in line:
            tam = 0
            lineas = []
            leer = True
    return tablas

def graf_a_coordenadas(grf):
    """ convierte los datos a un diccionario 'coordenadas', separando por columna
        este diccionario tiene x, y, errorx, errory
    """
    coordenadas = [[] for i in range(0, len(grf['contenido'][0])-1)]
    for cont in grf['contenido']:
        valx = cont[0].split("+-")
        for i in range(1, len(cont)):
            valy = cont[i].split("+-")
            coordenadas[i-1] += [{
                'x': valx[0],
                'y': valy[0],
                'errorx': valx[1] if len(valx) > 1 else 0,
                'errory': valy[1] if len(valy) > 1 else 0
            }]
    return {
        "header" : grf['header'],
        "contenido" : coordenadas
    }

def tablas_a_coordenadas(grfs):
    """ para convertir una lista de datos a coordenadas """
    coords = []
    for grf in grfs:
        coords += [graf_a_coordenadas(grf)]
    return coords


def graficar(crds):
    """ grafica con base a los diccionarios de coordenadas que se le pasen """
    # para conseguir la columna entera
    def get(pos, arr):
        return list(map(lambda c: float(c[pos]), arr))

    i = 1
    plt.rcParams.update({'font.size':22})
    for cnt in crds['contenido']:
        nombre = crds['header'][0] + '-' + crds['header'][i]

        fig = plt.figure(
            figsize=(22, 16),
            dpi=80
        )
        # creo que falta especificar la escala

        plt.xlabel(crds['header'][0])
        plt.ylabel(crds['header'][i])
        plt.title(nombre)


        #  mtpl.ticklabel_format(style='sci', axis='x', scilimits=(0, 0))

        x_values = get('x', cnt)
        y_values = get('y', cnt)

        yerr = get('errory', cnt)
        xerr = get('errorx', cnt)

        # barras de error
        plt.errorbar(
            x_values, y_values, xerr=xerr, yerr=yerr,
            color='red',
            linestyle="None",
            zorder=10
        )
        # puntos
        plt.scatter(
            x_values, y_values,
            s=50,
            zorder=5
        )
        # lineas
        plt.plot(
            x_values, y_values,
            zorder=0,
            color="black"
        )

        fig.savefig(nombre + '.png')
        i += 1

for grf in tablas_a_coordenadas(leer_archivo(sys.argv[1])):
    prt_coordenadas(grf)
    graficar(grf)
