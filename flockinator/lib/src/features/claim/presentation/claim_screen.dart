import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flockinator/src/features/claim/presentation/claim_controller.dart';

class ClaimScreen extends ConsumerStatefulWidget {
  final String dashGuid;

  const ClaimScreen({Key? key, required this.dashGuid}) : super(key: key);

  @override
  ConsumerState<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends ConsumerState<ClaimScreen> {
  bool? _isDashActive;
  bool _isLoading = true;
  bool? _deactivationSuccessful;
  bool _isDeactivating = false;
  bool _isReactivating = false;
  bool? _reactivationSuccessful;

  @override
  void initState() {
    super.initState();
    _checkDashStatus();
  }

  Future<void> _checkDashStatus() async {
    try {
      final claimController = ref.read(claimControllerProvider);
      final isActive = await claimController.checkElementActiveStatus(
        widget.dashGuid,
      );
      setState(() {
        _isDashActive = isActive;
        _isLoading = false;
      });

      // If dash is active, automatically try to deactivate it
      if (isActive) {
        await _deactivateDash();
      }
    } catch (e) {
      setState(() {
        _isDashActive = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _deactivateDash() async {
    setState(() {
      _isDeactivating = true;
    });

    try {
      final claimController = ref.read(claimControllerProvider);
      final success = await claimController.deactivateElementByGuid(
        widget.dashGuid,
      );
      setState(() {
        _deactivationSuccessful = success;
        _isDeactivating = false;
      });
    } catch (e) {
      setState(() {
        _deactivationSuccessful = false;
        _isDeactivating = false;
      });
    }
  }

  Future<void> _reactivateDash() async {
    setState(() {
      _isReactivating = true;
    });

    try {
      final claimController = ref.read(claimControllerProvider);
      final success = await claimController.activateElementByGuid(
        widget.dashGuid,
      );
      setState(() {
        _reactivationSuccessful = success;
        _isReactivating = false;
      });

      if (success) {
        context.go('/permission-check');
      }
    } catch (e) {
      setState(() {
        _reactivationSuccessful = false;
        _isReactivating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claim a Dash'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/permission-check'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (_isLoading || _isDeactivating)
            const Center(child: CircularProgressIndicator())
          else if (_isDashActive == true && _deactivationSuccessful == true)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/claimed.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Dash Claimed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFF275)
                        : const Color(0xFF0553B1),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black87,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'This Dash is yours to keep forever!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '\n\n'),
                        const TextSpan(
                          text:
                              'Or, keep the game going...\n\nHide her somewhere new and scan her QR code again to reactivate and pass her on!',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.go('/permission-check'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Continue'),
                ),
                const SizedBox(height: 20),
              ],
            )
          else if (_isDashActive == true && _deactivationSuccessful == false)
            const Center(
              child: Text(
                'Oops! There was a problem claiming your Dash. Please try again later!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/hide.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ready to Hide Dash?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFF275)
                        : const Color(0xFF0553B1),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Thanks for keeping the game going! Once Dash is tucked into her new hiding spot, tap the button below to reactivate her BEAKon.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (_isReactivating)
                  const CircularProgressIndicator()
                else if (_reactivationSuccessful == false)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Sorry! We had an issue reactivating Dash. Please try again!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: _reactivateDash,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Reactivate Dash'),
                  ),
                const SizedBox(height: 20),
              ],
            ),
        ],
      ),
    );
  }
}
