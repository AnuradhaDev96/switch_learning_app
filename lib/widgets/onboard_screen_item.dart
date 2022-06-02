import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/widget_keys.dart';
import '../screens/dashboard_screen.dart';

class OnboardScreenItem extends StatelessWidget {
  const OnboardScreenItem({
    required Key key,
    required this.backgroundColor,
    required this.headline,
    required this.subHeadline,
    required this.img,
    required this.subHeadlineColor,
    required this.headlineColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Color subHeadlineColor;
  final Color headlineColor;
  final String headline;
  final String subHeadline;
  final String img;

  Future<void> setOnboardScreenPresentingValue(bool isPresented) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(WidgetKeys.isOnboardScreensPresented, isPresented);
  }

  Widget indexIndicatingCircle(Color? indicatorColor) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: indicatorColor,
          border: Border.all(width: 2.0, color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(50.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(50.0),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(5.0, 8.0),
              blurRadius: 6.0,
            ),
          ]),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              headline,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: headlineColor,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              subHeadline,
              style: TextStyle(
                  fontSize: 32.0,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                  color: subHeadlineColor,
                  height: 0.9),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(50.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(50.0),
                ),
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.75,
                  image: AssetImage(img),
                  fit: BoxFit.cover,                  
                ),
              ),
            ),
            const SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  key: const Key(WidgetKeys.skipElevatedButton),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(subHeadlineColor),
                      side: MaterialStateProperty.all(
                          const BorderSide(width: 2.0, color: Colors.white)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(35.0),
                          ),
                        ),
                      )),
                  onPressed: () {
                    setOnboardScreenPresentingValue(true).then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DashboardScreen())));
                  },
                  child: const Text(
                    'Skip',
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                indexIndicatingCircle(
                    key == const ValueKey(WidgetKeys.firstScreenOnboard)
                        ? subHeadlineColor
                        : null),
                const SizedBox(width: 10.0),
                indexIndicatingCircle(
                    key == const ValueKey(WidgetKeys.secondScreenOnboard)
                        ? subHeadlineColor
                        : null),
                const SizedBox(width: 10.0),
                indexIndicatingCircle(
                    key == const ValueKey(WidgetKeys.thirdScreenOnboard)
                        ? subHeadlineColor
                        : null),
              ],
            ),
          ],
        ),
      ),
    );
  }  
}
