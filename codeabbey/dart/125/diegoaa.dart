/*
$ dartanalyzer --lints --options analysis-options.yaml diegoaa.dart #linting
Analyzing diegoaa.dart...
No issues found!
*/

import "dart:convert";
import "dart:io";
int randomizer(seed) {
  List rightNumber = seed.toString().padLeft(6, '0').split("");
  String right = rightNumber.sublist(0, 3).join("");
  String left = (seed % 1000).toString();
  String y = left + right;
  dynamic product = int.parse(y) * seed;
  if (product.toString().length != 12) {
    product = (product.toString().padLeft(12, '0'));
  }
  List array = product.toString().split("");
  int x = int.parse((array.sublist(3, 9).join("")));
  return x;
}
bool isSorted(arr) {
  for (var i = 1; i < arr.length; i++) {
    if (arr[i - 1] > arr[i]) {
      return false;
    }
  }
  return true;
}
var result = "";
void bogosort(arr, seed) {
  int counter = 0;
  while (counter < 5040) {
    for (var i = 0; i < arr.length; i++) {
      seed = randomizer(seed);
      int j = seed % arr.length;
      int temp = arr[i];
      int temp2 = arr[j];
      arr[i] = temp2;
      arr[j] = temp;
    }
    if (isSorted(arr)) {
      result = result + (counter + 1).toString() + ' ';
      break;
    }
    counter++;
  }
  if (counter == 5040) {
    result = result + "-1 ";
  }
}
main() {
  final List<String> source = File("DATA.lst").readAsLinesSync(encoding: utf8);
  for (int i = 1; i < source.length; i++) {
    List<int> array = source[i].split(" ").map((n) => int.parse(n)).toList();
    const seed = 918255;
    bogosort(array, seed);
  }
  print(result);
}

/*
$ dart diegoaa.dart
-1 -1 -1 -1 2305 3619 -1 2054 -1 -1 -1 1154 3313
*/
