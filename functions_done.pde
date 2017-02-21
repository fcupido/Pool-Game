void start_game()          //starts and restarts game by drawing table, balls and stick in starting position
{                          //promises to allocate memory for table object
   
  t = new table();
}

void show_score()    //shows score in bottom left corner
{                    //promises to display on screen the correct score
  textSize(20);
  fill(0);
  text ("Score: "+ t.scoreP1, 100, height-25);
}


void bounce_balls()    //function for ball collision
{                      // requires either 2 balls, 1 ball and a wall, or cue ball and a ball. Promises to collide them properly
  for (int i = 0; i < t.balls.length; i++)
  {
    if (t.balls[i].can_collide)
    {
      if (close_to_edge(t.balls [i]))
        bounce_edge(t.balls [i]);

      friction (t.balls[i]);  // adds friction function to slow speed of balls
      update_ball(t.balls [i]);  //updates ball position
      if (ball_in(t.balls[i])) //adds a point if the ball is sunk and prevents it form colliding any longer
      {
        t.balls[i].can_collide=false;
        t.scoreP1 +=1;      //increases score by one if a ball is sunck and can no longer collide
      }
    }

    if (balls_close(t.cue_ball, t.balls [i])&&(t.cue_ball.can_collide && t.balls[i].can_collide)) // Colides Cue ball against balls
    {
      colide(t.cue_ball, t.balls [i]);
    }
  }

  for (int i = 0; i < t.balls.length - 1; i++) //Colides Ball against ball
  {
    for (int k = i + 1; k < t.balls.length; k++)
    {
      if ((t.balls[i].can_collide && t.balls[k].can_collide)&&balls_close(t.balls[i], t.balls[k]))
      {
        colide(t.balls[i], t.balls[k]);
      }
    }
  }
}

//Function that gives a portion of the power to the x and y vector velocities of the cue ball accoring to the sine and cosine  of the angle between the mouse and the cue ball
//REquires Cueball, stick and tha they are properly initialized, and a power int
//Promises to strike the ball


void strike_ball()    //strike ball with stick. Uses pythagoras to determine angle at which it moves
{
  float force = -0.2 - sq(t.bar_height / 5)/10;

  if ((mousePressed == false && t.bar_height!= -1)&& t.time < t.time0 - 1)
  {
    if ((sq(mouseX - t.cue_ball.center.x)+sq(mouseY - t.cue_ball.center.y)) < sq(t.cue_ball.diameter)+200)
    {
      t.cue_ball.vx += force*( mouseX - t.cue_ball.center.x)/ sqrt(sq(mouseX - t.cue_ball.center.x)+sq(mouseY - t.cue_ball.center.y));
      t.cue_ball.vy += force*( mouseY - t.cue_ball.center.y)/ sqrt(sq(mouseX - t.cue_ball.center.x)+sq(mouseY - t.cue_ball.center.y));
    }


    t.bar_height = -1;      //resets power ball level after stick and cue ball contact
  }
}


void draw_powerbar()  //draws power bar. The longer the mouse button is held, the more power you get. 
{                     //Requires mouse button to be held, promises to increase power and display it accordingly
  if (mousePressed && t.bar_height > - 78)
  {
    t.bar_height -= 1;
  }

  fill(200, 10, 10, 140);
  rect(width - 130, 180, 20, t.bar_height * 0.92);
  fill(200, 10, 10);
  textSize(20);
  text("Power", width - 150, 100);
}

void draw_stick()  // draws pool stick
{                  //Promises to draw the stick. Requires mouse to be in the game window
  strokeWeight(10);
  stroke(222, 184, 135);
  line(t.st.start_p.x, t.st.start_p.y, t.st.end_p.x, t.st.end_p.y);
  strokeWeight(1);
  stroke(0);
}


void friction (Ball b)  //adds friction so ball will slow down. If speed is low enough (below 0.05) speed is set to zero
{                        //Requires ball to have speed, promises to reduce speed until it is set to zero
  b.vx *= 0.99;

  b.vy *= 0.99;
  if (abs(b.vx) < 0.05)
    b.vx = 0;
  if (abs(b.vy) < 0.05)
    b.vy = 0;
}

