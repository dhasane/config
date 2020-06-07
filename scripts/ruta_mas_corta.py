

def minl( lista ):
    primer = True
    m = 0
    pos = 0
    for p, l in enumerate(lista):
        if l is None:
            continue

        if primer:
            m = l
            pos = p
            primer = False
        elif l < m:
            m = l
            pos = p

    return m, pos


def prt( mat ):
    for m in mat:
        print(m)

def arbol_minima_expancion( mat, nom, pos ):
    prt( mat )

    #  nueva_matriz = mat[:pos] + mat[pos + 1:]
    #  list(map(lambda x: x.pop(pos), nueva_matriz) )
    ll = mat[ pos ]

    mat = mat[:pos] + mat[pos + 1:]
    list(map(lambda x: x.pop(pos), mat ) )

    #  print()
    #  prt( mat )
    #  print( minl(ll) )

    min_pos = minl( ll )[1]

    #  print( min_pos , " > " , pos)
    if min_pos > pos:
        min_pos -= 1

    nombre = nom[pos]
    print()
    print()
    print( pos, " -> ", nombre )
    print( mat[ min_pos ] )
    print( nom )

    # TODO en las ultimas iteraciones se enloquece
    nom.pop(pos)
    ret = [( nombre, nom[min_pos] )]

    if len(mat) == 1:
        return ret

    return ret + arbol_minima_expancion( mat, nom, min_pos )


mat = [ [ None , 13 , 20, 10,  None,  None,  None, None, None, None ],
        [ 13,   None,  2,  None, 16, 15, 18, None, None, None ],
        [ 20,   2,  None,  8, 13, 17, 11, None, None, None ],
        [ 10,   None,  8,  None, 14,  6,  4, None, None, None ],
        [  None,  16, 13, 14,  None,  2,  None, 2,20,40 ],
        [  None,  15, 17,  6,  2,  None,  2, 4,10, None ],
        [  None,  18, 11,  4,  None,  2,  None,15, 5, None ],
        [  None,   None,  None,  None,  2,  4, 15, None,15, 7 ],
        [  None,   None,  None,  None, 20, 10,  5,15, None,20 ],
        [  None,   None,  None,  None, 40,  None,  None, 7,20, None ]]

nombres = [ 'o', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i' ]
ret = arbol_minima_expancion(mat, nombres, 0 )
prt(ret)


