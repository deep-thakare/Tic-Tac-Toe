import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: gameProvider.resetGame,
                icon: Icon(Icons.refresh, size: 20.sp),
                label: Text('New Game', style: TextStyle(fontSize: 16.sp)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showResetScoreDialog(context, gameProvider),
                icon: Icon(
                  Icons.restart_alt,
                  size: 20.sp,
                  color: AppTheme.errorColor,
                ),
                label: Text(
                  'Reset Score',
                  style: TextStyle(fontSize: 16.sp, color: AppTheme.errorColor),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.errorColor),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetScoreDialog(BuildContext context, GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Reset Score'),
          content: const Text('Are you sure you want to reset all scores?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Reset',
                style: TextStyle(color: AppTheme.errorColor),
              ),
              onPressed: () {
                gameProvider.resetScore();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
