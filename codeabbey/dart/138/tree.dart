import 'dart:math';

const maxNodes = 10;

void main() {
  final rng = Random();
  print("Main random" + rng.toString());
  final nodes = List.generate(maxNodes, (index) => Node(index + 1));
  print(nodes);
  final openNodes = [nodes[0]];
  nodes.skip(1).forEach((node) {
    var rand = rng.nextInt(openNodes.length);
    print("Next random " +rand.toString());
    node.parent = openNodes[rand];
    print(node.parent);
    openNodes.add(node);
    if (node.parent.right != null ||
        (node.parent.left == null && rng.nextBool())) {
          print("has nextBool");
      node.parent.left = node;
    } else
      node.parent.right = node;
    if (node.parent.left != null && node.parent.right != null)
      openNodes.remove(node.parent);
    print("current open nodes: " + openNodes.toString());
    print("--------------------------------");
  });
  nodes.forEach(print);
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