combinationUtil(List arr, List data, int start, int end, int index, int r) {
if (index == r) {
  for (int j=0; j<r; j++) {
    print(data[j].toString()+" ");
  }

    print("\n");
  return;
}
  for (int i=start; i<=end && end-i+1 >= r-index; i++){
    data[index] = arr[i];
    combinationUtil(arr, data, i+1, end, index+1, r);
  }
}

printCombination(List arr, int n, int r) {
    List<int> data = new List(r);
      combinationUtil(arr, data, 0, n-1, 0, r);

}
main() {
  List<int> arr = [0, 1, 1, 2, 3];
  int r = 3;
  int n = arr.length;
  printCombination(arr, n, r);
}