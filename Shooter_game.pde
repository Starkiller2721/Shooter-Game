//Dylan king
//2d evasion game

//the initializations

import processing.sound.*;

int cooldown = 0;
int playerx = 0;
int playery = 0;
int movement = 10;
int enemymove = 5;
int playerhalth = 10;
int score = 0;
int kills = 0;
int turrets = 0;
boolean godmode = false;

float[] enemyX = {100, 1620};
float[] enemyY = {300, 700};

int initialenemies = 2;

boolean mousedown = false;
boolean paused = true;
boolean gameover = false;
boolean menu = true;
ArrayList<Character> Key = new ArrayList<Character>();

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<coin> coins = new ArrayList<coin>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Missile> missiles = new ArrayList<Missile>();

//buttons
Button play;
Button shotgunbuy;
Button turretbuy;
Button shotgunbuy2;
Button shotgunbuy3;
Button shotgunbuy4;
Button smgbuy;
Button smgbuy2;
Button rpgbuy;
Button revolverbuy;
Button healthpackbuy;
Button healthpack;

//inventory
int selectedweapon = 1;
int healthpacks = 2;
ArrayList<Button> weapons = new ArrayList<Button>();

//weapons
boolean shotgun = false;
boolean shotgun2 = false;
boolean shotgun3 = false;
boolean shotgun4 = false;
boolean smg = false;
boolean smg2 = false;
boolean rpg = false;
boolean revolver = false;

SoundFile shoot;
SoundFile collect;
SoundFile explosion;

PImage flankerenemy;
PImage player;
PImage normalenemy;
PImage shotgunIM;
PImage healthpackIM;
PImage handgunIM;
PImage revolverIM;

void setup()
{
  fullScreen();
  //size(300,300);
  
  background(0);
  
  //create intitial enemies
  for (int c = 0; c < initialenemies; c++)
  {
    enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(1,3))));
  }
  
  for (int c = 0; c < 10; c ++)
  {
    coins.add(new coin(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000))));
  }
  
  //buttons
  play = new Button("Resume",width/2-30,height-200, 0, false, 0);
  
  //shop
  shotgunbuy = new Button("Buy Shotgun: 80 coins",200,400, 80, false, 1);
  shotgunbuy2 = new Button("Buy Shotgun upgrade: 100 coins",200,400, 100, false, 1);
  shotgunbuy3 = new Button("Buy Shotgun upgrade2: 150 coins",200,400, 150, false, 1);
  shotgunbuy4 = new Button("Buy Shotgun upgrade3: 450 coins",200,400, 450, false, 1);
  turretbuy = new Button("Buy Turret: 30 coins",200,480, 30, false, 0);
  smgbuy = new Button("Buy SMG: 50 coins", 200, 360, 50, false, 0);
  smgbuy2 = new Button("Buy SMG Upgrade: 140 coins", 200, 360, 140, false, 0);
  revolverbuy = new Button("Buy Revolver: 30", 200, 440, 30, false, 3);
  rpgbuy = new Button("Buy RPG: 200 coins", 200, 440, 200, false, 0);
  healthpackbuy = new Button("Buy healthpack: 2 coins", 200, 520, 2, false, 10);
  
  //inventory
  weapons.add(new Button("Handgun",width-400,360, 1, true, 2));
  
  //images
  player = loadImage("Spaceship.png");
  normalenemy = loadImage("Normal Enemy.png");
  flankerenemy = loadImage("Alternate Enemy.png");
  shotgunIM = loadImage("Shotgun.png");
  healthpackIM = loadImage("Healthpack.png");
  handgunIM = loadImage("Handgun.png");
  revolverIM = loadImage("Revolver.png");
  
  shoot = new SoundFile(this, "Stapler.mp3");
  collect = new SoundFile(this, "collect.mp3");
}

