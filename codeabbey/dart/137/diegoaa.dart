List divideList(List list) {
  var j = 0;
  if (list.length == 2){
    return [list[0], list[1]];
  } else {
    var sum = 0;
    list.forEach((e) => sum+=e[1]);
    var x = 0;
    var d = (2*x - sum).abs();
    for (int i=0; i<list.length; i++) {
      x += list[i][1];
      if (d < (2*x - sum).abs()) {
        j = i;
      }
    }
  }
  return [list.sublist(0,j+1), list.sublist(j+1)];
}
void main() {
  var map = Map<int, int>();
   //String text = "ABRACADABRA";
  String text = """back into my chair. "It is both, or none," said he. "You may say bowed, and, turning away without observing the hand which the specimen of the London slavey. As to your practice, if a "She will not sell." deduce it. As to Mary Jane, she is incorrigible, and my wife has of campaign. landau when a cab came through the street. The driver looked""";
  String result = "";
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
    if (diff > 0) {
      diff = e1.key.compareTo(e2.key);
    }
    return diff;
  });
  var newMap = Map<int, int>.fromEntries(sortedEntries);
  final List nodes = List.generate(newMap.length, (i) => [sortedEntries[i].key,
  sortedEntries[i].value, " "]);
  void tagList(List list) {
  List divided = divideList(list);
  List right = divided[0];
  List left = divided[1];
  try {
  right.forEach((e) {
    e[2] += "O";
    var index = nodes.indexWhere((node) {
      return node[0] == e[0];
    });
    nodes[index][2] = e[2];
  });
  left.forEach((e) {
    e[2] += "I";
    int index = nodes.indexWhere((node) {
      return node[0] == e[0];
    });
    nodes[index][2] = e[2];
  });
  tagList(right);
  tagList(left);
  } catch (e) {
    var index = nodes.indexWhere((node) {
      return node[0] == right[0];
    });
    nodes[index][2] = right[2] + "O";
    index = nodes.indexWhere((node) {
      return node[0] == left[0];
    });
    nodes[index][2] = left[2] + "I";
    return;
  }
}
tagList(nodes);
nodes.forEach((e) {
  result += "${e[0]}${e[2]} ";
});
print(result);
print(sortedEntries);
}
