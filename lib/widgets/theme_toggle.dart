import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/theme_service.dart';

class ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return IconButton(
      icon: Icon(themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode),
      onPressed: () {
        themeService.toggleTheme();
      },
    );
  }
}
