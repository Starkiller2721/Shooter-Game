class coin
{
  int x, y;
  int cooldown;
  
  coin(int tempX, int tempY)
  {
    x = tempX;
    y = tempY;
    cooldown = 240;
  }
  
  void display()
  {
    /*
    noFill();
    stroke(175);
    rectMode(CENTER);
    rect(x,y,40,40);
    stroke(0);
    rectMode(CORNER); 
    */
    fill(#FFEB03);
    if (frameCount%10 < 2) coinanimation1();
    else if (frameCount%30 < 6) coinanimation2();
    else if (frameCount%30 < 12) coinanimation3();
    else if (frameCount%30 < 18) coinanimation4();
    else if (frameCount%30 < 24) coinanimation3();
    else coinanimation2();
  }
  
  void tick()
  {
    if (x < playerx+40 && x > playerx-40 && y < playery+40 && y >playery-40)
    {
      coins.remove(this);
      for (int c = 0; c < 2; c++)
      {
        enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(1,3))));
      }
      score ++;
      collect.play();
    }
    
    cooldown --;
    if (cooldown <= 0)
    {
      coins.remove(this);
    }
  }
  
  void coinanimation1()
  {
    ellipse(x, y, 20, 20);
  }
  
  void coinanimation2()
  {
    ellipse(x, y, 15, 20);
  }
  
  void coinanimation3()
  {
    ellipse(x, y, 10, 20);
  }
  
  void coinanimation4()
  {
    ellipse(x, y, 5, 20);
  }
}
