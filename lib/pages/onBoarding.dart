import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'logoPage.dart';

class onBoarding extends StatelessWidget {
  static const customColor = const Color(0xff151B54);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
                title: 'Stuck at work?',
                body:
                    'Get your errands sorted out fast with our top notch sourcing and orders fulfilment system.',
                image: buildImage('assets/tiredWoman.jpg'),
                decoration: getPageDecoration()),
            PageViewModel(
                title: 'We made it even easier',
                body:
                    'Simply signup for a free account, and off you go sending your errands.',
                image: Image.asset('assets/signIn.jpg'),
                decoration: getPageDecoration()),
            PageViewModel(
                title: 'Get started with us today',
                body:
                    'Running your errands at remarkably low rates is what we do best.',
                image: Image.asset('assets/deliver.jpeg'),
                decoration: getPageDecoration())
          ],
          done: Text('Done',
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: customColor)),
          onDone: () => gotoLogoScreen(context),
          showSkipButton: true,
          skip: Text('Skip',
              style:
                  TextStyle(color: customColor, fontWeight: FontWeight.w700)),
          onSkip: () {},
          next: Icon(Icons.arrow_forward, color: customColor),
          dotsDecorator: getDotDecoration(),
          skipOrBackFlex: 0,
          nextFlex: 0,
        ),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350.0, height: 200.0));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: customColor,
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w200),
        bodyTextStyle: TextStyle(fontSize: 20),
        bodyPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.only(left: 24, right: 24, top: 24),
        pageColor: Colors.white,
      );

  gotoLogoScreen(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => logoPage()));
}
