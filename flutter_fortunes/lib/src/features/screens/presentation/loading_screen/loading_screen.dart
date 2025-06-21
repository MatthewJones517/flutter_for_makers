import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'dash.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  void _setupAudio() {
    _audioPlayer.onPlayerComplete.listen((_) {
      if (context.mounted) {
        _onAudioComplete();
      }
    });

    _playAudio();
  }

  void _onAudioComplete() {
    if (!mounted) return;
    context.go('/fortune');
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/loading.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Image.asset(
            'assets/images/fortune_banner.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Dash(),
        ],
      ),
    );
  }
}
