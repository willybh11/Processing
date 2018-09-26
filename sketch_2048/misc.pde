

public boolean move(int curIndex, int nextIndex) {
  if (nums[curIndex] != 0) {
    if (nums[nextIndex] == 0) {
      nums[nextIndex] = nums[curIndex];
      nums[curIndex] = 0;
      return true;
    } else if (nums[curIndex] == nums[nextIndex]) {
      nums[curIndex] = 0;
      nums[nextIndex] *= 2;
      return true;
    }
  }
  return false;
}

public void add2() {
  while (true) {
    int n = int(random(0, 16));
    if (nums[n] == 0) {
      nums[n] = 2;
      break;
    }
  }
}
