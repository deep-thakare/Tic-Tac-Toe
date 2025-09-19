import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';
import 'package:tic_tac_toe/widgets/game_board.dart';
import 'package:tic_tac_toe/widgets/game_controls.dart';
import 'package:tic_tac_toe/widgets/game_header.dart';
import 'package:tic_tac_toe/widgets/score_board.dart';
import 'history_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.surfaceColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: AppTheme.surfaceColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Score Board
              const ScoreBoard(),

              SizedBox(height: 30.h),

              // Game Header
              const GameHeader(),

              SizedBox(height: 20.h),

              // Game Board
              const Expanded(child: GameBoard()),

              SizedBox(height: 20.h),

              // Game Controls
              const GameControls(),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