void draw()
{
  background(0);
  
  //making a gameover screen
  if (gameover)
  {
    textSize(100);
    fill(255,0,0);
    text("YOU DIED!", width/2-175, height/2+50);
    textSize(30);
    text("Final Score = " + (score + (turrets*20) + (kills/4)), width/2-175, height/2 + 100);
  }
  
  //starts draw over skipping all the other things
  if (gameover) return;
  
  if (godmode) playerhalth = 10;
  
  if (mousedown && selectedweapon == 2 && cooldown == 0 && !menu)
  {
    cooldown = 5;
    
    float targetX = mouseX - width / 2 + playerx;
    float targetY = mouseY - height / 2 + playery;
    
    projectiles.add(new Projectile(playerx + 20, playery + 20, targetX, targetY, 1, 1, 5));
    
    if (smg2)
    {
      float aimx = mouseX - width / 2 + playerx;
      float aimy = mouseY - height / 2 + playery;
      
      float invertedx = playerx * 2 - aimx;
      float invertedy = playery * 2 - aimy;
      projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx, invertedy, 1, 2, 5));
    }
  }
  
  if (mousedown && selectedweapon == 3 && cooldown == 0 && !menu && shotgun4)
  {
    float targetX = mouseX - width / 2 + playerx;
    float targetY = mouseY - height / 2 + playery;
    //shoots three shots forward
    if (shotgun)
    {
      projectiles.add(new Projectile(playerx + 20, playery + 20, targetX, targetY, 1, 3, 5));
      projectiles.add(new Projectile(playerx + 20, playery + 20, targetX+50, targetY-50, 1, 3, 5));
      projectiles.add(new Projectile(playerx + 20, playery + 20, targetX-50, targetY+50, 1, 3, 5));
    }
    
    //shoots three shots backwards
    if (shotgun2)
    {  
      float invertedx = playerx * 2 - targetX;
      float invertedy = playery * 2 - targetY;
      projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx, invertedy, 1, 3, 5));
      projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx+50, invertedy-50, 1, 3, 5));
      projectiles.add(new Projectile(playerx + 20, playery + 20, invertedx-50, invertedy+50, 1, 3, 5));
    }
    
    cooldown = 5;
  }
  
  //creating enemies every specific frame count
  if (!paused)
  {
    if (rpg && frameCount % 30 == 5 && enemies.size() < 400)
    {
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(4,6))));
    }
    if (smg && frameCount % 60 == 32 && enemies.size() < 200)
    {
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(1,3))));
    }
    if (shotgun2 && frameCount % 30 == 10 && enemies.size() < 200)
    {
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(2,4))));
    }
    
    if (shotgun && frameCount % 50 == 30 && enemies.size() < 200)
    {
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(1,3))));
      coins.add(new coin(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000))));
    }
    
    if (frameCount % 80-turrets == 0 && enemies.size() < 300)
    {
      enemies.add(new Enemy(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000)), int(random(0,2)), int(random(1,3))));
    }
    
    if (frameCount % 50 == 0 && enemies.size() < 500) 
    {
      coins.add(new coin(int(random(playerx-1000,playerx+1000)), int(random(playery-1000,playery+1000))));
    }
  }
  
  // Move player based on keys
  for (int c = 0; c < Key.size(); c++)
  {
    if (!paused)
    {
      if (Key.get(c) == 'w') playery -= movement;
      if (Key.get(c) == 's') playery += movement;
      if (Key.get(c) == 'a') playerx -= movement;
      if (Key.get(c) == 'd') playerx += movement;
    }
  }
  
  // Translate the world so player appears in center
  translate(width/2 - playerx, height/2 - playery);
  
  //draw coins
  ArrayList<coin> coincopy = new ArrayList<coin>(coins);
  for (coin C : coincopy)
  {
    if (!paused) C.tick();
    C.display();
  }
  
  // Draw enemies
  ArrayList<Enemy> enemycopy = new ArrayList<Enemy>(enemies);
  for (Enemy E : enemycopy)
  {
    if (!paused) E.tick();
    E.display();
  }
  
  //draw projectiles
  ArrayList<Projectile> projectilecopy = new ArrayList<Projectile>(projectiles);
  for (Projectile A : projectilecopy)
  {
    if (!paused) A.tick();
    A.display();
  }
  
  for (int i = missiles.size() - 1; i >= 0; i--) 
  {
    Missile m = missiles.get(i);
    m.update();
    m.render();
    if (m.isFinished()) 
    {
      missiles.remove(i);
    }
  }
  
  //fires a projectile x/second
  if (turrets > 0)
  {
    if (frameCount% (60/turrets) == 0)
    {
      turret();
    }
  }
  
  healthpack = new Button("Healthpacks:"+healthpacks,width-400,530,0,false, 10);
  
  // Draw player at (playerx, playery)
  fill(#0700FC);
  image(player, playerx, playery, 60, 60);
  fill(255);
  textSize(20);
  text("Player Health = "+playerhalth, playerx - 900, playery-500);
  text("Score = "+score, playerx - 900, playery-470);
  if (godmode) text("debug:true",playerx-900,playery-440);
  else text("debug:false",playerx-900,playery-440);
  text("debug:"+enemies.size(),playerx-900,playery-410);
  
  if (playerhalth <= 0 && healthpacks == 0)
  {
    gameover = true;
  }
  else if (playerhalth <= 0 && healthpacks > 0)
  {
    playerhalth += 3;
    healthpacks --;
  }
  
  pushMatrix();
    resetMatrix();
    if (menu)
    {
      //shop
      play.display();
      if (!shotgun)
      {
        shotgunbuy.display();
      }
      else if (!shotgun2 && shotgun)
      {
        shotgunbuy2.display();
      }
      else if (!shotgun3 && shotgun2)
      {
        shotgunbuy3.display();
      }
      else if (!shotgun4 && shotgun2)
      {
        shotgunbuy4.display();
      }
      if (turrets < 60)
      {
        turretbuy.display();
      }
      if (!smg)
      {
        smgbuy.display();
      }
      else if (!smg2 && smg)
      {
        smgbuy2.display();
      }
      if (!revolver)
      {
        revolverbuy.display();
      }
      else if (!rpg && revolver)
      {
        rpgbuy.display();
      }
      healthpackbuy.display();
      
      //inventory
      for (Button b: weapons)
      {
        b.display();
      }
      healthpack.display();
    }
  popMatrix();
  
  if (cooldown > 0) cooldown --;
}
