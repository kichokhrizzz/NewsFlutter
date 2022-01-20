import 'package:flutter/material.dart';

 final theme = ThemeData.dark();
 
final myTheme = ThemeData(
  colorScheme: theme.colorScheme.copyWith(
    secondary: Color.fromRGBO(255, 76, 41, 1),
  ),
);
 