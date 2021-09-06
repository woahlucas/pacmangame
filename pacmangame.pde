int [] [] M = new int [30][30]; //<>//

//posição inicial do pacman
int m, n;

//direção do pacman (se tá olhando pra direita, esquerda, cima ou baixo
int dir;

//jogo começa
boolean start = false;

void setup() {
  size(600, 600);

  colorMode(HSB, 360, 100, 100);
  //posição inicial = meio da tela
  m = width/2;
  n = height/2;
  dir = 0;
  textAlign(CENTER);
  textSize(40);
}



void draw() {
  //a célula em que o pacman estiver vai se tornar somente preta
  M[m/30][n/30] = 0;
  background(200);
  percorrerMatriz();
  desenharPacman();
  if (start) {
    noStroke();
    //explicação no final do código
    if (!contem(2, M)) {
      telaFinal();
    }
  }
}


void percorrerMatriz() {
  for (int i = 0; i < 30; i++) {
    for (int j = 0; j < 30; j++) {
      //todos os elementos da matriz possuem zero de início, então a tela começa com tudo preto
      if (M[i][j] == 0) {

        fill(10);
        rect(i*30, j*30, 30, 30);
      }
      //ao clicar com o botão esquerdo no mousepressed, o valor da célula se torna 1 e verde
      if (M[i][j] == 1) {

        fill(#95E600);
        rect(i*30, j*30, 30, 30);
      }
      // ao pressionar enter no Keypressed, a célula recebe 2 e frutinhas aparecem
      if (M[i][j] == 2) {
        fill(10);
        rect(i*30, j*30, 30, 30);
        fill(#500E96);
        circle(i*30+15, j*30+15, 10);
      }
    }
  }
}




/*clicar e arrastar para desenhar ou apagar. esquerdo é verde (1) 
e direito é preto (0)

Obs: tive que fazer tanto um mouseDragged quanto um mousePressed, pois apenas com 
o mouseDragged não dava pra clicar apenas uma vez pra fazer um único quadradinho, tinha
que arrastar*/
void mouseDragged() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
  if (start == false){
    if (mouseButton == LEFT)
      M[mouseX/30][mouseY/30] = 1;
    if (mouseButton == RIGHT)
      M[mouseX/30][mouseY/30] = 0;
  }
}
}
void mousePressed() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
  if (start == false){
    if (mouseButton == LEFT)
      M[mouseX/30][mouseY/30] = 1;
    if (mouseButton == RIGHT)
      M[mouseX/30][mouseY/30] = 0;
  }
}
}

void keyPressed() {
  //ao pressionar enter, frutinhas aparecem onde não tem parede (M[i][j] != 1)
  if (keyCode == ENTER) {
    start = true;
    for (int i = 0; i <= 19; i++) {
      for (int j = 0; j <= 19; j++) {
        if (M[i][j] != 1)
          M[i][j] = 2;
      }
    }
  }

  // faz o pacman andar, respeitando os limites da tela e das paredes e informando a direção

  if (keyCode == LEFT && m > 0 && M[m/30-1][n/30] != 1 && start) {
    dir = 0;
    m = m - 30;
    M[m/30][n/30] = 0;
  } else if (keyCode == RIGHT && m < width-30 && M[m/30+1][n/30] != 1 && start) {
    dir = 1;
    m = m + 30;
    M[m/30][n/30] = 0;
  } else if (keyCode == UP && n > 15 && M[m/30][n/30-1] != 1 && start) {
    dir = 2;
    n = n - 30;
    M[m/30][n/30] = 0;
  } else if (keyCode == DOWN && n < height-30 && M[m/30][n/30+1] != 1 && start) {
    dir = 3;
    n = n + 30;
    M[m/30][n/30] = 0;
  }
}


// desenha o pacman
void desenharPacman() {
  fill(#FFFF19);
  if (start) {
    if (dir ==0) {
      arc(m+15, n+15, 30, 30, radians(-135), radians(135));
      fill(10);
      circle(m+15, n+6, 5);
    }
    if (dir ==1) {
      arc(m+15, n+15, 30, 30, radians(40), radians(315));
      fill(10);
      circle(m+15, n+6, 5);
    }
    if (dir ==2) {
      arc(m+15, n+15, 30, 30, radians(-45), radians(225));
      fill(10);
      circle(m+15+8, n+15, 5);
    }
    if (dir ==3) {
      arc(m+15, n+15, 30, 30, radians(-225), radians(45));
      fill(10);
      circle(m+15+8, n+15, 5);
    }
  }
}

//ao comer todas as frutinhas, uma tela final aparece. (só aparece depois do start ser verdadeiro)
void telaFinal() {
  fill(0, 0, 0);
  rect(0, 0, width, height);
  fill(#510E96);
  circle(width/2, height/2.5, 200);
  fill(0, 0, 0);
  for (int i = 0; i < height; i = i +10) {
    rect(0, height/2.5+i, width, 5);
  }
  arc(width/2, height/3, 30, 30, radians(40), radians(315));
  fill(#510E96);
  text("Fim de jogo!", width/2, height/1.4);
  stroke(1);
}

/*já que 2 representa as frutas, basta checar a presença de 2 na matriz M, se não
 tiver, quer dizer que todas as frutas foram comidas
 
 a função abaixo retorna true se M contém 2 e falso se não contémeu chamei a função no draw dando o valor 2 para o primeiro argumento e a matriz M
 como segundo argumento. ao retornar falso, eu sei que o jogo acabou e posso mostrar 
 a mensagem de game over*/
  boolean contem( int l, int[][] matriz2d) {
  for ( int[] matriz1d : matriz2d)  for ( int v : matriz1d)
    if (v == l)  return true;
  return false;
}
