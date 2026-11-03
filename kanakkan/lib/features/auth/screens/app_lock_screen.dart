import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AppLockScreen extends StatefulWidget {
  final String correctPin;
  final VoidCallback onUnlocked;

  const AppLockScreen({
    super.key,
    this.correctPin = '1234',
    required this.onUnlocked,
  });

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  String _enteredPin = '';
  bool _isError = false;

  void _onDigitPress(String digit) {
    if (_enteredPin.length < 4) {
      setState(() {
        _isError = false;
        _enteredPin += digit;
      });

      if (_enteredPin.length == 4) {
        if (_enteredPin == widget.correctPin) {
          widget.onUnlocked();
        } else {
          setState(() {
            _isError = true;
            _enteredPin = '';
          });
        }
      }
    }
  }

  void _onDeletePress() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
        _isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              const Spacer(),

              // Logo & App Name
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  size: 32,
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kanakkan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isError ? 'Incorrect PIN, try again' : 'Enter 4-digit PIN to unlock',
                style: TextStyle(
                  fontSize: 13,
                  color: _isError ? AppColors.error : AppColors.outline,
                  fontWeight: _isError ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 28),

              // PIN Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < _enteredPin.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isFilled
                          ? AppColors.primaryContainer
                          : AppColors.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const Spacer(),

              // Numeric Keypad
              Column(
                children: [
                  for (var row = 0; row < 3; row++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var col = 1; col <= 3; col++) ...[
                          _KeypadButton(
                            text: '${row * 3 + col}',
                            onTap: () => _onDigitPress('${row * 3 + col}'),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Biometric Button
                      _IconButton(
                        icon: Icons.fingerprint_rounded,
                        onTap: widget.onUnlocked,
                      ),
                      _KeypadButton(
                        text: '0',
                        onTap: () => _onDigitPress('0'),
                      ),
                      // Backspace Button
                      _IconButton(
                        icon: Icons.backspace_outlined,
                        onTap: _onDeletePress,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _KeypadButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(36),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(36),
      child: SizedBox(
        width: 72,
        height: 72,
        child: Icon(icon, size: 28, color: AppColors.primaryContainer),
      ),
    );
  }
}

