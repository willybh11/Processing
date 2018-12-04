
public int getHeight(FFT fft, int min, int max) {
  int n = 0;
  for (float i = min; i < max; i++) {
    n += fft.getFreq(i);
  }
  n = max(0, 400-n/80);
  return(n);
}

public void getSongs() {
  mp3s = new ArrayList<String>();
  for (String f : new File(dataPath(albums.get(albumNum))).list()) {
    if (f.endsWith(".mp3"))
      mp3s.add(split(f, ".mp3")[0]);
    println(albums.get(albumNum)+f);
  }
  player = minim.loadFile(albums.get(albumNum)+'/'+mp3s.get(songNum)+".mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
}
