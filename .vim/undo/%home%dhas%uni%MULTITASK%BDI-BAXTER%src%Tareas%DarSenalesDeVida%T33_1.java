Vim�UnDo� (��	Ɂ�ť���n�.;�u�P~b�^L���c   [                                  ]y�-    _�                             ����                                                                                                                                                                                                                                                                                                                                                             ]y�     �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ]y�     �                   �               5�_�                    >        ����                                                                                                                                                                                                                                                                                                                            G           >           V        ]y�+     �   =   >       
       Y            /*Acción 0: Asumir Rol: Enviar a Baxter el Valor de Control y Aceptación.*/   k            System.out.println("Acción 0: Asumir Rol: Enviar a Baxter el Valor de Control y Aceptación");   @            double control =  believes.getB4().getControl()*400;   E            double aceptacion = believes.getB4().getAceptacion()*400;   8            System.out.println("control@T33: "+control);   ?            System.out.println("aceptación@T33: "+aceptacion);   x            Publisher pubT33A0 = new Publisher("emociones_baxter", "geometry_msgs/Twist", believes.getBridge());           �            pubT33A0.publishJsonMsg("{\"linear\":{\"x\":"+(int)control+",\"y\":"+(int)aceptacion+",\"z\":2.0}}");//x:posicion{0,400} de x, y:posicion de y {0,400}, z:0 transicion, 1, hablar, 2 guiño    5�_�                     >       ����                                                                                                                                                                                                                                                                                                                            >           >           V        ]y�,    �   X   Z              �   D   F          �            Publisher pubT31A1 = new Publisher("/robot/head/command_head_pan", "baxter_core_msgs/HeadPanCommand", believes.getBridge());        �   =   ?                      �   0   2          +    public void executeTask(Believes blvs) �   '   )                  return completedTask; �                 V	* @return verdadero si la tarea se completo en su totalidad, falso en caso contrario	�                    �   =   @   Z      \            /*Acción 1: Llamar función: Mover_Pantalla_Eje_Z_de_Derecha_Hacia_Izquierda.*/5��