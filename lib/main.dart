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
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFF3A3A3A),
              padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 46),
              alignment: isMobile ? Alignment.topLeft : Alignment.centerLeft,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/will-ch-h',
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'will-ch-h',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // information goes here
      ],
    );
  }
}
