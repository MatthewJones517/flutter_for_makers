import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer-header-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/makerinator-logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Please Keep in Touch!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                      Uri.parse('https://www.youtube.com/@makerinator'),
                    );
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/youtube.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'YouTube',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'I put all my inventions on YouTube. Like and subscribe!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://clubflock.makerinator.com'));
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/inatorclub.png',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Inator Club',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'All the awesome stuff that doesn\'t work for YouTube goes here. One email a month. No spam.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                      Uri.parse(
                        'https://bsky.app/profile/makerinator.bsky.social',
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bluesky.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bluesky',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'I don\'t always do social media, but when I do it\'s Bluesky',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://www.makerinator.com'));
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/blog.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Official Blog',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Sometimes I party like it\'s 2005 and make a blog post.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
