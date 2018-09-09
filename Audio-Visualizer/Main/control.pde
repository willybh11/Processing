
public void playPause() {
  if (player.isPlaying()) {
    player.pause();
  } else {
    player.play();
  }
}

public void rewind() {
  temp = songNum; 
  
  if (player.position() == 0) {
    if (songNum == 0) {
      songNum = mp3s.size()-1;
    } else {
      songNum--;
    }
  } else {
    player.rewind();
    player.pause();
  }

  if (songNum != temp) {
    player = minim.loadFile(mp3s.get(songNum)+".mp3");
    fft = new FFT(player.bufferSize(), player.sampleRate());
  }
}

public void fastForward() {
  temp = songNum;
  player.rewind();
  player.pause();
  if (songNum == mp3s.size()-1) {
    songNum = 0;
  } else {
    songNum++;
  }
  if (songNum != temp) {
      player = minim.loadFile(mp3s.get(songNum)+".mp3");
      fft = new FFT(player.bufferSize(), player.sampleRate());
    }
}

public void mute() {
  if (!player.isMuted()) {
    player.mute();
  } else {
    player.unmute();
  }
}
