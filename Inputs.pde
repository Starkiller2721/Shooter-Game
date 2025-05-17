void mousePressed()
{
  mousedown = true;

  
  if (!menu && !paused)
  {
    float targetX = mouseX - width / 2 + playerx;
    float targetY = mouseY - height / 2 + playery;
    
    if (selectedweapon == 4)
    {
      missiles.add(new Missile(playerx + 20, playery + 20, targetX, targetY));
    }
    
    if (selectedweapon == 1)
    {
      if (revolver) projectiles.add(new Projectile(playerx + 20, playery + 20, targetX, targetY, 1, 3, 4));
      
      else projectiles.add(new Projectile(playerx + 20, playery + 20, targetX, targetY, 1, 1, 1));
    }
    
    if (selectedweapon == 3 && cooldown == 0 && !shotgun4)
    {
      //shoots three shots forward
      if (shotgun)
      {
        projectiles.add(new Projectile(playerx + 20, playery + 20, targetX, targetY, 1, 2, 3));
        projectiles.add(new Projectile(playerx + 20, playery + 20, targetX+50, targetY-50, 1, 2, 3));
        projectiles.add(new Projectile(playerx + 20, playery + 20, targetX-50, targetY+50, 1, 2, 3));
        
        cooldown = 10;
      }
      
      //shoots three shots backwards
      if (shotgun2)
      {
        float aimx = mouseX - width / 2 + playerx;
        float aimy = mouseY - height / 2 + playery;
        
        float invertedx = playerx * 2 - aimx;
        float invertedy = playery * 2 - aimy;
        projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx, invertedy, 1, 2, 4));
        projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx+50, invertedy-50, 1, 2, 4));
        projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx-50, invertedy+50, 1, 2, 4));
      }
      
      if (shotgun3) cooldown = 2;
    }
  }
  
  if (play.ishovered())
  {
    menu = false;
    paused = false;
  }
  
  if (healthpack.ishovered() && healthpacks > 0)
  {
    healthpacks --;
    playerhalth += 3;
  }
  
  if (healthpackbuy.ishovered() && score >= healthpackbuy.value)
  {
    healthpacks ++;
    score -= healthpackbuy.value;
  }
  
  if (shotgunbuy4.ishovered() && score >= shotgunbuy4.value && shotgun3 && !shotgun4)
  {
    shotgun4 = true;
    score -= shotgunbuy4.value;
  }
  
  if (shotgunbuy3.ishovered() && score >= shotgunbuy3.value && shotgun2 && !shotgun3)
  {
    shotgun3 = true;
    score -= shotgunbuy3.value;
  }
  
  if (shotgunbuy2.ishovered() && score >= shotgunbuy2.value && shotgun && !shotgun2)
  {
    shotgun2 = true;
    score -= shotgunbuy2.value;
  }
  
  if (shotgunbuy.ishovered() && score >= shotgunbuy.value && weapons.size() < 4 && !shotgun)
  {
    shotgun = true;
    score -= shotgunbuy.value;
    weapons.add(new Button("Shotgun", width-400, 360+(weapons.size() * 40), 3, false, 1));
  }
  
  if (turretbuy.ishovered() && score >= 30 && turrets < 60)
  {
    turrets++;
    score -= turretbuy.value;
  }
  
  
  if (smgbuy2.ishovered() && score >= smgbuy2.value && smg && !smg2)
  {
    smg2 = true;
    score -= smgbuy2.value;
  }
  if (smgbuy.ishovered() && !smg && score >= smgbuy.value && weapons.size() < 4)
  {
    smg = true;
    score -= smgbuy.value;
    weapons.add(new Button("  SMG  ",width-400, 360+(weapons.size()*40),2, false, 4));
  }
  if (rpgbuy.ishovered() && !rpg && score >= rpgbuy.value && revolver && weapons.size() < 4)
  {
    rpg = true;
    score -= rpgbuy.value;
    weapons.add(new Button("  RPG  ",width-400, 360+(weapons.size()*40),5, false, 4));
  }
  
  if (revolverbuy.ishovered() && !revolver && score >= revolverbuy.value)
  {
    revolver = true;
    score -= revolverbuy.value;
    weapons.remove(0);
    weapons.add( new Button("Revolver",width-400,360, 1, true, 3));
  }
  
  for (Button b:weapons)
  {
    if (b.ishovered())
    {
      selectedweapon = b.value;
      for (Button a:weapons)
      {
        a.selected = false;
      }
      
      b.selected = true;
    }
  }
}

void mouseReleased()
{
  mousedown = false;
}

void keyPressed()
{
  if ((key == 'w' || key == 'W') && !Key.contains('w'))
  {
    Key.add('w');
  }
  if ((key == 's' || key == 'S') && !Key.contains('s'))
  {
    Key.add('s');
  }
  if ((key == 'a' || key == 'A') && !Key.contains('a'))
  {
    Key.add('a');
  }
  if ((key == 'd' || key == 'D') && !Key.contains('d'))
  {
    Key.add('d');
  }
  
  if (key == 'e' || key == 'E')
  {
    menu = true;
    paused = true;
  }
}

void keyReleased()
{
  if (key == 'w' || key == 'W')
  {
    for (int c = 0; c < Key.size(); c ++)
    {
      if (Key.get(c) == 'w')
      {
        Key.remove(c);
      }
    }
  }
  if (key == 's' || key == 'S')
  {
    for (int c = 0; c < Key.size(); c ++)
    {
      if (Key.get(c) == 's')
      {
        Key.remove(c);
      }
    }
  }
  if (key == 'a' || key == 'A')
  {
    for (int c = 0; c < Key.size(); c ++)
    {
      if (Key.get(c) == 'a')
      {
        Key.remove(c);
      }
    }
  }
  if (key == 'd' || key == 'D')
  {
    for (int c = 0; c < Key.size(); c ++)
    {
      if (Key.get(c) == 'd')
      {
        Key.remove(c);
      }
    }
  }
  
  if (keyCode == ENTER && !menu) paused = !paused;
}
