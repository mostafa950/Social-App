import 'package:flutter/material.dart';
import 'package:shop_app/models/shop_app_model/board_model.dart';
import 'package:shop_app/modules/shop_app/Login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateToFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  List<ShopBoardModel> boarding = [
    ShopBoardModel(
        body: 'On Board 1 Body',
        title: 'On Board 1 Title',
        image: 'assets/images/logo.jpg'),
    ShopBoardModel(
        body: 'On Board 2 Body',
        title: 'On Board 2 Title',
        image: 'assets/images/logo.jpg'),
    ShopBoardModel(
        body: 'On Board 3 Body',
        title: 'On Board 3 Title',
        image: 'assets/images/logo.jpg'),
  ];
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna',
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              itemBuilder: (context, index) => onItemBoard(boarding[index]),
              physics: BouncingScrollPhysics(),
              itemCount: boarding.length,
              controller: controller,
              onPageChanged: (int index) {
                if (index == (boarding.length - 1)) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            )),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      controller.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: defaultColor,
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
