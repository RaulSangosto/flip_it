import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import '../state/bloc/sound/sound_bloc.dart';
import '../state/bloc/sound/sound_model.dart';
import '../theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoAnimated extends StatefulWidget {
  const LogoAnimated({Key? key}) : super(key: key);

  @override
  State<LogoAnimated> createState() => _LogoAnimatedState();
}

class _LogoAnimatedState extends State<LogoAnimated>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late Image logo;

  @override
  void initState() {
    logo = Image.asset("assets/images/Logo_text.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(logo.image, context);
    _controller.forward();
    BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.logoOpen));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const startRotation = -.03;
    const duration = 350;

    return AnimatedBuilder(
      animation: _controller,
      child: Image(
        image: logo.image,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      builder: (context, child) {
        return Center(
          child: CircularRevealAnimation(
            animation: _controller,
            minRadius: 0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: const FractionalOffset(0.55, 0.75),
                    child: Stack(
                      children: [
                        const AnimatedCard(
                          color: darkColor,
                          angle: startRotation,
                          duration: duration,
                        ),
                        AnimatedCard(
                          color: green,
                          angle: _controller.status == AnimationStatus.completed
                              ? 0.06
                              : startRotation,
                          duration: duration,
                        ),
                        AnimatedCard(
                          color: purple,
                          angle: _controller.status == AnimationStatus.completed
                              ? 0.1
                              : startRotation,
                          duration: duration,
                        ),
                      ],
                    ),
                  ),
                ),
                child!,
                AnimatedPositioned(
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 250),
                  bottom: 0,
                  right: _controller.status == AnimationStatus.completed
                      ? 30.0
                      : -50,
                  child: Text(
                    "A game about time",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    Key? key,
    required this.color,
    required this.angle,
    required this.duration,
  }) : super(key: key);

  final Color color;
  final double angle;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      curve: Curves.easeInOut,
      alignment: const FractionalOffset(0.2, .85),
      duration: Duration(milliseconds: duration),
      turns: angle,
      child: Card(
        elevation: 0,
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: white, width: 5),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 5.5,
          child: const AspectRatio(
            aspectRatio: 7 / 11,
          ),
        ),
      ),
    );
  }
}
