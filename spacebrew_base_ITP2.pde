/*
 * Base Example 
 *
 *   Sketch that features the basic building blocks of a Spacebrew client app.
 * 
 */

import spacebrew.*;

String server="sandbox.spacebrew.cc";
//String server="localhost";
String name="drawingpad";
String description ="exercise2.0";

Spacebrew sb;

void setup() {
  size(600, 400);
  background(255);
  

  // instantiate the sb variable
  sb = new Spacebrew( this );

  // add each thing you publish to
  sb.addPublish( "mouse press", "range", 0 );
  sb.addPublish( "mouse press2", "range", 0 );
  sb.addPublish( "mouse press3", "range", 0 );
  
  sb.addPublish( "key up", "range", 0 ); 
  sb.addPublish( "key down", "range", 0 ); 

  // add each thing you subscribe to
  sb.addSubscribe( "changesColor R", "range" );
  sb.addSubscribe( "changesColor G", "range" );
  sb.addSubscribe( "changesColor B", "range" );
  sb.addSubscribe( "thicker brush", "range" );
  sb.addSubscribe( "thinner brush", "range" );

  // connect to spacebrew
  sb.connect(server, name, description );
}

int f1 = 0;
int f2;
int f3;
int r = 25;

void draw() {
  // do whatever you want to do here
  
  
  noStroke();
  fill(f1, f2, f3, random(10, 100));
  ellipse(mouseX, mouseY, r, r);

  if (mousePressed) {
    sb.send("mouse press", int(random(0, 255))); //if mouse is pressed, publisher 'mouse press' send out random numbers (publisher)
    sb.send("mouse press2", int(random(0, 255))); 
    sb.send("mouse press3", int(random(0, 255))); 
  }   
  if (keyPressed) {
    if (keyCode == UP) {

      sb.send("key up", int(random(26, 100)));
    } else if (keyCode == DOWN) {
      sb.send("key down", int(random(1, 23)));
    }
  }
}




void onRangeMessage( String name, int value ) { //when subscriber 'changesColor' receives value, do this (rectColor = value)
  if (name.equals("changesColor R")) {
    f1 = value;
  }else if (name.equals("changesColor G")){
    f2 = value;  
  }else if (name.equals("changesColor B")){
    f3 = value;  
  }
  else if (name.equals("thicker brush")){
    r = value;
  }else if (name.equals("thinner brush")){
     r = value;
  }


  println("got range message " + name + " : " + value);
}

void onBooleanMessage( String name, boolean value ) {
  println("got boolean message " + name + " : " + value);
}

void onStringMessage( String name, String value ) {
  println("got string message " + name + " : " + value);
}

void onCustomMessage( String name, String type, String value ) {
  println("got " + type + " message " + name + " : " + value);
}

