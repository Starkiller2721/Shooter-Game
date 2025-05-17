class Enemy
{
  float x, y;
  int type; //0 = normal enemy, 1 = flanker enemy
  float offsetX, offsetY;
  int retargetTimer = 0;
  int health;
  int cooldown;
  
  Enemy(float tempX, float tempY, int temptype, int temphealth)
  {
    x = tempX;
    y = tempY;
    type = temptype;
    health = temphealth;
  }
  
  void pickFlankTarget() 
  {
    offsetX = random(-500, 500);
    offsetY = random(-500, 500);
    retargetTimer = int(random(30, 90)); // frames until next target
  }
  
  void tick()
  {
    if (type == 0) normalmovement();
    else flankermovement();
    
    if (cooldown > 0) cooldown--;
    
    if (x < playerx+20 && x > playerx-20 && y < playery+20 && y >playery-20)
    {
      enemies.remove(this);
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), health+2));
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), health+2));
      playerhalth --;
    }
    
    ArrayList<Projectile> projectilecopy = new ArrayList<Projectile>(projectiles);
    for (Projectile a : projectilecopy)
    {
      if (a.x < x + 20 && a.x > x -20 && a.y < y + 20 && a.y > y - 20 && cooldown == 0)
      {
        health --;
        a.health--;
        cooldown = 5;
        
        if (a.health == 0)
        {
          projectiles.remove(a);
        }
        
        if (health == 0)
        {
          enemies.remove(this);
          kills ++;
          
          if (kills % 2 == 0)
          {
            score++;
          }
          
          if (kills % 5 == 0)
          {
            coins.add(new coin(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000))));
          }
        }
      }
    }
  }
  
  void normalmovement()
  {
    float nextX = x;
    float nextY = y;
    float jitter = random(-2,2);
  
    // Determine desired next position
    if (x > playerx) nextX -= enemymove + jitter;
    else if (x < playerx) nextX += enemymove + jitter;
  
    if (y > playery) nextY -= enemymove + jitter;
    else if (y < playery) nextY += enemymove + jitter;
  
    // Check for other enemies at the next position
    boolean blockedX = false;
    boolean blockedY = false;
  
    for (Enemy other : enemies)
    {
      if (this != other)
      {
        // Check horizontal movement collision
        if (abs(other.x - nextX) < 10 && abs(other.y - y) < 10)
        {
          blockedX = true;
        }
  
        // Check vertical movement collision
        if (abs(other.y - nextY) < 10 && abs(other.x - x) < 10)
        {
          blockedY = true;
        }
      }
    }
  
    // Only move if not blocked
    if (!blockedX) x = nextX;
    if (!blockedY) y = nextY;
  }
  
  void flankermovement()
  {
    if (retargetTimer <= 0) 
    {
      pickFlankTarget();
    } else 
    {
      retargetTimer--;
    }
    
    float nextX = x;
    float nextY = y;
    float targetX = playerx + offsetX;
    float targetY = playery + offsetY;
  
    // Determine desired next position
    if (x > targetX) nextX -= enemymove + 2;
    else if (x < targetX) nextX += enemymove + 2;
  
    if (y > targetY) nextY -= enemymove;
    else if (y < targetY) nextY += enemymove;
  
    // Check for other enemies at the next position
    boolean blockedX = false;
    boolean blockedY = false;
  
    for (Enemy other : enemies)
    {
      if (this != other)
      {
        // Check horizontal movement collision
        if (abs(other.x - nextX) < 10 && abs(other.y - y) < 10) blockedX = true;
  
        // Check vertical movement collision
        if (abs(other.y - nextY) < 10 && abs(other.x - x) < 10) blockedY = true;
      }
    }
  
    // Only move if not blocked
    if (!blockedX) x = nextX;
    if (!blockedY) y = nextY;
  }
  
  void display()
  {
    if (type == 0) image(normalenemy,x,y,20,20);
    else image(flankerenemy,x,y,20,20);
  }
}
