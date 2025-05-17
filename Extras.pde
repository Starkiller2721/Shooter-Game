void turret() 
{
  float targetx = 0, targety = 0;
  float tempdist = 999;
  float projectileSpeed = 15; // match your Projectile's speed

  ArrayList<Enemy> enemycopy = new ArrayList<Enemy>(enemies);
  for (Enemy e : enemycopy) 
  {
    float distToEnemy = dist(e.x, e.y, playerx, playery);
    
    // Estimate time for projectile to reach
    float t = distToEnemy / projectileSpeed;
    
    // Predict future position
    float futureX = e.x + enemymove * t;
    float futureY = e.y + enemymove * t;
    
    float predictedDist = dist(futureX, futureY, playerx, playery);
    
    if (predictedDist < tempdist) 
    {
      tempdist = predictedDist;
      targetx = futureX;
      targety = futureY;
    }
  }

  projectiles.add(new Projectile(playerx + 20, playery + 20, targetx, targety, 1, 1, 10));
}
