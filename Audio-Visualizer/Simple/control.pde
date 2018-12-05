
public void playPause() {
  started = true;
  if (player.isPlaying()) {
    player.pause();
    paused = true;
  } else {
    player.play();
    paused = false;
  }
}

public void rewind() {

  if (player.position() == 0) {
    if (songNum == 0) {
      songNum = mp3s.size()-1;
    } else {
      songNum--;
    }
    player = minim.loadFile(albums.get(albumNum)+'/'+mp3s.get(songNum)+".mp3");
    fft = new FFT(player.bufferSize(), player.sampleRate());
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
}
