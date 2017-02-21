class Point    //class point used in ball and for collisions
{
  float x, y;
  Point (float a, float b)
  {
    x = a;          ////x and y coordinates for point
    y = b;
  }
}

class table      //class table contains an array of balls, cue ball, stick, power bar, score and counters for sound
{
  Ball [] balls; 
  Ball cue_ball; //iteration 3
  Stick st;
  int scoreP1;
  int scoreP2;
  boolean starting;
  boolean first_frame;
  int sound_counter;
  int bounce_counter;
  int counter;
  int bar_height;
  int time;
  int time0;
  int frame;


  table()
  {
    frame = 0;  //used in timer
    time = 301;
    time0 = time;
    balls = new Ball[10]; //array of balls initialized below in starting positions
    scoreP1 = 0;
    scoreP2 = 0;
    starting = true;  //boolean for showing start screen
    bar_height = -1;
    sound_counter = 0;      //position in array of sound files
    bounce_counter = 0;    //position in array of sound files
    first_frame = true;
    
    //starting position of balls with random colours
    balls [0] = new Ball(2*width/3, height/2, 25.0, 25.0, parseInt(random(0, 255)), 0, parseInt(random(0, 255)));
    balls [1] = new Ball(2*width/3+25, height/2-15, 25.0, 25.0, parseInt(random(0, 255)), parseInt(random(0, 255)), 0);
    balls [2] = new Ball(2*width/3+25, height/2+15, 25.0, 25.0, parseInt(random(0, 255)), 0, 0);
    balls [3] = new Ball(2*width/3+50, height/2, 25.0, 25.0, 0, 0, 0);
    balls [4] = new Ball(2*width/3+50, height/2+30, 25.0, 25.0, 0, parseInt(random(0, 255)), 0);
    balls [5] = new Ball(2*width/3+50, height/2-30, 25.0, 25.0, 0, parseInt(random(0, 255)), parseInt(random(0, 255)));
    balls [6] = new Ball(2*width/3+75, height/2+15, 25.0, 25.0, 0, parseInt(random(0, 255)), 0);
    balls [7] = new Ball(2*width/3+75, height/2-15, 25.0, 25.0, 0, 0, parseInt(random(0, 255)));
    balls [8] = new Ball(2*width/3+75, height/2-45, 25.0, 25.0, parseInt(random(0, 255)), parseInt(random(0, 255)), parseInt(random(0, 255)));
    balls [9] = new Ball(2*width/3+75, height/2+45, 25.0, 25.0, parseInt(random(0, 255)), parseInt(random(0, 255)), parseInt(random(0, 255)));


    cue_ball=new Ball(width/4, height/2, 25.0, 25.0, 255, 255, 255);
    
    st=new Stick();
  }
}


class colour  //colour class to set the specified colour
{
  int r;
  int g; 
  int b;
  int tr;    //transparency
  colour (int c, int d, int e)
  {
    r=c;
    g=d;
    b=e;
  }
  colour(int c, int d, int e, int t)      // overloaded constructor including option for transparency
  {
    r=c;
    g=d;
    b=e; 
    tr=t;  
   }


  colour(int a)  // overloaded constructor type used for grey scale
  {
    r=a;
    fill(r);
  }
}

class Ball    //class of type Ball
{
  float diameter;      //radius
  Point center;    
  //Point contact_point;
  colour col; // colour of the ball calling clas colour 
  int r;
  int g;
  int bl;
  float vx;    //velocity x
  float vy;    //velocity y
  boolean can_collide;
  int trans;

  Ball(float x, float y, float a, float b, int red, int green, int blue) //constructor
  {


    center=new Point (x, y); //calling Point
    diameter=25;    //setting radius
    //contact_point=new Point(a, b);
    r=red;
    g=green;
    bl=blue;
    trans=255;
    col=new colour(r, g, bl, trans);  //setting color using colour class
    vx = 0;
    vy = 0;
    can_collide=true;
  }
}

class Stick    //class type stick
{
  Point start_p;
  Point end_p;
  colour col; //color of the pool stick
  int length; //length of the pool stick
  Stick()
  {
    length=200;
    float angle=0;
    col= new colour (2, 2, 2);
    start_p=new Point(300, 300);
    end_p=new Point(100, 300);
  }
}