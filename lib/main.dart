import 'package:app_structure/app_theme/theme.dart';
import 'package:app_structure/app_theme/theme_notifier.dart';
import 'package:app_structure/features/sign_forms/pages/sign_up.dart';
import 'package:app_structure/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeNotifier themeNotifier = await ThemeNotifier.create();

  runApp(MyApp(themeNotifier: themeNotifier));
}

class MyApp extends StatelessWidget {
  final ThemeNotifier? themeNotifier;

  const MyApp({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>.value(
            value: themeNotifier ?? ThemeNotifier(ThemeMode.light),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.instance.lightTheme,
              darkTheme: AppTheme.instance.darkTheme,
              themeMode: themeNotifier.themeMode,
              home: SignUp(
                toggleTheme: themeNotifier.toggleTheme,
                isDarkMode: themeNotifier.themeMode == ThemeMode.dark,
              ),
            );
          },
        ),
      ),
    );
  }
}
