import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/models/game_model.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';


class GameCell extends StatefulWidget {
  final int index;
  final Player? player;
  final bool isWinningCell;
  final VoidCallback onTap;

  const GameCell({
    super.key,
    required this.index,
    required this.player,
    required this.isWinningCell,
    required this.onTap,
  });

  @override
  State<GameCell> createState() => _GameCellState();
}

class _GameCellState extends State<GameCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void didUpdateWidget(GameCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.player != null && oldWidget.player == null) {
      _animationController.reset();
      _animationController.forward();
    } else if (widget.player == null && oldWidget.player != null) {
      _animationController.reset();
    }
    if (widget.isWinningCell && !oldWidget.isWinningCell) {
      _animationController.forward(from: 0.8);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.isWinningCell
              ? AppTheme.successColor.withOpacity(0.2)
              : AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: widget.isWinningCell
                ? AppTheme.successColor
                : AppTheme.textSecondary.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Center(
          child: widget.player != null
              ? AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Text(
                        widget.player == Player.x ? 'X' : 'O',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: widget.player == Player.x
                              ? AppTheme.primaryColor
                              : AppTheme.errorColor,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
