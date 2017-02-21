//A function that stops the movement of all balls still on the board, this is to prevent whatever error could be caused by the balls continuing to move after game has been declaed as over.

void stop_balls()
{
  t.cue_ball.vx = 0;
  t.cue_ball.vy = 0;

  for (int i = 0; i < t.balls.length; i++)
  {
    t.balls[i].vx = 0;
    t.balls[i].vy = 0;
  }

}

void timer ()  //Promises to reduce time by 1 for every 60 frames
{
  t.frame += 1;
  t.frame %= 60;  
  if (t.frame == 1)
  {
    t.time -= 1;
  }
  textSize(18);
  fill(0);
  text ("Time Remaining: "+ nf(t.time/60, 2) + ":" + nf(t.time%60,2), width/3, height - 30);
}



void correction() { //sometimes the cue ball moves when you click to start the game, this was to correct it
  if (t.first_frame)
  {
    t.cue_ball.vx = 0;
    t.cue_ball.vy = 0;
    t.first_frame = false;
  }
}

void mousePressed()    //promises to not show the cursor if mose button is pressed. Used during Rules screen
{
  if (t.starting == true)
    t.starting = false;
  noCursor();
}


void show_rules ()    //promises to show the game rules at the beginning of each game
{

  fill(255);
  rect(0, 0, width, height);
  fill(0);
  text("  You Win if:  All balls exept the cue ball are sunk.\n  You lose if: The cue ball is sunk.\n                    The time runs out. \n \n               CLICK ANYWHERE TO BEGIN \n  (mouse must be over the cue ball to hit it)", 260, 250);
}