import processing.serial.*;
import processing.sound.*;
import java.util.Arrays;

Serial arduinoPort;
String value;
int posy, score1 = 0, score2 = 0, posxBall, posyBall, paddlexSize = 10, paddleySize = 60, cont = 0, paddleDesp;
boolean goal;
float ballDespy, ballDespx = -4;


void setup() {
  size(800, 560);
  setBackground();
  String portName = Serial.list()[1];
  arduinoPort = new Serial(this, portName, 9600);
  posy = 270;
  posxBall = 395;
  posyBall = 295;
  ballDespy = 0;
  ballDespx = 4;
}

void setBackground() {
  background(0);
  float shift = 0; 
  stroke(255);
  for (int i = 0; i < 8; i++) {
    shift = height/30;
    line(width / 2, i*height / 10 + i*shift, width / 2, (i+1)*height / 10 - height / 30 + i*shift);
  }
}

void setPaddle(int y) {
  rect(15, y, paddlexSize, paddleySize);
}

void setSecondPaddle() {
  posy = getSensorDistance();
  rect(width-25, posy, paddlexSize, paddleySize);
}

void setScores() {
  textSize(25);
  text(Integer.toString(score1), 300, 40);
  text(Integer.toString(score2), 480, 40);
}

void setBall() {
  rect(posxBall, posyBall, 10, 10);
  posxBall += ballDespx;
  posyBall += ballDespy;
}

void setGoal() {
  textSize(60);
  goal = true;
  cont = 255;
}

void checkColissions() {
  if (posyBall < 0 || posyBall > height) {
    ballDespy *= -1;
  }
  if (ballDespx < 0 && posxBall - 25 < 0 && posyBall - mouseY < 30 && posyBall - mouseY > -30) {
    ballDespx *= -1.05;
    ballDespy = (posyBall - mouseY)* 0.2;
  } else if (ballDespx > 0 && posxBall + 30 > width && posyBall - posy > -10 && posyBall - posy < 60) {
    ballDespx *= -1.05;
    ballDespy = (posyBall - (posy+25)) * 0.2;
  }
  if (posxBall < 0) {
    score2++;    
    setGoal();
  } else if (posxBall > width-10) {
    score1++;
    setGoal();
  }
}

void setGoalText() {
  if (cont > 0) {
    text("GOOOooooOOOOOOL!!!!", 50, 200);
    cont--;
  } else {
    goal = false;
    posy = 270;
    posxBall = 395;
    posyBall = 295;
    ballDespy = 0;
    ballDespx = 4;
  }
}

void keyPressed() {
  if (keyCode == UP) paddleDesp = -6;
  else if (keyCode == DOWN) paddleDesp = 6;
}

void keyReleased() {
  paddleDesp = 0;
}

void draw() { 

  if (!goal) {
    setBackground();
    setPaddle(mouseY-30);
    setSecondPaddle();
    setScores();
    setBall();
    checkColissions();
  } else {
    setGoalText();
  }
}


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
