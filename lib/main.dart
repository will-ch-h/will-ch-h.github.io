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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: isMobile ? null : MediaQuery.of(context).size.height,
              color: const Color(0xFF3A3A3A),
              padding: isMobile
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 46, vertical: 46),
              alignment: isMobile ? null : Alignment.centerLeft,
              child: isMobile ? const _MobileHeader() : const _DesktopHeader(),
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

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 96,
      backgroundImage: NetworkImage(
        'https://avatars.githubusercontent.com/will-ch-h',
      ),
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.45,
          child: Image.network(
            'https://avatars.githubusercontent.com/will-ch-h',
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Text(
            'will-ch-h',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        // information goes here
      ],
    );
  }
}
