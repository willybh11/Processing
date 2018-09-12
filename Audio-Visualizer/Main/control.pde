
public void playPause() {
  if (player.isPlaying()) {
    player.pause();
  } else {
    player.play();
  }
}

public void rewind() {

  if (player.position() == 0) {
    if (songNum == 0) {
      songNum = mp3s.size()-1;
    } else {
      songNum--;
    }
    player = minim.loadFile(mp3s.get(songNum)+".mp3");
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
  player = minim.loadFile(mp3s.get(songNum)+".mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

public void mute() {
  if (!player.isMuted()) {
    player.mute();
  } else {
    player.unmute();
  }
}
