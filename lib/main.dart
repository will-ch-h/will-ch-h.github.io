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
              height: isMobile
                  ? MediaQuery.of(context).size.height * 0.45
                  : MediaQuery.of(context).size.height,
              color: const Color(0xFF3A3A3A),
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: 24, vertical: 24)
                  : const EdgeInsets.symmetric(horizontal: 46, vertical: 46),
              alignment: Alignment.centerLeft,
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
    final avatarRadius = MediaQuery.of(context).size.height * 0.45 * 0.4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: const NetworkImage(
            'https://avatars.githubusercontent.com/will-ch-h',
          ),
        ),
        const SizedBox(width: 20),
        const Text(
          'will-ch-h',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
