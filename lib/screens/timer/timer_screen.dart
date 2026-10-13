import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  int _totalSeconds = 15 * 60;
  int _remainingSeconds = 15 * 60;
  bool _isRunning = false;
  Timer? _timer;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  final List<int> _presets = [5, 10, 15, 30];

  @override
  void initState() {
    super.initState();
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
          _showDoneDialog();
        } else {
          setState(() => _remainingSeconds--);
        }
      });
    }
  }

  void _addTime(int seconds) {
    setState(() {
      _totalSeconds += seconds;
      _remainingSeconds += seconds;
    });
  }

  void _setPreset(int minutes) {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _totalSeconds = minutes * 60;
      _remainingSeconds = minutes * 60;
    });
  }

  void _showDoneDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('⏰  Time\'s Up!',
            style: TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text('Your cooking timer is done! 🍽️',
            style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _remainingSeconds = _totalSeconds;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text('OK',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  String get _minutesDisplay =>
      (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
  String get _secondsDisplay =>
      (_remainingSeconds % 60).toString().padLeft(2, '0');
  double get _progress =>
      _totalSeconds == 0 ? 0 : _remainingSeconds / _totalSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B5E35),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Background decorative kitchen icons ──
            ..._buildBgIcons(context),

            Column(
              children: [
                // ── App Bar ──
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: const Icon(Icons.arrow_back_ios_rounded,
                              color: Colors.white, size: 18),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Cooking Timer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ── Timer Ring ──
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (context, child) => Transform.scale(
                    scale: _isRunning ? _pulseAnim.value : 1.0,
                    child: child,
                  ),
                  child: SizedBox(
                    width: 220,
                    height: 220,
                    child: CustomPaint(
                      painter: _RingPainter(progress: _progress),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_minutesDisplay:$_secondsDisplay',
                              style: const TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                letterSpacing: 2,
                              ),
                            ),
                            const Text(
                              'minutes',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF80C49A),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                // ── Play/Pause + Add Time Buttons ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SmallBtn(
                        label: '+1 min',
                        icon: Icons.add_rounded,
                        onTap: () => _addTime(60)),
                    const SizedBox(width: 16),
                    // Main play/pause button
                    GestureDetector(
                      onTap: _startStop,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8892A),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE8892A)
                                  .withValues(alpha: 0.45),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          _isRunning
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _SmallBtn(
                        label: '+5 min',
                        icon: Icons.replay_5_rounded,
                        onTap: () => _addTime(300)),
                    const SizedBox(width: 16),
                    _SmallBtn(
                        label: '+10 min',
                        icon: Icons.replay_10_rounded,
                        onTap: () => _addTime(600)),
                  ],
                ),

                const SizedBox(height: 36),

                // ── Quick Presets ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF154D2A),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quick Presets',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _presets.map((min) {
                            final isSelected = _totalSeconds == min * 60;
                            return GestureDetector(
                              onTap: () => _setPreset(min),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 68,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF2E7D52)
                                      : const Color(0xFF1E6E40),
                                  borderRadius: BorderRadius.circular(22),
                                  border: isSelected
                                      ? Border.all(
                                          color: const Color(0xFF4CAF70),
                                          width: 1.5)
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '${min}m',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF80C49A),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBgIcons(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final icons = [
      Icons.restaurant_rounded,
      Icons.local_fire_department_rounded,
      Icons.soup_kitchen_rounded,
      Icons.set_meal_rounded,
      Icons.emoji_food_beverage_rounded,
      Icons.outdoor_grill_rounded,
    ];
    final positions = [
      const Offset(0.85, 0.05),
      const Offset(0.05, 0.12),
      const Offset(0.75, 0.28),
      const Offset(0.10, 0.35),
      const Offset(0.88, 0.55),
      const Offset(0.02, 0.60),
    ];
    return List.generate(icons.length, (i) {
      return Positioned(
        left: positions[i].dx * size.width,
        top: positions[i].dy * size.height,
        child: Icon(
          icons[i],
          size: 38,
          color: Colors.white.withValues(alpha: 0.07),
        ),
      );
    });
  }
}

// ── Small Control Button ──
class _SmallBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SmallBtn(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF80C49A),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Custom Ring Painter ──
class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const strokeW = 14.0;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = const Color(0xFFE8892A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
