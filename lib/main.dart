import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2B2B2B)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFF3A3A3A),
              padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 26),
              alignment: Alignment.centerLeft,
              child: const CircleAvatar(
                radius: 76,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/will-ch-h',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFF2B2B2B),
            ),
          ],
        ),
      ),
    );
  }
}
