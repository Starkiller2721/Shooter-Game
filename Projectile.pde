class Projectile 
{
  float x, y;
  float xspeed, yspeed;
  float speed = 15;
  int type;
  int health;
  int damage;

  Projectile(float startX, float startY, float targetX, float targetY, int temptype, int temphealth, int tempdamage)
  {
    //define speeds by distance on each axis
    x = startX;
    y = startY;
    
    float dx = targetX - startX;
    float dy = targetY - startY;
    float dist = dist(startX, startY, targetX, targetY);

    xspeed = (dx / dist) * speed;
    yspeed = (dy / dist) * speed;
    type = temptype;
    shoot.play();
    
    health = temphealth;
    damage = tempdamage;
  }

  void tick()
  {
    x += xspeed;
    y += yspeed;
    
    if (offScreen())
    {
      projectiles.remove(this);
    }
  }

  void display() 
  {
    if (type == 1) fill(#73E000);
    else fill(#DE1616);
    ellipse(x, y, 10, 10);
  }

  boolean offScreen()
  {
    if (x < playerx - width || x > playerx + width || y < playery - height || y > playery + height) return true;
    else return false;
  }
}
