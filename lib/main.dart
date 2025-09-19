import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/game_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => GameProvider(),
          child: MaterialApp(
            title: 'Tic Tac Toe',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme.copyWith(
              textTheme: Theme.of(
                context,
              ).textTheme.apply(fontFamily: "Poppins"),
            ),
            home: const GameScreen(),
          ),
        );
      },
    );
  }
}
