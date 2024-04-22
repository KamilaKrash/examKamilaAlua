import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {

  static const int _durationInSeconds = 2;

  late AnimationController controller;

  late Animation<Offset> imageTranslation;
  late Animation<Offset> textTranslation;
  late Animation<Offset> subTextTranslation;

  late Animation<double> imageOpacity;
  late Animation<double> textOpacity;
  late Animation<double> subTextOpacity;

  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: _durationInSeconds),
    );

    imageTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end:   const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.67, curve: Curves.fastOutSlowIn),
      ),
    );
    textTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end:   const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.34, 0.84, curve: Curves.ease),
      ),
    );

    subTextTranslation = Tween(
      begin: const Offset(0.0, 1.0),
      end:   const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    imageOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.67, curve: Curves.easeIn),
      ),
    );
    textOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.34, 0.84, curve: Curves.linear),
      ),
    );
    subTextOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.67, 1.0, curve: Curves.easeIn),
      ),
    );

    colorAnimation = ColorTween(
        begin: Colors.black,
        end: const Color.fromARGB(255, 255, 232, 197),
    ).animate(controller)
    ..addListener(() { 
      setState(() {});
    });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Material(
            color: colorAnimation.value,
            child: ListView(
              children: [
                FractionalTranslation(
                  translation: imageTranslation.value,
                  child: AnimatedOpacity(
                    opacity: imageOpacity.value,
                    duration: const Duration(seconds: _durationInSeconds),
                    child: const HeaderImage()
                  ),
                ),
        
                FractionalTranslation(
                  translation: textTranslation.value,
                  child: AnimatedOpacity(
                    opacity: textOpacity.value,
                    duration: const Duration(seconds: _durationInSeconds),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                      child: Text(
                        "My hometown.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Jersey25'
                        ),
                      ),
                    )
                  ),
                ),
      
                FractionalTranslation(
                  translation: subTextTranslation.value,
                  child: AnimatedOpacity(
                    opacity: subTextOpacity.value,
                    duration: const Duration(seconds: _durationInSeconds),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0,bottom: 10),
                      child: Text("Every corner of Almaty is filled with memories and warmth, as if the breath of my hometown has embraced me since childhood. Here, among the mountain peaks and green slopes, my soul has found its home.I wake up to the sounds of urban fermentation mixed with birdsong outside the window. Waking up in Almaty is like waking up in a fairy tale, where every new day brings its own unique story.The streets in the city center are shrouded in the aromas of flowers and freshness. Since early childhood, my mother took me to the bazaar, where I was surprised to see colorful vegetables and fruits, listening to the hubbub of the crowd and trade negotiations.In the evening, my friends and I often gather at Republic Square, where a sea of light and sounds takes us into a world of fantasy and fun. There is always something going on here: exhibitions, concerts, festivals — each event brings its own impressions and exciting meetings.I especially love our city in quiet moments. In the evening, when the city freezes and the stars gently illuminate the night sky. Sitting on a park bench or looking at the lights of the city from a height, I feel that here is my place, my world, my home.pAlmaty is not just a city on the map, it is a part of me, my history and my future. This is where I grew up, studied and dreamed. And every day I am grateful to this wonderful city for its warmth and inspiration.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Jersey25'
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        "assets/almaty-2.jpg",
        height: 300.0,
        fit: BoxFit.cover,
      ),
    );
  }
}