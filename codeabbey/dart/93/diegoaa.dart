/*
$ dartanalyzer --lints --options analysis-options.yaml diegoaa.dart #linting
Analyzing diegoaa.dart...
No issues found!
*/

import "dart:convert";
import "dart:io";
int findVisitorPosition(List<int> queue) {
  int index = 0;
    for (int i = 1; i < queue.length; i++) {
      if (queue[i] != null && queue[index] == null) {
        index = i;
        continue;
      }
      if (queue[i] != null && queue[index] != null) {
        if (queue[i] > queue[index]) {
          index = i;
        }
      }
    }
  return index;
}
void main() {
  final List<String> source = File("DATA.lst").readAsStringSync(encoding: utf8)
    .split(" ");
  const int A = 445;
  const int C = 700001;
  const int M = 2097152;
  final int N = int.parse(source[0]);
  int xn = int.parse(source[1]);
  final List<int> queue = [];
  int totalDiscomfort = 0;
  int leftVisitors = N;
  int t = 0;
  while(leftVisitors > 0){
    if (t % 2 == 0 && t > 0) {
      int visitorPosition = findVisitorPosition(queue);
      totalDiscomfort += queue[visitorPosition] * (t - visitorPosition);
      queue[visitorPosition] = null;
      leftVisitors--;
    }
    if (t < N) {
      int linearCongruential = (A * xn + C) % M;
      int starvationDegree = (linearCongruential % 999) + 1;
      xn = linearCongruential;
      queue.add(starvationDegree);
    }
    t++;
  }
  print(totalDiscomfort);
}

/*
$ dart diegoaa.dart
11153064781
*/
