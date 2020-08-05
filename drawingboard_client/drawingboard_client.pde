import processing.net.*;
Client myclient;

int h;
int px,py,x,y;
boolean reset;

String comment;

color blue,white;

void setup(){
  myclient = new Client(this, "127.0.0.1", 1234); 
  background(255);
  size(600,800);
  colorMode(HSB,100);
  
  h = 100;
  
  blue = #B5E3CF;
  white = #FFFFFF;
  
  strokeWeight(40);
  stroke(0);
  fill(blue);
  rect(0,600,600,180);


comment = " ";

px = 0;
py = 0;
x = 0;
y = 0;
}

void draw(){
  //reset 
  if(reset == true){
    background(0,0,100);
    reset = false;
  }
  
  //drawing 
  strokeWeight(15);
  stroke(h, 90,99);

  // listening code
  if(myclient.available() >0){
   String drawing = myclient.readString();
     String[] line = drawing.split(",");
     println(drawing);
     
      px = int(line[0]);
      py = int(line[1])-200;
       x = int(line[2]);
       y = int(line[3])-200;
     if (px == 1000000){
       reset = true;
     }else {
         if(px<600 && x<600 ){
            line(px,py,x,y);
            h--; 
            if (h  <= 0){
            h = 100;
            }
          }
     }
   }


  //typing space
  strokeWeight(40);
  stroke(0);
  fill(blue);
  rect(0,600,600,180);
  textSize(20);
  fill(white);
  text("What do you think of this drawing?",5, 600);
  
  //display comment
    textSize(24);
    textAlign(LEFT);
    stroke(0);
    fill(0);
    text(comment,60,640, 500, 120);
  
}

void keyTyped(){
  if(key != ENTER ){
    comment = comment + key;

  }
  if(key == ENTER){
    myclient.write(comment);
    println(comment);
    comment = " ";
  }
}

  
  