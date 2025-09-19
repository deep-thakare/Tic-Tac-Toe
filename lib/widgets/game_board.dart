import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';
import 'game_cell.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 350.w, maxHeight: 350.h),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GameCell(
                      index: index,
                      player: gameProvider.game.board[index],
                      isWinningCell: gameProvider.game.winningLine.contains(
                        index,
                      ),
                      onTap: () => gameProvider.makeMove(index),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
