import 'package:flutter/material.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Laundry',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return BottomNav(username: args['username']);
            },
          );
        }
        return null;
      },
    );
  }
}
