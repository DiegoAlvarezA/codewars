/*
$ dartanalyzer --lints --options analysis-options.yaml diegoaa.dart #linting
Analyzing diegoaa.dart...
No issues found!
*/

import "dart:convert";
import "dart:io";
List<int> path = [];
bool printPath(Node root, int dest) {
  if (root == null) {
    return false;
  }
  if (root.id == dest ||
    printPath(root.left, dest) ||
    printPath(root.right,dest)) {
    path.add(root.id);
    return true;
  }
  return false;
}
void main() {
  final List<String> source = File("DATA.lst").readAsLinesSync(encoding: utf8);
  var map = Map<int, int>();
  String text = "ABRACADABRA";
  text.runes.forEach((int rune) {
    if (map.containsKey(rune)){
      map[rune] = map[rune] + 1;
    }
    else {
      map[rune] =  1;
    }
  });
  var sortedEntries = map.entries.toList()..sort((e1, e2) {
    var diff = e2.value.compareTo(e1.value);
    if (diff == 0) {
      diff = e2.key.compareTo(e1.key);
    }
    return diff;
  });
  var newMap = Map<int, int>.fromEntries(sortedEntries);
  final List<Node> nodes = List.generate(newMap.length, (i) => Node
    (sortedEntries[i].key));
  while (nodes.length != 1) {
    List<Node> children = nodes.skip(nodes.length - 2).toList();
    var idLeft = children[0].left == null ?
      newMap[children[0].id] : children[0].id;
    var idRight = children[1].left == null ?
      newMap[children[1].id] : children[1].id;
    var sum = idLeft + idRight;
    var newNode = Node(sum);
    newNode.left = children[0];
    newNode.right = children[1];
    nodes.removeRange(nodes.length-2, nodes.length);
    int index = nodes.indexWhere((node) {
      var id = node.left == null || node.right == null ?
        newMap[node.id] : node.id;
      return id < newNode.id;
    });
    if (index != -1) {
      nodes.insert(index, newNode);
    }
    else {
      nodes.add(newNode);
    }
  }
  var compressedSize = 0;
  newMap.forEach((k,v) {
    printPath(nodes[0],k);
    var length = path.length - 1;
    compressedSize += length * v;
    path = [];
  });
  var originalSize = text.length * 8;
  var ratio = (originalSize / compressedSize );
  print(ratio.toStringAsFixed(10));
}
class Node {
  Node(this.id);
  final int id;
  Node parent;
  Node left;
  Node right;
  @override
  String toString() => '$id: (${left?.id ?? '_'}, ${right?.id ?? '_'})';
}

/*
$ dart diegoaa.dart
1.9435736677
*/
