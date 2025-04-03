import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login/login_screen.dart';


class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "OnBoardingScreen";

  const OnBoardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = GoogleFonts.elMessiri(
      fontSize: 19.0,
      color: Theme.of(context).primaryColor,
    );

    var pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.elMessiri(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).primaryColor,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imageFlex: 3,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      dotsFlex: 4,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),

        activeSize: const Size(20.92, 8.0),
        activeColor: Theme.of(context).primaryColor,
        color: const Color(0xff1C1C1C),
        spacing: const EdgeInsets.symmetric(horizontal: 4),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
      ),
      showDoneButton: true,
      showNextButton: true,
      globalHeader: Image.asset("assets/images/app_logo.png"),
      next: Container(
        width: 37.6,
        height: 37.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ),
      done: Container(
        width: 37.6,
        height: 37.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onDone: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      showBackButton: true,
      back: Container(
        width: 37.6,
        height: 37.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find Events That Inspire You",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ),
          image: _buildImage('onboarding1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Effortless Event Planning",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ),
          image: _buildImage('onboarding2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Connect with Friends & Share\n Moments",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ),
          image: _buildImage('onboarding3.png'),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
