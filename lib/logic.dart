class Player {
  String p1 = 'X';
  String p2 = 'O';
  static String p3 = '';
}

class Game {
  List board = [];
  List initList() {
    return List.generate(9, (index) => Player.p3);
  }

  bool CheckWinner(index, player, List listOfWinner) {
    int sum = player == 'X' ? 1 : -1;
    int row = index ~/ 3;
    listOfWinner[row] += sum;
    int col = index % 3;
    listOfWinner[3 + col] += sum;
    if (row == col) {
      //d1
      listOfWinner[6] += sum;
    }
    if (row == 2 - col) {
      //d2
      listOfWinner[7] += sum;
    }
    if (listOfWinner.contains(3) || listOfWinner.contains(-3)) {
      return true;
    } else if (listOfWinner.contains(0)) {
      return false;
    } else {
      return true;
    }
  }
}
