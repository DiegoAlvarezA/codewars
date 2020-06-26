import 'dart:math';

const maxNodes = 10;

void main() {
  var map = new Map<int, int>();
  String text = "DAVIDAHUFFMAN";
  //String text = """"Quite so;""";
  // String text = """"I am Mr. Holmes," answered my companion, looking at her with a put on seven and a half pounds since I saw you." you made me reveal what you wanted to know. Even after I became The man sprang from his chair and paced up and down the room in then?" The note was undated, and without either signature or address.""";
  text.runes.forEach((int rune) {
  //var character=new String.fromCharCode(rune);
  if (map.containsKey(rune)){
    map[rune] = map[rune] + 1;
  }
  else {
    map[rune] =  1;
  }
});
print(map);
  var sortedEntries = map.entries.toList()..sort((e1, e2) {
  var diff = e1.key.compareTo(e2.key);
  if (diff == 0) diff = e2.value.compareTo(e1.value);
  return diff;
});
var newMap = Map<int, int>.fromEntries(sortedEntries);
//print(map);
var sortedKeys = map.keys.toList()..sort();
//newMap.forEach((k,v) =>   print('${new String.fromCharCode(k)}: ${v}'));
newMap.forEach((k,v) =>   print('${k} ${new String.fromCharCode(k)}: ${v}'));
print(sortedEntries);

var number = 1.78561736770692 * 1e6;
print(number);

}