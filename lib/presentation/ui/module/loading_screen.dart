import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class LoadingScreen extends StatefulWidget {

  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorManager.black.withOpacity(0.3),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SvgPicture.asset(
              ImageAssets.logo,
              width: AppSize.s120,
              height: AppSize.s120,
            ),
          ),
        ),
      ),
    );
  }
}
