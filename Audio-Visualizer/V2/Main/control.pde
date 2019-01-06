
public void autoPlay() {
 if (player.position() > player.length() - 500 && songNum != mp3s.size()-1)
   fastForward();
}

public void enter() {
  if (player != oldPlayer)
    oldPlayer.pause();
  if (inAlbum) playPause();
  else {
    inAlbum = true;
    getSongs();
  }
}

public void playPause() {
  if (player.isPlaying())
    player.pause();
  else
    player.play();
}

public void rewind() {

  if (player.position() == 0) {
    if (songNum == 0)
      songNum = mp3s.size()-1;
    else
      songNum--;

    player = minim.loadFile(albums.get(albumNum)+'/'+mp3s.get(songNum)+".mp3");
    fft = new FFT(player.bufferSize(), player.sampleRate());
    
    player.play();
  } else {
    player.rewind();
    player.pause();
  }
}

public void fastForward() {
  player.pause();
  if (songNum == mp3s.size()-1) {
    songNum = 0;
  } else {
    songNum++;
  }
  player = minim.loadFile(albums.get(albumNum)+'/'+mp3s.get(songNum)+".mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  player.play();
}
