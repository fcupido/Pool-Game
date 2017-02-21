/* //<>//
  By Eldon Dunnet and Felipe Cupido
  Team Grey 
  Section B01
  Instructor: M. Moshirpour 
  Submited Tuesday december 07, at 7:00 pm


 Version 2.0!!
 Game is ready for handing in, Tahnk you sow much TA, for taking your time to look at our wondeful game.
 The game works great and we do not know of any glitches. The win screen looks good. IF you want to ckeck it you can make your starting score 9, so you only hae to sink one ball to winn
 if you want to see the time is out you can make the starting time something like 10 secods, both of these variables are found in the constructor for table
 
 VERSION 1.9.8
 Cleaned up required work
 Commented on everything
 VERSION 1.9.7
 added partial support for 2p game (crated scoreP1 and scoreP2 in table class & changed all calls to score to scoreP1)
 
 Removed coment that makes you able to ht the ball from anywhere~!
 
 put most global varialbes inside table t
 fixed change in score text size && power text size upon end of game
 added timer, and game ends if time runs out
 added a diferent end game message if time runs out "Time's out!"
 you can click to restart game at end of game
 instructions show at start of a new game
 mouse appears when game ends, dissapears when game starts
 
 
 VERSION 1.9.5
 Changelog From last Version
 -Cleaned up draw
 - made a few functions and deleted a few repeats
 functions: end game, draw balls (different from drawBall), play wall, 
 - made an array of wall sounds to prevent the crashing of the minim player by getting called to often
 
 
 HAS:
 TIMER, GAME ENDS IF TIME RUNS OUT
 an end statement saying you win if all balls are sunk
 boolean function that detects whether a ball is in a pocket 
 display of "Game Over!" once cueball is in a pocket (hides cueball)
 security feature which ensures balls bounce away, balls no longer stick
 sound when balls hit the side and when they colide.
 table, which contains: array of balls, cue ball, stick
 balls bounce off the edges and of one another
 the pool stick always aims at the cue ball and will strike it
 power bar tracks power that will be transmitted to the cue ball upon rease of mouse
 function that makes balls dissapear when they are detected in pocket
 You can click anywhere to restart when game is over
 
 NEEDS:
 ANONTATE ALL FUNCTIONS!!!!
 add support for two players!!
 REMOVING contact point resulted in a NULL POINTER ERROR
 remove contact_point in ball as it is not used
 rubrick suggests using member functions. Do we have enough?
 */


void draw()
{

  if (t.starting == false)    //draws everything needed for game after the game is started
  {
    draw_table(t);
    draw_balls();
    bounce_balls();

    if ((ball_in(t.cue_ball)||t.scoreP1==10) || t.time <=0)  //ends the game IF any of the correct conditions are met (sink cueball, sink all balls but cue ball, time runs out)
    { 
      end_game();
      if (mousePressed)
        start_game();
    } else                //updates the pool table display only while the game is running
    {
      update_stick();
      draw_ball(t.cue_ball);
      draw_stick();
      update_ball(t.cue_ball);
      if (close_to_edge(t.cue_ball))
        bounce_edge(t.cue_ball);
      draw_powerbar();
      strike_ball();
      friction (t.cue_ball);
      timer();
    } 
    show_score();
  } else
  {
    show_rules();    // shows the game rules at the start of each game
  }
}

void setup()
{

  size (1000, 600);
  textSize(20);
  minim = new Minim (this);    //allows sound to be used in game
  background(222, 184, 135); 


  for (int i = 0; i < hit_med.length; i++)  //plays correct sound for each type of impact
  {
    wall [i] = minim.loadFile("wall.mp3");
    hit_med [i]=  minim.loadFile("hit_med.mp3");
  }



  t = new table();
}