boolean balls_close (Ball a, Ball b)  //Requires 2 balls. Promises to return true or false depending on how close they are together
{
  if (sq(a.center.x - b.center.x) + sq (a.center.y -b.center.y) <= sq (a.diameter))
    return true;

  return false;
}

//Colide is a functon that calculates the vector velociteis of two balls after coliding.
//The balls are moved away from each other and a measure is set in place to ensure the balls will not colide again inthe next frame
//REquires
//   Two Balls moving toward each other
//   at least one of the balls has a velocity in any direction
// PRomises:
//   To rearange the velocities of the balls acording to how they would cilide in the real world


void colide (Ball a, Ball b)
{
  float k = ((a.vx-b.vx)*(a.center.x - b.center.x) + (a.vy - b.vy)*(a.center.y - b.center.y)) / (sq(a.center.x - b.center.x) + sq(a.center.y - b.center.y));
  float deltaX = (a.center.x - b.center.x);
  float deltaY = (a.center.y - b.center.y);
  a.vx = a.vx - k * deltaX;
  a.vy = a.vy - k * deltaY;
  b.vx = b.vx + k * deltaX;
  b.vy = b.vy + k * deltaY;

  hit_med[t.sound_counter].play();  // sound for ball collision
  hit_med[t.sound_counter].rewind();
  t.sound_counter+= 1;              //ensures multiple sounds can be played simultaneously by having sounds in an array and cycling through them
  t.sound_counter %= hit_med.length;

  while (balls_close(a, b))
  {
    a.center.x += a.vx;
    a.center.y += a.vy; 
    b.center.x += b.vx;
    b.center.y += b.vy;
  }
}

void update_ball (Ball a)  // updates ball location by adding velocity to center point
{
  a.center.x += a.vx;
  a.center.y += a.vy;
}

boolean close_to_edge(Ball b)    //checks if ball is close to the boundary edge
{
  if (b.center.x >= width - 70 || b.center.x <= 70)
    return true;
  if (b.center.y >= height - 70 || b.center.y <= 70)
    return true;
  return false;
}

void draw_ball(Ball b)    //function to draw a ball
{
  fill(b.col.r, b.col.g, b.col.b, b.col.tr);    //coloring the ball the correct color
  ellipse(b.center.x, b.center.y, b.diameter, b.diameter);  //drawing the ball in the specified position
}


void draw_balls()    //function to draw a ball
{
  for (int i = 0; i < t.balls.length; i++)
  {
    if (t.balls[i].can_collide)
    {
      fill(t.balls[i].col.r, t.balls[i].col.g, t.balls[i].col.b, t.balls[i].col.tr);    //coloring the ball the correct color
      ellipse(t.balls[i].center.x, t.balls[i].center.y, t.balls[i].diameter, t.balls[i].diameter);  //drawing the ball in the specified position
    }
  }
}




void update_stick()    //updates stick location on the screen
{
  t.st.start_p.x = mouseX;
  t.st.start_p.y = mouseY;

  t.st.end_p.x = (mouseX + 200*( mouseX - t.cue_ball.center.x)/ sqrt(sq(mouseX - t.cue_ball.center.x)+sq(mouseY - t.cue_ball.center.y)));  //end position of stick determined by pythagoras
  t.st.end_p.y = (mouseY + 200*( mouseY - t.cue_ball.center.y)/ sqrt(sq(mouseX - t.cue_ball.center.x)+sq(mouseY - t.cue_ball.center.y)));
}

