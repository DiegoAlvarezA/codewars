/*
$ dartanalyzer --lints --options analysis-options.yaml diegoaa.dart #linting
Analyzing diegoaa.dart...
No issues found!
*/

import "dart:convert";
import "dart:io";
bool findOccurrences(string1, string2) {
  int counter = 0;
  for (int i = 0; i < 5; i++) {
    if (string1[i] == string2[i]){
      counter++;
    }
  }
  return counter == 4;
}
void main() {
  final List<String> source = File("DATA.lst")
    .readAsLinesSync(encoding: utf8)
    .where((word) => word.length == 5).toList();
  List<String> testCases = [];
  List<String> visited = [];
  List<Path> queue = [];
  String result = "";
  void findPath(start, end) {
    while (queue.isNotEmpty) {
      Path path = queue.first;
      queue.removeAt(0);
      if (end == path.currentPath.last) {
        result += "${path.currentPath.length.toString()} ";
        visited = [];
        queue = [];
        break;
      }
      for (int i = 0; i < source.length; i++) {
        if (!visited.contains(source[i])) {
          if (findOccurrences(source[i], path.currentPath.last)) {
            List<String> list = List<String>.from(path.currentPath);
            list.add(source[i]);
            queue.add(Path(list));
            visited.add(source[i]);
          }
        }
      }
    }
  }
  String numTests = stdin.readLineSync();
  for (int i = 0; i < int.parse(numTests); i++) {
    String testCase = stdin.readLineSync();
    testCases.add(testCase);
  }
  for (int i = 0; i < int.parse(numTests); i++) {
    String start = testCases[i].split(" ")[0];
    String end = testCases[i].split(" ")[1];
    visited.add(start);
    queue.add(Path([start]));
    findPath(start, end);
  }
  print(result);
}
class Path {
  Path(this.currentPath);
  final List<String> currentPath;
  List<String> get getCurrentPath => currentPath;
}

/*
$ dart diegoaa.dart
input:
12
horns stats
forks token
seams baaed
nosed forgo
teach hinds
ferry sites
crest swags
peaks river
harts bided
joker cadge
weeds nears
lifer hasty
output:
7 6 8 9 11 9 8 7 6 13 5 9
*/
