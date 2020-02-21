String path_dossier = "/home/nicolas/boulot/memory_trainer/premiers_ministres";

float DIMENSION = 500;
float[][] les_spots = { {21 * DIMENSION / 8, 3 * DIMENSION / 8, DIMENSION / 4}, {2 * DIMENSION, DIMENSION / 4, DIMENSION / 2 }, {9 * DIMENSION / 8, DIMENSION / 8, 3 * DIMENSION / 4}, {DIMENSION / 2, DIMENSION / 4, DIMENSION / 2}, {DIMENSION / 8, 3 * DIMENSION / 8, DIMENSION / 4}, {-1 * DIMENSION / 8, DIMENSION / 2, 0} };

boolean defilement_actif = false;

Train le_train;


class Image{
  String nom;
  int rang;
  float x, y, largeur;
  String path;
  PImage img;

  Image(String le_path){
    rang = 0;
    x = 21 * DIMENSION / 8;
    y = 3 * DIMENSION / 8;
    largeur = DIMENSION / 4;
    path = le_path;
    img = loadImage(path);
  }

  void display(){
    image(img, x, y, largeur, largeur);
  }

  public void finalize(){
  }

  void maj_rang(){
    if (x < les_spots[rang + 1][0]){
      rang = rang + 1;
    };
  }

  void bouge(){
    if (rang == 5){
      rang = 0;
      x = 21 * DIMENSION / 8;
      y = 3 * DIMENSION / 8;
      largeur = DIMENSION / 4;
    }
    //On recouvre l'image précédente
    noStroke();
    rect(x - 1, y - 1, largeur + 2, largeur + 2);
    fill(255);
    float dx = (les_spots[rang + 1][0] - les_spots[rang][0]) / 30;
    float dy = (les_spots[rang + 1][1] - les_spots[rang][1]) / 30;
    float dl = (les_spots[rang + 1][2] - les_spots[rang][2]) / 30;
    x = x + dx;
    y = y + dy;
    largeur = largeur + dl;
    maj_rang();
  }
}




class Train{
 Image[] les_images;
 int longueur;

 Train(String nom_dossier){
   File folder = new File(path_dossier);
   File[] liste_fichiers = folder.listFiles();
   Image[] image_buffer = new Image[liste_fichiers.length];
   for (int i = 0; i < liste_fichiers.length; i++){
   image_buffer[i] = new Image(path_dossier + "/" + liste_fichiers[i].getName());
   }
   longueur = liste_fichiers.length;
   les_images = image_buffer;
  }

  void initialise_affichage(){
    assert longueur > 4:" Pas assez d'image";
    for (int i=0; i < 5; i++){
      les_images[i].x = les_spots[i][0];
      les_images[i].y = les_spots[i][1];
      les_images[i].largeur = les_spots[i][2];
      les_images[i].display();
      les_images[i].rang = i;
    }
  }

  void train_display(){
    for (int i=0; i < 5; i++){
      les_images[i].display();
    };
  }

  void defile(){
    for (int i=0; i < 5; i++){
      les_images[i].bouge();
    }
  }
}



void setup(){
  smooth();
  background(255);
  size(1500, 500);
  le_train = new Train(path_dossier);
  le_train.initialise_affichage();
}


void draw(){
  if (defilement_actif){
    le_train.defile();
  };
  le_train.train_display();
}

void keyPressed(){
  if (key == 'a'){
    defilement_actif = true;
  };
}

void keyReleased(){
  defilement_actif = false;
}
