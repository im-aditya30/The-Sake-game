import processing.sound.*;
PImage img;
PImage img_snake;
SoundFile file;
SoundFile file1;
SoundFile file2;
int snake[][];
int len;
int dir;
int food,food1;
int frame;
int count;
int score;
int page;
int score_up;
//int rate = 100;
void setup(){
  size(800,900);
  surface.setResizable(true);
  //frameRate(rate);
  file2 = new SoundFile(this,"mario_bros_die.mp3");
  file = new SoundFile(this,"mario_bros_3.mp3");
  img = loadImage("apple (2).png");
  img_snake = loadImage("snake.png");
  file.play();
  file.loop();
  
  snake = new int[50][2];
  food = food1 = 0;
  reset();
  frame = 6;
  count = 0;
  textAlign(CENTER);
}

void draw(){
  
  switch(page){
    case 0: first_screen();break;
    case 1 :start_game(); break;
    case 2:
  }
}
void first_screen(){
  //file = new SoundFile(this,"mario_bros_3.mp3");
  //file.play();
  strokeWeight(1);
  fill(155,73,222);
  rect(0,0,800,900);
  textSize(75);
  fill(255);
  text("The Snake" ,350,400);
  image(img_snake,550,270,150,150);
  textSize(30);
  fill(255,0,0);
  text("Right-Click to start the game",400,470);
  textSize(25);
  fill(255);
  text("~Created by~",600,520);
  textSize(40);
  fill(255);
  text("Aditya Gupta", 600,570);
}
void keyPressed() {
  switch(keyCode) {
    case DOWN: if (dir!=8) dir=2; break;
    case LEFT: if (dir!=6) dir=4; break;
    case RIGHT: if (dir!=4) dir=6; break;
    case UP: if (dir!=2) dir=8; break;
  }
}
void mousePressed(){
  page = 1 ;
}
void start_game() {
  if(file2.isPlaying()){
      file2.stop();
  }
  strokeWeight(0);
  fill(258,200,180);
  rect(0,0,800,800);
  strokeWeight(1);
  fill(155,73,222);
  rect(0,800,800,100);

 strokeWeight(0);
 noStroke();
 if(score % 50 == 0 && score_up < 37 && score != 0){
    score_up += 1;
  }
  fill(104,230,98);
  for ( int i=0; i<len; i++ ) {
    rect(snake[i][0]*20, snake[i][1]*20, 20, 20);
  }
  //fill(233, 9, 16);
  image(img,food*20,food1*20 , 20, 20);
  textSize(50);
  fill(255);
  text(score, 400, 870);
  //frameupdate();
  count++;
  if ( count == frame ) {
    count = 0;
    update();
    
  }
}

void update() {
  int a = snake[len-1][0], b = snake[len-1][1];
  for ( int i=len-1; i>0; i-=1 ) {
    snake[i][0] = snake[i-1][0];
    snake[i][1] = snake[i-1][1];
  }
  
  switch(dir) {
    case 2: moveDown(); break;
    case 4: moveLeft(); break;
    case 6: moveRight(); break;
    case 8: moveUp(); break; 
  }
  if ( snake[0][0] == food && snake[0][1] == food1 ) {
    if(file.isPlaying());
        file.stop();
    file1 = new SoundFile(this,"mario_power_up.mp3");
    file1.play();
    snake[len][0] = a;
    snake[len][1] = b;
    len++;
    score += 10 ;
    createfood();
    //file1.stop();
  }
  for ( int i=1; i<len; i++ ) {
    if ( snake[0][0] == snake[i][0] && snake[0][1] == snake[i][1] ) {
      file1.stop();
      file2.play();
      reset();
      textSize(100);
      fill(0);
      text("Game Over",400,400);
      page = 2;
      //file2.stop();
    }
  }
}

void reset() {
  score = 0;
  len = 1;
  score_up = 20;
  for(int i = 0;i<2;i++)
    for(int j = 0; j<2 ;j++)
      snake[i][j] = 20;
  createfood();
  dir = 0;
}
void moveDown() {
  if ( snake[0][1] < 39 ) {
    snake[0][1] += 1;
  } else {
    snake[0][1] = 0;
  }
}

void moveUp() {
  if ( snake[0][1] > 0 ) {
    snake[0][1] -= 1;
  } else {
    snake[0][1] = 39;
  }
}
void moveRight() {
  if ( snake[0][0] < 39 ) {
    snake[0][0] += 1;
  } else {
    snake[0][0] = 0;
  }
}

void moveLeft() {
  if ( snake[0][0] > 0 ) {
    snake[0][0] -= 1;
  } else {
    snake[0][0] = 39;
  }
}
void createfood(){
  food = (int)random(40);
  food1 = (int)random(40);
  while(check()){
      food = (int)random(40);
      food1 = (int)random(40);
  }
}

boolean check(){
 for(int i=0; i<len; i++){
    if(snake[i][0] == food && snake[i][1] == food1) return true;
 }
 return false;
}
