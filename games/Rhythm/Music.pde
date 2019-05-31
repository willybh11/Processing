
public void luvuneedu(int start) {

	println("made it");
	// start += 3000;

	for (int i = 0; i < 65; i += 32) {
		hits.add(new Hit(i + 1.75,	left,start - 400));
		hits.add(new Hit(i + 2.75,	left,start - 400));
		hits.add(new Hit(i + 4.0,	right,start - 400));
		hits.add(new Hit(i + 4.75,	left,start - 400));
		hits.add(new Hit(i + 5.5,	right,start - 400));
		hits.add(new Hit(i + 6.75,	left,start - 400));
		hits.add(new Hit(i + 7.25,	right,start - 400));
		hits.add(new Hit(i + 8.25,	left,start - 400));
		hits.add(new Hit(i + 9,		left,start - 400));
		hits.add(new Hit(i + 9.75,	right,start - 400));
		hits.add(new Hit(i + 10.25,	left,start - 400));
		hits.add(new Hit(i + 11.25,	right,start - 400));
		hits.add(new Hit(i + 12.25,	left,start - 400));
		hits.add(new Hit(i + 13.0,	left,start - 400));
		hits.add(new Hit(i + 13.75,	left,start - 400));
		hits.add(new Hit(i + 14.75,	right,start - 400));
		hits.add(new Hit(i + 15.25,	right,start - 400));
		hits.add(new Hit(i + 16,	left,start - 400));
		hits.add(new Hit(i + 17,	left,start - 400));
		if (i==64) break;
		hits.add(new Hit(i + 17.75,	right,start - 400));
		hits.add(new Hit(i + 18.25,	left,start - 400));
		hits.add(new Hit(i + 19.25,	left,start - 400));
		hits.add(new Hit(i + 20.25,	right,start - 400));
		hits.add(new Hit(i + 21,	right,start - 400));
		hits.add(new Hit(i + 21.75,	left,start - 400));
		hits.add(new Hit(i + 22.75,	right,start - 400));
		hits.add(new Hit(i + 23.25,	left,start - 400));
		hits.add(new Hit(i + 24.25,	left,start - 400));
		hits.add(new Hit(i + 25,	right,start - 400));
		hits.add(new Hit(i + 25.75,	left,start - 400));
		hits.add(new Hit(i + 26.25,	right,start - 400));
		hits.add(new Hit(i + 27.25,	left,start - 400));
		hits.add(new Hit(i + 28.25,	left,start - 400));
		hits.add(new Hit(i + 29,	right,start - 400));
		hits.add(new Hit(i + 29.75,	left,start - 400));
		hits.add(new Hit(i + 30.75,	right,start - 400));
		hits.add(new Hit(i + 31.25,	right,start - 400));
		hits.add(new Hit(i + 32,	left,start - 400));
		hits.add(new Hit(i + 32.75,	left,start - 400));
	}

	for (float i = 82.0; i < 90; i++) {
		hits.add(new Hit(i, right,start - 400));
		hits.add(new Hit(i + 0.5, left,start - 400));
	}

	for (float i = 90.0; i < 94; i+=0.5) {
		hits.add(new Hit(i, right,start - 400));
		hits.add(new Hit(i + 0.25, left,start - 400));
	}


}