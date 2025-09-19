import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/utils/app_theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.white),
        ),
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
          'Match History',
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
      body: Consumer<GameProvider>(
        builder: (context, provider, child) {
          final history = provider.history.reversed.toList();

          if (history.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 72.sp,
                      color: AppTheme.textSecondary.withOpacity(0.4),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No match history yet',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your past games will appear here once you play.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.textSecondary.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
            itemCount: history.length,
            separatorBuilder: (context, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final entry = history[index];
              String result = entry['result'];
              DateTime dateTime = DateTime.parse(entry['timestamp']).toLocal();
              String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
              String formattedTime = DateFormat('h:mm a').format(dateTime);

              Color resultColor = result.contains('X')
                  ? AppTheme.primaryColor
                  : result.contains('O')
                  ? AppTheme.errorColor
                  : AppTheme.textSecondary;

              IconData resultIcon = result == 'Draw'
                  ? Icons.handshake_outlined
                  : Icons.emoji_events_outlined;

              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26.r,
                      backgroundColor: resultColor.withOpacity(0.1),
                      child: Icon(resultIcon, color: resultColor, size: 24.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  "Game #${history.length - index}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                              Text(
                                result,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: resultColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "$formattedDate • $formattedTime",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.secondaryColor,
        icon: const Icon(Icons.delete_forever, color: Colors.white),
        label: const Text("Clear All", style: TextStyle(color: Colors.white)),
        onPressed: () => _showClearDialog(context),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: const Text(
            'Clear History',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Are you sure you want to clear all match history?',
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                Provider.of<GameProvider>(
                  dialogContext,
                  listen: false,
                ).clearHistory();
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}
