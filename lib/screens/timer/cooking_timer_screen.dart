import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
export 'timer_screen.dart';

/// Cooking timer screen with customizable recipe timers and dish presets.
class CookingTimerScreen extends StatefulWidget {
  final String? recipeName;
  final int? initialMinutes;

  const CookingTimerScreen({
    super.key,
    this.recipeName,
    this.initialMinutes,
  });

  @override
  State<CookingTimerScreen> createState() => _CookingTimerScreenState();
}

class _CookingTimerScreenState extends State<CookingTimerScreen>
    with SingleTickerProviderStateMixin {
  late int _totalSeconds;
  late int _remainingSeconds;
  bool _isRunning = false;
  Timer? _timer;
  String? _currentDish;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  final List<Map<String, dynamic>> _dishPresets = [
    {'name': 'Soft Egg', 'mins': 6, 'emoji': '🥚'},
    {'name': 'Hard Egg', 'mins': 10, 'emoji': '🥚'},
    {'name': 'Pasta', 'mins': 9, 'emoji': '🍝'},
    {'name': 'Rice', 'mins': 15, 'emoji': '🍚'},
    {'name': 'Tea', 'mins': 3, 'emoji': '☕'},
    {'name': 'Simmer', 'mins': 25, 'emoji': '🍲'},
    {'name': 'Bake', 'mins': 40, 'emoji': '🥧'},
  ];

  @override
  void initState() {
    super.initState();
    final mins = widget.initialMinutes ?? 15;
    _totalSeconds = mins * 60;
    _remainingSeconds = _totalSeconds;
    _currentDish = widget.recipeName;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startStop() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_remainingSeconds <= 0) {
          _timer?.cancel();
          setState(() => _isRunning = false);
          _showFinishedDialog();
        } else {
          setState(() => _remainingSeconds--);
        }
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingSeconds = _totalSeconds;
    });
  }

  void _selectPreset(String dishName, int mins) {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentDish = dishName;
      _totalSeconds = mins * 60;
      _remainingSeconds = _totalSeconds;
    });
  }

  void _addMinutes(int mins) {
    setState(() {
      _totalSeconds += mins * 60;
      _remainingSeconds += mins * 60;
    });
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('⏰ ', style: TextStyle(fontSize: 26)),
            Expanded(
              child: Text(
                _currentDish != null ? '$_currentDish Ready!' : 'Time\'s Up!',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          _currentDish != null
              ? 'Your $_currentDish is done cooking! Enjoy your meal 🍽️'
              : 'Your cooking timer has finished! 🍽️',
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _resetTimer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('OK',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  String _formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _totalSeconds > 0
        ? (_totalSeconds - _remainingSeconds) / _totalSeconds
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF1B5E35),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white, size: 20),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cooking Timer',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            if (_currentDish != null)
              Text(
                _currentDish!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB8D9C8),
                  fontFamily: 'Poppins',
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
            onPressed: _resetTimer,
            tooltip: 'Reset Timer',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // ── Circular Timer Dial ──
                ScaleTransition(
                  scale: _isRunning ? _pulseAnim : const AlwaysStoppedAnimation(1.0),
                  child: Center(
                    child: SizedBox(
                      width: 240,
                      height: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(240, 240),
                            painter: _TimerRingPainter(progress: progress),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _formatTime(_remainingSeconds),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _isRunning ? 'Cooking...' : 'Ready to cook',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _isRunning
                                      ? const Color(0xFFE8892A)
                                      : const Color(0xFF8FAF9A),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ── Controls (Start/Pause, Add Time) ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _startStop,
                      icon: Icon(
                        _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                      label: Text(
                        _isRunning ? 'PAUSE' : 'START COOKING',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8892A),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Quick +1 / +5 mins buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _QuickAdjustButton(
                      label: '+1 min',
                      onTap: () => _addMinutes(1),
                    ),
                    const SizedBox(width: 12),
                    _QuickAdjustButton(
                      label: '+5 mins',
                      onTap: () => _addMinutes(5),
                    ),
                    const SizedBox(width: 12),
                    _QuickAdjustButton(
                      label: 'Reset',
                      onTap: _resetTimer,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // ── Dish Presets Section ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kitchen Presets',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _dishPresets.map((preset) {
                          final isSelected = _currentDish == preset['name'];
                          return GestureDetector(
                            onTap: () => _selectPreset(
                              preset['name'] as String,
                              preset['mins'] as int,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE8892A)
                                    : Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 1.2)
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    preset['emoji'] as String,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${preset['name']} (${preset['mins']}m)',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFFDDF0E6),
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAdjustButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickAdjustButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;

  _TimerRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFFE8892A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
