class TextBox{

  float x_t;
  float y_t;
  String texte;

  TextBox(){
    x_t = 50;
    y_t = 50;
    texte = "";
  }

  void display(){
    texte = reponse;
    textSize(40);
    text(texte, x_t, y_t);
    fill(100, 0, 155);
  }
}
