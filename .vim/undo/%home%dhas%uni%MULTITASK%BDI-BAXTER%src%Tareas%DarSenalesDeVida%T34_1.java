Vim�UnDo� o�i�U�X�+@s���9��7hTZQ���a�j�   T                                   ]y�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             ]y��     �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ]y��     �                   �               5�_�                    >       ����                                                                                                                                                                                                                                                                                                                            F           >          V       ]y�     �   =   >       	   Y            /*Acción 0: Asumir Rol: Enviar a Baxter el Valor de Control y Aceptación.*/   k            System.out.println("Acción 0: Asumir Rol: Enviar a Baxter el Valor de Control y Aceptación");   @            double control =  believes.getB4().getControl()*400;   E            double aceptacion = believes.getB4().getAceptacion()*400;   8            System.out.println("control@T34: "+control);   ?            System.out.println("aceptación@T34: "+aceptacion);   x            Publisher pubT34A0 = new Publisher("emociones_baxter", "geometry_msgs/Twist", believes.getBridge());           �            pubT34A0.publishJsonMsg("{\"linear\":{\"x\":"+(int)control+",\"y\":"+(int)aceptacion+",\"z\":1.0}}");//x:posicion{0,400} de x, y:posicion de y {0,400}, z:0 transicion, 1, hablar, 2 guiño    5�_�                             ����                                                                                                                                                                                                                                                                                                                            >           >          V       ]y�    �   Q   S              �   /   1          +    public void executeTask(Believes blvs) �   &   (                  return completedTask; �                V	* @return verdadero si la tarea se completo en su totalidad, falso en caso contrario	5��