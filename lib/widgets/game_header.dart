import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/game_model.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final game = gameProvider.game;

        String message;
        Color messageColor;
        IconData? icon;

        switch (game.gameState) {
          case GameState.playing:
            message = "${game.currentPlayerName}'s Turn";
            messageColor = game.currentPlayer == Player.x
                ? AppTheme.primaryColor
                : AppTheme.errorColor;
            icon = Icons.play_circle_outline;
            break;
          case GameState.won:
            message =
                "${game.winner == Player.x ? 'Player X' : 'Player O'} Wins! 🎉";
            messageColor = AppTheme.successColor;
            icon = Icons.emoji_events;
            break;
          case GameState.draw:
            message = "It's a Draw! 🤝";
            messageColor = AppTheme.textSecondary;
            icon = Icons.handshake;
            break;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: messageColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: messageColor.withOpacity(0.3), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: messageColor, size: 24.sp),
                SizedBox(width: 8.w),
              ],
              Text(
                message,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: messageColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
