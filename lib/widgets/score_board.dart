import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final game = gameProvider.game;

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreCard(
                label: 'Player X',
                score: game.xScore,
                color: AppTheme.primaryColor,
                icon: Icons.close,
              ),
              _ScoreCard(
                label: 'Draws',
                score: game.drawScore,
                color: AppTheme.textSecondary,
                icon: Icons.remove,
              ),
              _ScoreCard(
                label: 'Player O',
                score: game.oScore,
                color: AppTheme.errorColor,
                icon: Icons.radio_button_unchecked,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final Color color;
  final IconData icon;

  const _ScoreCard({
    required this.label,
    required this.score,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            score.toString(),
            key: ValueKey<int>(score),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
