import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/models/game_model.dart';

class GameProvider extends ChangeNotifier {
  GameModel _game = GameModel();
  List<Map<String, dynamic>> _history = [];

  GameModel get game => _game;
  List<Map<String, dynamic>> get history => _history;

  // Winning combinations
  static const List<List<int>> _winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6], // Diagonals
  ];

  GameProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs.getString('history');
    if (historyJson != null) {
      List<dynamic> decoded = json.decode(historyJson);
      _history = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    int xScore = prefs.getInt('xScore') ?? 0;
    int oScore = prefs.getInt('oScore') ?? 0;
    int drawScore = prefs.getInt('drawScore') ?? 0;
    _game = _game.copyWith(
      xScore: xScore,
      oScore: oScore,
      drawScore: drawScore,
    );
    notifyListeners();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('history', json.encode(_history));
    prefs.setInt('xScore', _game.xScore);
    prefs.setInt('oScore', _game.oScore);
    prefs.setInt('drawScore', _game.drawScore);
  }

  void makeMove(int index) {
    if (_game.board[index] != null || _game.gameState != GameState.playing) {
      return;
    }

    List<Player?> newBoard = List.from(_game.board);
    newBoard[index] = _game.currentPlayer;

    _game = _game.copyWith(board: newBoard);

    // Check for win
    if (_checkWin()) {
      return;
    }

    // Check for draw
    if (_checkDraw()) {
      return;
    }

    // Switch player
    _game = _game.copyWith(
      currentPlayer: _game.currentPlayer == Player.x ? Player.o : Player.x,
    );

    notifyListeners();
  }

  bool _checkWin() {
    for (List<int> combination in _winningCombinations) {
      if (_game.board[combination[0]] != null &&
          _game.board[combination[0]] == _game.board[combination[1]] &&
          _game.board[combination[1]] == _game.board[combination[2]]) {
        _game = _game.copyWith(
          gameState: GameState.won,
          winner: _game.currentPlayer,
          winningLine: combination,
        );

        // Update score
        if (_game.currentPlayer == Player.x) {
          _game = _game.copyWith(xScore: _game.xScore + 1);
        } else {
          _game = _game.copyWith(oScore: _game.oScore + 1);
        }

        notifyListeners();
        _addToHistory();
        return true;
      }
    }
    return false;
  }

  bool _checkDraw() {
    if (!_game.board.contains(null)) {
      _game = _game.copyWith(
        gameState: GameState.draw,
        drawScore: _game.drawScore + 1,
      );
      notifyListeners();
      _addToHistory();
      return true;
    }
    return false;
  }

  void _addToHistory() {
    String result;
    if (_game.gameState == GameState.draw) {
      result = 'Draw';
    } else {
      result = _game.winner == Player.x ? 'X Wins' : 'O Wins';
    }
    _history.add({
      'result': result,
      'timestamp': DateTime.now().toIso8601String(),
    });
    _saveData();
    notifyListeners();
  }

  void resetGame() {
    _game = _game.copyWith(
      board: List.filled(9, null),
      currentPlayer: Player.x,
      gameState: GameState.playing,
      winner: null,
      winningLine: [],
    );
    notifyListeners();
  }

  void resetScore() {
    _game = _game.copyWith(xScore: 0, oScore: 0, drawScore: 0);
    resetGame();
    _saveData();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
    _saveData();
  }
}
