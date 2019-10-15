class Direction {
  static const N = [0, -1];
  static const E = [1, 0];
  static const S = [0, 1];
  static const W = [-1, 0];

  static get values => [N, E, S, W];

  final List<int> position;
  final num width;
  final num height;

  Direction(this.position, this.width, this.height);

  void traverseNeighbours(Function(List<int>) cb) {
    for (int i = 0; i < Direction.values.length; i++) {
      List<int> direction = Direction.values[i];
      List<int> newPosition = [
        position[0] + direction[0],
        position[1] + direction[1]
      ];
      if (newPosition[0] < 0 ||
          newPosition[1] < 0 ||
          newPosition[0] >= width ||
          newPosition[1] >= height) {
        continue;
      }
      cb(newPosition);
    }
  }
}
