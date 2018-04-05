public void winCheck() {
  if ( (time/60 >= levelLimits[level-1]) && (gameStatus != "lost") ) {

    textBox("lvl "+level+" -> "+(level+1));

    if (winBox.x >= 720) {
      level++;
      time = 0;
      gameStatus = "ongoing";
      winBox.x = -800;
      addEnemies();
      p1.addLife();
      timeOfDamage = -3;
    }
  }
}