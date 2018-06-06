ArrayList<Ember> arr = new ArrayList<Ember>();
ArrayList<Flame> Mainfire = new ArrayList<Flame>();
PImage img;

void setup(){
 
  //the screen dimensions...if y is changes...change dimensions
  size(400, 400);
  
  img = loadImage("background.jpg");
  img.resize(400, 400);
  background(img);
  //fade
}

void draw(){
  
  if(mousePressed || keyPressed){
      background(0);
  }//stop fire...make it look like smoke (fire doused)
    
  
  else{
    background(img);
  }
  
  for (float i = 0; i <= random(40)*2; i++){
    if(!keyPressed){
      Ember e = new Ember();
      arr.add(e);
    }
    Flame f = new Flame();
    Mainfire.add(f);
  }
  for(Ember ember: arr){
    ember.fade();
    ember.rise();
    if(dist(ember.getX(), ember.getY(), mouseX, mouseY) <= 20){
      ember.setPoints();
    }
  }
  
  for(int i = 0; i < arr.size(); i++){
    if(arr.get(i).getY() < 10){ //randomize number?
      arr.remove(i);
    }
  }
  //delete the embers that are off screen (otherwise program progressively gets slower) 
  
} 


//DONE!! 5-21-18 @ 12:57
class Ember{
  float speed = 10;
  float x = (random(400) + 1);
  float y1 = 400;
  
  float r = 0;
  float g = 0;
  float b = 0;
  //default black
  
  Ember(){
    int i = (int)(random(11));
    
    /*set colors
    
    stroke(r, g, b)*/
    
    if(i == 0){
      r = 242;
      g = 75;
      b = 14;
      //red-orange
    }
    else if (i == 1){
      r = 211;
      //dark red
    }
    else if (i == 2){
      r = 255;
      g = 66;
      b = 33;
      //bright red
    }
    else if (i == 3){
      r = 249;
      g = 154;
      b = 29;
      //amber
    }
    else if (i == 4){
      r = 255;
      g = 123;
      //orange
    }
    else if (i == 5){
      r = 255;
      g = 175;
      b = 15;
      //tangerine
    }
    else if (i == 6){
      r = 255;
      g = 238;
      //yellow
    }
    else if (i == 7){
      r = 255;
      g = 204;
      //saffron
    }
    else if (i == 8){
      r = 206;
      g = 127;
      b = 8;
      //brown
    }
    else if (i == 9){
      r = 255;
      b = 89;
      //fuschia
    }
    stroke(r, g, b);
    point(x, y1);
  }
  
  void fade(){
    //change color (extension: size) to simulate glowing
    //https://processing.org/discourse/beta/num_1243932978.html
    
    if(!mousePressed && !keyPressed){
      float changeColor = 0.5;
      r -= changeColor;
      g -= changeColor;
      b -= changeColor;
      if (r < 0)
        r = 0;
      if (g < 0)
        g = 0;
      if (b < 0)
        b = 0;
      stroke(r, g, b);
    }
    else if(mousePressed){
      colorChange();
    }
    else{
      grey();
    }
  }
  
  void rise(){
    float changeX = random(11); //random number from 0 to 10
    float changeY = random(2)*1.5;
    y1-= changeY;
    if(changeX < 2)
      x++;
    else if(changeX > 8)
      x--;
    point(x, y1);
  }
  
  void rise2(){ //only moves up one unit at a time for Flame constructor
    y1--;
    float changeX = random(11); //random number from 0 to 10
    if(changeX < 2)
      x++;
    else if(changeX > 8)
      x--;
    point(x, y1);
  }
  
  //The next three methods are for mouse interaction to have embers avoid the mouse
  float getX(){
    return x;
  }
  
  float getY(){
    return y1;
  }
  void setPoints(){
    while(dist(x, y1, mouseX, mouseY) <= 20){
      if(mouseY > y1)
        y1--;
      else if(mouseX < x)
        x++;
      else if(mouseX > x)
        x--;
    }
  }
  
  
  //changes color if mousePressed
  void colorChange(){
    float n = random(11); //random number from 0 to 10
    if(n <= 1){ //regular chance (0, 1)
      stroke(0, 85, 255);
    } //blue
    else if(n <= 3){ //regular chance (2, 3)
      stroke(13, 84, 226);
    } //fiery blue
    else if(n == 4){ //low chance (4)
      stroke(138, 165, 209);
    } //smokey grey blue
    else if(n <= 6){ //regular chance (5, 6)
      stroke(127, 172, 244);
    } //periwinkle
    else if(n <= 8){ //regular chance (7, 8)
      stroke(122, 193, 255);
    } //sky blue
    else{ //regular chance (9, 10)
      stroke(46, 140, 242);
    } //bright blue 71, 169, 255
  }
  
  //ashes if keyPressed
  void grey(){
    float n = random(11); //random number from 0 to 10
    if(n <= 2){ //high chance (0, 1, 2)
      stroke(127, 93, 90);
    } //ash
    else if(n <= 6){ //very high chance (3, 4, 5, 6)
      stroke(86, 71, 63);
    } //brown-grey
    else if(n == 7){ //low chance (7)
      stroke(61, 53, 49);
    } //dark brown-grey
    else if(n <= 9){ //regular chance (8, 9)
      stroke(165, 62, 53);
    } //dying ember
    else if(n == 10){ //low chance (10)
      stroke(33, 24, 20); //dark brown
    }
  }
}

class Flame{
  ArrayList<Ember> fire = new ArrayList<Ember>();
  float l;
  
  Flame(){
    l = random(30) + 20; //length of fire
    for(int i = 0; i <= l; i++){
      Ember toAdd = new Ember();
      for(int j = 0; j < i; j++){
        if(mousePressed){
          for(Ember e : fire){
            e.colorChange();
          }
          toAdd.rise2();
        }
        else if(!keyPressed){
          toAdd.rise2();
        }
      }
      fire.add(toAdd); //unecessary
    }
  }
  
}
//TODO:::: GREY METHOD
//ice-type thing

//stroke(177, 200, 239);
//icy blue and white

//screen size ****
//can do a method w/ return but not set the return type to anything?
//interface or inheritance
//spectrum...color picker like Google
//certain darkness text turns white
