import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _bowlFade;
  late Animation<Offset> _bowlSlide;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // Logo: fades + scales in first
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Text: slides up after logo
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.65, curve: Curves.easeOut),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.65, curve: Curves.easeOut),
      ),
    );

    // Bowl: slides up last
    _bowlFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
      ),
    );
    _bowlSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
      ),
    );

    // Floating up/down animation for bowl
    _floatAnim = Tween<double>(begin: -7.0, end: 7.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _mainController.forward();

    // Navigate to main after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E6), // Cream background
      body: Stack(
        children: [
          // ── Decorative blob top-right ──
          Positioned(
            top: -60,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFB8D9C8).withValues(alpha: 0.35),
              ),
            ),
          ),

          // ── Decorative blob bottom-left ──
          Positioned(
            bottom: 40,
            left: -50,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFB8D9C8).withValues(alpha: 0.25),
              ),
            ),
          ),

          // ── Small leaf top-left ──
          Positioned(
            top: size.height * 0.19,
            left: 24,
            child: FadeTransition(
              opacity: _textFade,
              child: Image.asset(
                'assets/images/veggie_bowl.png',
                width: 28,
                height: 28,
                color: const Color(0xFF4CAF70).withValues(alpha: 0.5),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isShort = constraints.maxHeight < 650;
                final bowlWidth = (size.width * 0.75).clamp(160.0, 280.0);

                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: isShort ? 16 : size.height * 0.05),

                          // ── Chef Hat Logo (real asset) ──
                          FadeTransition(
                            opacity: _logoFade,
                            child: ScaleTransition(
                              scale: _logoScale,
                              child: Image.asset(
                                'assets/images/chef_hat_logo.png',
                                width: isShort ? 80 : 100,
                                height: isShort ? 80 : 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          SizedBox(height: isShort ? 10 : 16),

                          // ── "Kitchen Helper" Text ──
                          FadeTransition(
                            opacity: _textFade,
                            child: SlideTransition(
                              position: _textSlide,
                              child: Column(
                                children: [
                                  // Kitchen — dark green
                                  Text(
                                    'Kitchen',
                                    style: TextStyle(
                                      fontSize: isShort ? 34 : 40,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF1B5E35),
                                      fontFamily: 'Poppins',
                                      height: 1.1,
                                    ),
                                  ),
                                  // Helper — orange
                                  Text(
                                    'Helper',
                                    style: TextStyle(
                                      fontSize: isShort ? 34 : 40,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFFE8892A),
                                      fontFamily: 'Poppins',
                                      height: 1.05,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Cook • Plan • Enjoy
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Cook',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF4A6355),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Text('•',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFE8892A),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Text('Plan',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF4A6355),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Text('•',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFE8892A),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Text('Enjoy',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF4A6355),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // "Your personal kitchen companion"
                                  const Text(
                                    'Your personal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4A6355),
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Text(
                                    'kitchen companion',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4A6355),
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  // Heart icon
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(0xFFE8892A),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),

                          // ── Veggie Bowl Image (real asset) — floating ──
                          FadeTransition(
                            opacity: _bowlFade,
                            child: SlideTransition(
                              position: _bowlSlide,
                              child: AnimatedBuilder(
                                animation: _floatAnim,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _floatAnim.value),
                                    child: child,
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/veggie_bowl.png',
                                  width: bowlWidth,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: isShort ? 16 : 24),

                          // ── Page indicator dots ──
                          FadeTransition(
                            opacity: _bowlFade,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Active dot (wide)
                                Container(
                                  width: 28,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E7D52),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB8D9C8),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB8D9C8),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: isShort ? 16 : 28),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
