Vim�UnDo� �6�]�`��[��Ύ�C�H��%��f:a�ԡ�   �                                   ]y��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             ]y��     �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ]y��     �                 �              5�_�                   c        ����                                                                                                                                                                                                                                                                                                                            c   I       �   [       V   [    ]y߶     �   b   c           J            /*Acción 3: Llamar función: retroceder_Un_Estado_Problema.*/   \            System.out.println("Acción 3: Llamar función: retroceder_Un_Estado_Problema");   N            List <Node> rutaParaGuiarAlNino=believes.getB6().getCaminoIdeal();   A            believes.getB6().setCaminoIdeal(rutaParaGuiarAlNino);   9            for(int i=0;i<rutaParaGuiarAlNino.size();i++)               {   ^                believes.getB2().getNodosAvanzadosPorAgente().add(rutaParaGuiarAlNino.get(i));               }               /**/   T            //System.out.println("Ruta para guiar al niño: "+ rutaParaGuiarAlNino);   ;            int cantidadNodos = rutaParaGuiarAlNino.size();   D            System.out.println("Cantidad de nodos: "+cantidadNodos);   T            int n=1;//la cantidad de pasos que queremos que baxter le ayude al niño               /*02082018*/               if(cantidadNodos>n)               {                   /*original*/   &                for(int i=0; i< n;i++)                   {   N                    String nodoInicial= rutaParaGuiarAlNino.get(i).toString();   N                    String nodoFinal= rutaParaGuiarAlNino.get(i+1).toString();   �                    listaPickAndPlace=pickAndPlace(transformarNodoAArray(nodoInicial), transformarNodoAArray(nodoFinal));                                   }                   /*original*/               }               else               {   �                listaPickAndPlace=pickAndPlace(transformarNodoAArray(estadoActual.toString()), transformarNodoAArray(rutaParaGuiarAlNino.get(0).toString()));                 }               /*02082018*/   V            System.out.println("lista pick and place: "+listaPickAndPlace.toString());   �            PickAndPlaceJohn(listaPickAndPlace.get(0), listaPickAndPlace.get(1), listaPickAndPlace.get(2), listaPickAndPlace.get(3));5�_�                    b        ����                                                                                                                                                                                                                                                                                                                            |          b           V       ]y��     �   a   b                  8            /*Acción 1: Robot dice: Déjame ayudarte!*/   K            System.out.println("Acción 1: Robot dice: Déjame ayudarte!");   U            PlaySounds sonidoT27A1 = new PlaySounds("res\\SonidosAgente\\T27A1.mp3");               sonidoT27A1.play();                  f            believes.getBridge().subscribe(SubscriptionRequestMsg.generate("/Termine_baxter_posicion")   7                            .setType("std_msgs/String")   /                            .setThrottleRate(1)   /                            .setQueueLength(1),   4                            new RosListenDelegate()                                {   T                                public void receive(JsonNode data, String stringRep)   !                                {   7                                    if(!completedTask){                                       System.out.println("ACCIÓN 4: Robot dice \"Terminé, ahora puedes continuar!\"");            i                                    PlaySounds sonido = new PlaySounds("res\\SonidosAgente\\T13A10.mp3");   2                                    sonido.play();   %                                    }       �                                    believes.getB1().setAgenteCorrigeUltimoMovimiento(believes.getB1().getAgenteCorrigeUltimoMovimiento()+1);   L                                    believes.setBaxterSeEstaMoviendo(false);   7                                    completedTask=true;   !                                }                               }                               );5�_�                     #        ����                                                                                                                                                                                                                                                                                                                            b          b           V       ]y��    �   �   �              �   �   �              �   �   �              �   �   �          +            catch (InterruptedException e) �   �   �                      try �   �   �          E        AgenteBaxterBelieves believes = agenteBaxter.getBelieves();  �   �   �              �   �   �                  �   �   �              �   z   |          :        for (int i = 0; i < ArrayNodoInicial.length; i++) �   x   z                  �   w   y                  �   v   x                  �   h   j              �   ]   _          x            Publisher pubT27A0 = new Publisher("emociones_baxter", "geometry_msgs/Twist", believes.getBridge());        �   C   E          G           believes.getB2().getNodosAvanzadosPorAprendiz().size()>4 && �   B   D          Q        if(believes.getB6().getEstadoActual()!=null && believes.puedeEntrar() && �   ?   A          +    public void executeTask(Believes blvs) �   -   /          V	* @return verdadero si la tarea se completo en su totalidad, falso en caso contrario	�   (   *              �   "   $              5�_�                   c        ����                                                                                                                                                                                                                                                                                                                            c          x   g       V   g    ]y�     �   b   m        5�_�                     c        ����                                                                                                                                                                                                                                                                                                                            c          c   g       V   g    ]y�     �   b   y        5��