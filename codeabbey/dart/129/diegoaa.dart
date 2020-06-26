 permutaciones(String c) {
    List permu = [];
    for(int i=0; i<c.length; i++) {
      String sub = c.substring(i+1);
      if (i==0) {print(sub);}
      permutaciones(sub).runes.forEach((rune) {
        var character=new String.fromCharCode(rune);
        var string = c[i] + character;

        permu.add(string);
      });
    }
    print("??????????RETURN?????????????????");
    print(permu);
    return permu;
  }

main() {

  List<int> queue = [0, 1, 2, 3, 4, 5];
  // permutaciones(cadena c):
//         lista de permutaciones l inicia vacía
//         para letra_i en cadena c:
//           crea una cadena c' a partir de la cadena c, pero quitando letra_i
//           para cada p en permutaciones(c'):
//             agrega letra_i + p a la lista l
//       regresa la lista l



String permut = permutaciones("abcde");
print(permut);
print(permut.length);
 // print("abc".substring(0+1));

// "A string".runes.forEach((int rune) {
//   var character=new String.fromCharCode(rune);
//   print(character);
// });

}