void draw_table(table t)    //function to draw table
{
  //drawing pool table
  fill (139, 69, 19);  //brown colour for edge
  rect (0, 0, width, height, 25);// edge
  fill (0, 69, 0);  //green colour for felt
  rect (50, 50, width-100, height-100);//felt
  arc(width/4, height/2, height/4, height/4, PI/2, 3*PI/2);
  fill(0);   //black for pockets
  
  //pockets
  ellipse (50, 50, 75, 75);
  ellipse (width-50, 50, 75, 75);
  ellipse (50, height-50, 75, 75);
  ellipse (width-50, height-50, 75, 75);
  line (width/4, 50, width/4, height-50);
  fill (255);
  ellipse(width/4, height/2, 5, 5);  //cue ball starting position marker
  ellipse(2*width/3, height/2, 5, 5);  //leading ball starting position marker
  fill (255, 215, 0);
  
  // loop for drawing gold circles on border
  for (int i=100; i<=width-100; i+=50)
    ellipse (i, 25, 5, 5);


  for (int i=100; i<=width-100; i+=50)
    ellipse (i, height-25, 5, 5);


  for (int i=100; i<=height-100; i+=50)
    ellipse (25, i, 5, 5);


  for (int i=100; i<=height-100; i+=50)
    ellipse (width-25, i, 5, 5);
}

void play_wall()  //plays sound for wall impact
{
  wall[t.bounce_counter].play();
  wall[t.bounce_counter].rewind();
  t.bounce_counter+= 1;            //ensures multiple sounds can be played at the same time by cycling through array of sounds
  t.bounce_counter %= wall.length;
}

void bounce_edge (Ball b)                    //bounces ball off of boundaries and plays wall impact sounds
{
  if (b.center.x > width - b.diameter/2-50) 
  {
    play_wall();
    b.vx *= -1;
    b.center.x = width - b.diameter/2-51;
  } else if (b.center.x < b.diameter/2 + 50)
  {
    play_wall();
    b.vx *= -1;
    b.center.x = b.diameter/2 + 51;
  }
  if (b.center.y > height - b.diameter/2-50)
  {
    play_wall();
    b.vy *= -1;
    b.center.y = height - b.diameter/2 - 51;
  } else if (b.center.y < b.diameter/2 + 50)
  {
    play_wall();
    b.vy *= -1;
    b.center.y = b.diameter/2 +51;
  }
}
//Function that checks to see if an object of class ball has coordinates that that fall under the pocked drawing
//Requires// a ball with x and y coordinates
//Promises, 
//  return true if ball is in pocket
//  return false otherwise

boolean ball_in (Ball a)      //determines if any ball is in a pocket
{

  if (sq(a.center.x - 50) + sq(a.center.y - 50) < 37.5*37.5)
  {
    
    return true;
  } else if (sq(width - 50 - a.center.x) + sq(a.center.y - 50) < 37.5*37.5)
  {

    return true;
  } else if (sq(width - 50 - a.center.x) + sq(height - 50 - a.center.y) < 37.5*37.5)
  {
    return true;
  } else if (sq(a.center.x - 50) + sq(height - 50 - a.center.y) < 37.5*37.5)
  {
    return true;
  }


  return false;
}

// Function that ends the game, if the game ended because score reached 10, it displays a win mesage
// if the game ended because the cue ball is sunk, a game over message is displayed
// if game ended by timer or any other reazon the game displays that time run out
//  regardless of what the end reazon is, an option to create anew table is presented with a click


void end_game()    //displayes correct text for the end of the game
{
  if (t.scoreP1>=10&&t.cue_ball.can_collide) // if you win by making the score 10
  {
    textSize(81);                 
    fill (0);
    text ("YOU WIN!", width/3 - 20, height/2);
    cursor(0);
  } else if (ball_in(t.cue_ball)) // if you loose by sinking the cue ball
  {
    textSize(81);                 
    fill (0);
    text ("Game Over!", width/4-4, height/2);
    fill (150, 0, 0);
    textSize(80);
    text ("Game Over!", width/4, height/2);
    textSize(16);
    t.cue_ball.can_collide = false;
    cursor();
  } else  // in you end the game by running the timer to 0 ( and defaul even handliing)
  {
    draw_ball(t.cue_ball);
    textSize(81);                 
    fill (0);
    text ("TIME'S OUT!", width/4-4, height/2);
    fill (150, 0, 0);
    textSize(80);
    text ("TIME'S OUT!", width/4, height/2);
    textSize(16);
    
    cursor();
  }
  fill(150, 0, 0);
  textSize(45);
  text("CLICK ANYWHERE TO RESTART", width/5-50, 2*height/3);
  stop_balls();
}