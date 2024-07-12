// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_print, sized_box_for_whitespace

import 'package:covid_app_new/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/Utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorldStatesScreen()));
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    //physics???????????
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: OnboardingPic(
                              imagepath: 'assets/images/onboarding1.png',
                              subtitle:
                                  'Keep Your Distance, Save a Life.Staying Apart Today, To Hug Tomorrow And Distance Your Body, Connect Your Heart',
                              title: 'Keep Your\nDistance')),
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: OnboardingPic(
                              imagepath: 'assets/images/onboarding1.png',
                              subtitle:
                                  'Keep Your Distance, Save a Life.Staying Apart Today, To Hug Tomorrow And Distance Your Body, Connect Your Heart',
                              title: 'Keep Your\nDistance')),
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: OnboardingPic(
                              imagepath: 'assets/images/onboarding2.png',
                              subtitle:
                                  "Responsibility starts with you So Don't be a spreader, be a healer. A mask a day keeps the virus away",
                              title: 'Help Stop The\n Global Pandemic')),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorldStatesScreen()));
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

class OnboardingPic extends StatelessWidget {
  final imagepath;
  final String title, subtitle;
  const OnboardingPic(
      {super.key,
      required this.imagepath,
      required this.subtitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(
              imagepath,
            ),
            height: 300.0,
            width: 300.0,
          ),
        ),
        SizedBox(height: 30.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: kTitleStyle,
          ),
        ),
        SizedBox(height: 15.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: kSubtitleStyle,
          ),
        ),
      ],
    );
  }
}
