class Button
{
  String text;
  int x,y, value;
  float w;
  boolean selected;
  int imagenum;
  
  Button(String temptext, int tempx, int tempy, int tempbv, boolean select,int tempimagenum)
  {
    text = temptext;
    x = tempx;
    y = tempy;
    value = tempbv;
    textSize(32);
    w = textWidth(text) + 10;
    selected = select;
    imagenum = tempimagenum;
  }
  
  void display()
  {
    if(!ishovered()) fill(40);
    
    else fill(120);
    
    if (selected) fill(255);
    
    rect(x,y, w, 40);
    
    if (!selected) fill(255);
    
    else fill(0);
    
    text(text, (x+w/5)+10,y+27);
    
    if (imagenum == 1)
    {
      image(shotgunIM, x,y+5);
    }
    else if (imagenum == 10)
    {
      image(healthpackIM, x+4,y+5);
    }
    else if (imagenum == 2)
    {
      image(handgunIM, x,y+5);
    }
    else if (imagenum == 3)
    {
      image(revolverIM, x,y+5);
    }
  }
  
  boolean ishovered()
  {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y + 40)
    {
      return(true);
    }
    else 
    {
      return (false);
    }
  }
}
