import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// class SplashViewBody extends StatefulWidget {
//   const SplashViewBody({super.key});

//   @override
//   State<SplashViewBody> createState() => _SplashViewBodyState();
// }

// class _SplashViewBodyState extends State<SplashViewBody> {
//   @override
//   void initState() {
//     super.initState();

//     navigateToHome();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SvgPicture.asset(
//           AppImage.splashLogo,
//           height: SizeConfig.height * 0.5,
//           width: 400,
//         ),
//         Text(
//           //"Government Complaints App ",
//           "تطبيق الشكاوي الحكومية",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: SizeConfig.height * 0.04,
//             //fontFamily: AppFonts.amiri,
//             //fontFamily: AppFonts.notoKufi,
//             fontFamily: AppFonts.reemKufi,
//           ),
//         ),
//       ],
//     );
//   }

//   void navigateToHome() {
//     Future.delayed(const Duration(seconds: 2), () {
//       Get.to(
//         WelcomeView(),
//         transition: Transition.fade,
//         duration: valueOfTranitionBetweenPages,
//       );
//     });
//   }
// }

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AppImage.splashLogo,
            height: SizeConfig.height * 0.25,
            width: SizeConfig.width * .5,
          ),
        ),
        Text(
          "تواصل",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.tasees,
            fontSize: SizeConfig.height * 0.035,
          ),
        ),
        Divider(
          endIndent: SizeConfig.height * 0.12,
          indent: SizeConfig.height * 0.12,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    Future.delayed(const Duration(seconds: 2));
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () {
      context.pushNamed(AppRouteRName.welcomeView);

    });
  }
}


class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            "تطبيق الشكاوي الحكومية",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.height * 0.035,
              fontFamily: AppFonts.reemKufi,
              color: AppColor.primary
            ),
          ),
        );
      },
    );
  }
}
