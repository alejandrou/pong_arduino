<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Tabla de contenidos</summary>
  <ol>
    <li>
      <a href="#Autor">Autores</a>
    </li>
    <li>
      <a href="#Trabajo realizado">Trabajo realizado</a>
    </li>
    <li><a href="#decisiones-adoptadas">Decisiones adoptadas</a></li>
    <li><a href="#referencias">Referencias</a></li>
    <li><a href="#herramientas">Herramientas</a></li>
    <li><a href="#resultado">Resultado</a></li>
  </ol>
</details>




## Autor

El autor de este proyecto son los estudiantes Carlos Eduardo Pacichana Bastidas y Alejandro Daniel Herrera Cárdenes para la asignatura Creando Interfaces de Usuario (CIU) para el profesor Modesto Fernando Castrillón Santana y Jose Daniel Hernández Sosa. 


## Trabajo realizado

El trabajo se basa en hacer un pong en el programa Processing usando el sensor de movimiento de Arduino para jugar.

## Decisiones adoptadas

Las mayores decisiones tomadas y las que mas pruebas requirieron fueron el método para que recogiera el movimiento de la mano la pala del Pong.

* Este método detecta cuando el movimiento de la mano para mover la pala
  ```
  int getSensorDistance() {
  
  int nextPosY = posy;
    if (arduinoPort.available() > 0 && (value = arduinoPort.readStringUntil('\n')) != null) {
      value = value.trim();
      int currentRead;
      try {
        currentRead = Integer.min(Integer.parseInt(value), 500);
      } 
      catch (NumberFormatException e) {
        currentRead = posy;
      }
      if (abs(posy - currentRead) > 10) nextPosY = currentRead;
    }
    return nextPosY;
  }
 <p align="center"><img src="images/gameover.png" alt="gamePlay" width="300" height="300"></br>Pantalla final</p>
 


## Referencias

Para ayudarme en la realización de esta aplicación usé básicamente la API que te proporciona [Processing](https://www.processing.org/).

## Herramientas

* [Processing](https://www.processing.org/)




## Resultado

Añado un GIF con el resultado de la aplicación moviendose ambas paletas y rebotando la pelota en ellas.

  * Resultado
  <p align="center"><img src="images/pong.gif" alt="gamePlay" width="300" height="300"></br>Gif resultado final</p>
