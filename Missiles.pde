class Missile 
{
  float x, y;
  float xspeed, yspeed;
  float targetX, targetY;
  float speed = 10;
  float explosionRadius = 100;
  boolean exploded = false;

  Missile(float startX, float startY, float targetX, float targetY) 
  {
    this.x = startX;
    this.y = startY;
    this.targetX = targetX;
    this.targetY = targetY;

    // Calculate normalized velocity
    float angle = atan2(targetY - y, targetX - x);
    xspeed = cos(angle) * speed;
    yspeed = sin(angle) * speed;
  }

  void update() 
  {
    if (!exploded) 
    {
      x += xspeed;
      y += yspeed;

      // Check if missile is close enough to explode
      if (dist(x, y, targetX, targetY) < 10) 
      {
        explode();
      }
    }
  }

  void render() 
  {
    if (!exploded) 
    {
      fill(255, 150, 0);
      ellipse(x, y, 20, 20);
    } else 
    {
      fill(255, 50, 0, 100);
      ellipse(x, y, explosionRadius*2, explosionRadius*2);
    }
  }

  void explode() 
  {
    exploded = true;
    
    ArrayList<Enemy> enemycopy = new ArrayList<Enemy>(enemies);
    for (Enemy e : enemycopy)
    {
      if (dist(x, y, e.x, e.y) <= explosionRadius) 
      {
        enemies.remove(e);
      }
    }
  }

  boolean isFinished() 
  {
    return exploded;
  }
}
