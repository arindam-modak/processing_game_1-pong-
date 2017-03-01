import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
AudioSnippet flush;
AudioSnippet bg;
Minim minim;
Minim minim2;
float x = 200;
float y = 70;
int num = 1;  // no. of balls
float [] xdelta = new float[num];
float [] ydelta = new float[num];
float [] xrr = new float[num];
float [] yrr = new float[num];
float xcoord;
float ycoord;
int score = 0;
int score2 = 0;
int score3 = 0;
int count = 0;

void setup() {
  size(700, 500);
  frameRate(60);
  for (int i = 0; i < num; i++) {
    xrr[i] = random(1 , width-10);
    yrr[i] = random(1, height-10);
    xdelta[i] = random(7 , 20);
    ydelta[i] = random(7, 20);
    minim = new Minim(this);
    flush = minim.loadSnippet("C:\\Users\\arindam das modak\\Desktop\\Processing projects\\basic_Processing\\cartoon003.wav");
    minim2 = new Minim(this);
    //bg = minim2.loadSnippet("C:\\Users\\arindam das modak\\Desktop\\Processing projects\\basic_Processing\\Locked Away - Justin Bieber &bull;  T. Swift &bull; Sam Smith &bull; Beyonc&eacute; &bull; Ellie Goulding &bull; N. Minaj.mp3");
    bg = minim2.loadSnippet("C:\\Users\\arindam das modak\\Desktop\\Processing projects\\basic_Processing\\Sia - Cheap Thrills (Performance Edit).mp3");
  }
}

void draw() {
  background(0);
  smooth();
  //bg.rewind();
  bg.play();
  fill(255, 0, 0);
  stroke(0, 255, 0);
  strokeWeight(3);
  if (mouseX < width - 100)
    xcoord = width - 100;
  else if (mouseX > width - 50)
    xcoord = width - 50;
  else
    xcoord = mouseX;
  ycoord = mouseY;
  fill(138, 138, 100);
  rect(width - 100, 0, 50, height);
  fill(255, 0, 0);
  ellipse(xcoord, ycoord, 20, 50);
  for (int i = 0; i < num; i++) {
      
    ellipse(xrr[i], yrr[i], 20, 20);
    
    xrr[i] = xrr[i] + xdelta[i];
    yrr[i] = yrr[i] + ydelta[i];
  
    if ((xrr[i] > width - 10) || (xrr[i] < 10) || ((abs(xrr[i] - xcoord) < 7) && (abs(yrr[i] - ycoord) < 50))) {
      xdelta[i] = -xdelta[i];
      if ((abs(xrr[i] - xcoord) < 10) && (abs(yrr[i] - ycoord) < 50) && (xrr[i] > width - 120)) {
      
        score = score + 1;
        flush.rewind();
        flush.play();
      }
    }
  
    if ((yrr[i] > height - 10) || (yrr[i] < 10) || ((abs(yrr[i] - ycoord) < 50) && (abs(xrr[i] - xcoord) < 7))) {
      ydelta[i] = -ydelta[i];
    }
    
    textSize(25);
    fill(0, 50, 255);
    text("Previous Score : " + score2, 10, 30);
    fill(0, 150, 255);
    text("Score : " + score, 10, 60);
    fill(0, 250, 255);
    text("Highest Score : " + score3, width - 340, 30);
    text("PAUSE ||", width/2 - 35, 80);
    if (xrr[i] >= width - 40) {
      //score = score - 1;
      //score = score / 2;
      if ( score != 0) {
        print("Game Over...\n");
        print("Your Score is : ");
        print(score);
        print("\n");
        if(score > score2) {
          score3 = score;
        }
        score2 = score;
      }
      score = 0;
    }
  }
  if (score == 0 && score3 != 0) {
    text("Game Over" , width/2 - 50, height/2 - 20);
    text("Your Score is : " + score2, width/2 - 70, height/2 + 20);
    
  }
}
void mouseClicked() {
  if (count % 2 == 0) {
    noLoop();
    if (score == 0) {
      fill(255, 0, 0);
      rect(width/2 - 50, height/2 - 60, 150, 40);
      fill(250, 255, 255);
      text("START", width/2 -10, height/2 - 30);
    }
    else {
      rect(width/2 - 40, 60, 130, 40);
      fill(250, 0, 0);
      text("Continue", width/2 - 30, 90);
    }
  }
  else {
    loop();
  }
  count = count + 1;
  
}