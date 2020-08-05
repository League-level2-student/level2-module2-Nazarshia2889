//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*


class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int x;
int y;
// Add a constructor with parameters to initialize each variable.
Segment(int x, int y){
  this.x = x;
  this.y = y;
}


}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int foodX;
int foodY;
int direction = UP;
int eating = 0;
ArrayList<Segment> parts = new ArrayList<Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
 head = new Segment(100, 100);
 frameRate(20);
 dropFood();
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(255);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  stroke(0, 0 , 255);
  fill(0, 0, 255);
  rect(foodX, foodY, 10, 10);
  
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  
    fill(255, 0, 0);
    rect(head.x, head.y, 10, 10);
    manageTail();
  
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for(int i = 0;i < parts.size(); i++){
  fill(255, 0, 0);
   Segment s = parts.get(i);
  rect(s.x, s.y, 10, 10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
 Segment tail = new Segment(head.x, head.y);
 parts.add(tail);
 parts.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i = 0;i<parts.size();i++){
    Segment s = parts.get(i);
    if(head.x == s.x && head.y == s.y){
      eating = 0;
      parts.removeAll(parts);
      Segment newGame = new Segment(head.x, head.y);
      parts.add(newGame);
  }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  
  
    if(keyCode == UP && direction != DOWN){
      direction = UP;
    }
    else if(keyCode == DOWN && direction != UP){
      direction = DOWN;
    }
    else if(keyCode == RIGHT && direction != LEFT){
      direction = RIGHT;
    }
    else if(keyCode == LEFT && direction != RIGHT){
      direction = LEFT;
    }
  
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
  switch(direction) {
   
  case UP:
    // move head up here 
    head.y -= 5;
    break;
  case DOWN:
    // move head down here 
    head.y += 5;
    break;
  case LEFT:
   // figure it out 
   head.x -= 5;
    break;
  case RIGHT:
    // mystery code goes here 
    head.x += 5;
    break;
  }
  checkBoundaries();

}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.x > 500){
   head.x = 0;
 }
 else if(head.y > 500){
   head.y = 0;
 }
 else if(head.x < 0){
   head.x = 500;
 }
 else if(head.y < 0){
   head.y = 500;
 }
 
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(head.x >= foodX - 5 && head.x <= foodX + 5 && head.y >= foodY - 5 && head.y <= foodY + 5){
   eating += 1;
   dropFood();
   Segment added = new Segment(head.x, head.y);
   parts.add(added);
  }

}
