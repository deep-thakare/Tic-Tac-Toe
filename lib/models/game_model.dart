enum Player { x, o }

enum GameState { playing, won, draw }

class GameModel {
  List<Player?> board;
  Player currentPlayer;
  GameState gameState;
  Player? winner;
  List<int> winningLine;
  int xScore;
  int oScore;
  int drawScore;

  GameModel({
    List<Player?>? board,
    this.currentPlayer = Player.x,
    this.gameState = GameState.playing,
    this.winner,
    List<int>? winningLine,
    this.xScore = 0,
    this.oScore = 0,
    this.drawScore = 0,
  }) : board = board ?? List.filled(9, null),
       winningLine = winningLine ?? [];

  GameModel copyWith({
    List<Player?>? board,
    Player? currentPlayer,
    GameState? gameState,
    Player? winner,
    List<int>? winningLine,
    int? xScore,
    int? oScore,
    int? drawScore,
  }) {
    return GameModel(
      board: board ?? List.from(this.board),
      currentPlayer: currentPlayer ?? this.currentPlayer,
      gameState: gameState ?? this.gameState,
      winner: winner ?? this.winner,
      winningLine: winningLine ?? List.from(this.winningLine),
      xScore: xScore ?? this.xScore,
      oScore: oScore ?? this.oScore,
      drawScore: drawScore ?? this.drawScore,
    );
  }

  String get currentPlayerSymbol => currentPlayer == Player.x ? 'X' : 'O';
  String get currentPlayerName =>
      currentPlayer == Player.x ? 'Player X' : 'Player O';
}
