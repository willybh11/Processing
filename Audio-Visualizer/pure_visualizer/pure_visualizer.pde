//this ones gonna analyze preexisting audio

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

void setup() {
 size(1124,800,P3D);
 minim = new Minim(this);
 in = minim.getLineIn();
 fft = new FFT(in.bufferSize(),in.sampleRate());
}

void draw() {
  background(0);
  waveform(in);
  //equalizer(fft,in);
  //levels(in);
}
