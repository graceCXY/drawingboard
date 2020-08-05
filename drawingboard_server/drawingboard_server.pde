import processing.net.*;
Server myserver;

int h;
String comment;
color blue,white;

void setup(){
  myserver = new Server(this ,1234);
  background(255);
  size(600,800);
  colorMode(HSB,100);
  
  h = 100;
  comment = " ";
  
  blue = #B5E3CF;
  white = #FFFFFF;
  
  strokeWeight(40);
  stroke(0);
  fill(blue);
  rect(0,0,600,180);
}

void draw(){
  //reset 
  if(keyPressed == true&& key == ENTER){
    background(0,0,100);
    myserver.write("1000000"+","+"1000000"+","+"1000000"+","+"1000000");
    comment = " ";
  }
  //commenting space
  strokeWeight(50);
  stroke(0);
  fill(blue);
  rect(0,0,600,180);
  textSize(20);
  fill(white);
  text("Someone commented on your drawing!",5, 25);
  
  //draw comment 
    textSize(24);
    textAlign(LEFT);
    stroke(0);
    fill(0);
    text(comment,60,40,500,120);
  
  //drawing 
  if(mouseX>=0&&mouseX<=600&&mouseY>=200&&mouseY<=800){
  strokeWeight(15);
  stroke(h, 90,99);
  
  if(mousePressed == true){
    line(pmouseX, pmouseY, mouseX,mouseY);
    String drawing = pmouseX+","+pmouseY+","+mouseX+","+mouseY+".";
    myserver.write(drawing);
    println(drawing);
    h--; 
    if (h  <= 0){
    h = 100;
    }
  }
  }
  

// listening code
  Client a = myserver.available();
  if( a != null){
    comment = a.readString();
    println(comment);

  }
  
  
}


  
  