import 'dart:collection';
import "dart:convert";
import "dart:io";
  final List<String> source = File("DATA.lst")
      .readAsLinesSync(encoding: utf8)
      .where((word) => word.length == 5).toList();

List findOcurrences(c1, queue) {
  List<String> match = [];
  for (final word in source) {
        if (!queue.contains(word)){
          int counter = 0;
          for (int i = 0; i < 5; i++) {
            //print((visited.last)[0]);
            if (word[i] == c1[i]){
              counter++;
            }
          }
          if (counter==4){
            match.add(word);
          }
        }
    }
  return match;
}



main() {

  var list = [];
  int minimumLength = null;
  int globalweight = 0;
  int simil = 0;
  List<String> queue = [];
  List<String> visited = [];
  //String start = "miner";
  String start = "mayor";
  String finalWord = "mines";
  List<String> occurrencesByWord = [];
  // for (int i = 0; i < source.length; i++) {
  //   if (i < 5){
  //     source[i].runes.forEach((int rune) {
  //     var character = new String.fromCharCode(rune);
  //     print(character);
  //   });
  //   }
  // }
  //source.remove(start);
  queue.add(start);
  //print(source.indexOf(start));
  //source[source.indexOf(start)] = "";
  //while (globalweight != 5){
    globalweight = 0;
    int weight = 0;
    //print(start);
  //while (!queue.contains(finalWord)) {
  //   for (final visitedWord in queue) {
  //     var ocurrences = findOcurrences(start, queue);
  //     while (!ocurrences.contains(finalWord)) {
  //       for (final ocurrence in ocurrences) {

  //       }
  //     }
  //     print(ocurrences);
  // }
//}
  // for (final word in occurrencesByWord) {
  //   print(word);
  //   int occurrence = findOcurrences(word, finalWord);
  //   print(occurrence.toString() + "----------------------");
  // }
    // if (occurrencesByWord.length == 1) {
    //   start = occurrencesByWord[0];
    //   source[source.indexOf(start)] = "";
    // } else {
    //   int greatestOccurrence = 0;
    //   for (final word in occurrencesByWord) {
    //     int occurrence = findOcurrences(word, finalWord);
    //     if (occurrence > greatestOccurrence) {
    //       greatestOccurrence = occurrence;
    //       start = word;
    //     }
    //   }
    //   print(greatestOccurrence);
    //   simil = greatestOccurrence;
    //   print(start);
    //   //source[source.indexOf(start)] = "";
    // }
  //}
  //print('major'.codeUnitAt(2));
  //print('mayor'.codeUnitAt(2));
  //print(list);
verify(List lista, queue) {
    print("Queue: " + queue.toString());
    print("hijos:        " + lista.toString());
    if (!lista.contains(finalWord)) {
    for (int i = 0; i < lista.length; i++) {
      print(i.toString() + lista[i]);
      //List newQ = new List<String>.from(queue);
      queue.add(lista[i]);
      List matches = findOcurrences(lista[i], queue);

      //print("Sub queue:                   "+newQ.toString());
      //print(i);
        if (verify(matches, queue)){
          //newQ.add(finalWord);
          print("path encontrado");
          queue.add(lista[i]);
          print(queue);
          print("------------------------------------");
          return true;
        } else {
          //queue.add(lista[i]);
          List matches = findOcurrences(lista[i], queue);
          verify(matches, queue);
        }
      }
    } else {
      print("FINAL Queue: " + queue.toString());
      return true;
    }
  }
 List matches = findOcurrences(start, queue);
 verify(matches, queue);
}
