import 'dart:html';

void main() {
  List<List<String>> labyrinth = [
    ['#', '#', '#', '#', '#', '#', '#'],
    ['#', ' ', ' ', ' ', '#', 'F', '#'],
    ['#', ' ', '#', ' ', '#', ' ', '#'],
    ['#', 'P', '#', ' ', ' ', ' ', '#'],
    ['#', '#', '#', '#', '#', '#', '#'],
  ];

  Element mazeElement = querySelector('#maze')!;
  Element messageElement = querySelector('#message')!;

  int playerX = 1;
  int playerY = 3;

  void renderMaze() {
    mazeElement.children.clear();
    for (var row in labyrinth) {
      for (var cell in row) {
        DivElement div = DivElement();
        div.classes.add('cell');

        switch(cell) {
          case '#': div.classes.add('wall'); break;
          case 'P': div.classes.add('player'); break;
          case 'F': div.classes.add('finish'); break;
          default: div.classes.add('empty'); break;
        }

        mazeElement.children.add(div);
      }
    }
  }

  renderMaze();

  window.onKeyDown.listen((KeyboardEvent event) {
    int newX = playerX;
    int newY = playerY;

    String? key = event.key;
    if (key == null) return;

    switch(key) {
      case 'w': newY--; break;
      case 's': newY++; break;
      case 'a': newX--; break;
      case 'd': newX++; break;
      default: return;
    }

    String targetCell = labyrinth[newY][newX];

    if (targetCell != '#') {
      labyrinth[playerY][playerX] = ' '; 
      labyrinth[newY][newX] = 'P';
      playerX = newX;
      playerY = newY;
      renderMaze();

      if (targetCell == 'F') {
        messageElement.text = "Ви виграли!";
      }
    }
  });
}
