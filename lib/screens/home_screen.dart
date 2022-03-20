import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/widget_keys.dart';
import '../constants/colors.dart';
import '../widgets/onboard_screen_item.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isPresented = false;

  static Widget firstWidget = const OnboardScreenItem(
    /*should declare a key. Then AnimatedSwitcher 
    can identify the instances of same widget type*/
    key: ValueKey(WidgetKeys.firstScreenOnboard),
    backgroundColor: AppColors.navyBlue,
    headline: 'Free for one month',
    img: 'assets/itGuy.png',
    subHeadline: 'STUDY YOUR COURSES',
    headlineColor: Colors.white,
    subHeadlineColor: AppColors.coquelicot,
  );
  static Widget secondWidget = const OnboardScreenItem(
    key: ValueKey(WidgetKeys.secondScreenOnboard),
    backgroundColor: AppColors.coquelicot,
    headline: 'Assignment based evaluations',
    img: 'assets/teach.png',
    subHeadline: 'ONLINE ASSIGNMENTS',
    headlineColor: Colors.white,
    subHeadlineColor: AppColors.navyBlue,
  );
  static Widget thirdWidget = const OnboardScreenItem(
    key: ValueKey(WidgetKeys.thirdScreenOnboard),
    backgroundColor: AppColors.arylideYellow,
    headline: 'Earn verified certifications',
    img: 'assets/graduate.jpg',
    subHeadline: 'VERIFIED CERTIFICATIONS',
    headlineColor: Colors.black54,
    subHeadlineColor: AppColors.navyBlue,
  );

  static Widget emptyContainer = Container(
    width: 0,
    height: 0,
    color: Colors.black,
  );

  final screens = <Widget>[
    firstWidget,
    secondWidget,
    thirdWidget,
    emptyContainer 
  ];

  Timer? _timer;
  int index = 0;  

  Future<void> setOnboardScreenPresentingValue(bool isPresented) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(WidgetKeys.isOnboardScreensPresented, isPresented);
  }  

  @override
  void initState() {
    super.initState(); 
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) { 
      if (index == 2) {
        timer.cancel();
        /* DEBUGGING TIP: remove the method call below and replace wih 
        Navigator.pushReplacement to display the onboarding screens everytime*/       
        setOnboardScreenPresentingValue(true).then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen())));
      }
      setState(() {
        index++;
      });
      
      
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeInOutCirc,
                switchOutCurve: Curves.easeInOutCirc,
                transitionBuilder: (child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end:2.0).animate(animation),
                    child: ScaleTransition(
                    scale: animation,
                    child: child,
                    )
                  );
                },
                duration: const Duration(milliseconds: 800),
                child: screens[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
