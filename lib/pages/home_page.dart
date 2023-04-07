import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/pages/commentPage.dart';
import 'package:frontendlv/pages/mainpage.dart';
import 'package:frontendlv/pages/searchPage.dart';
import 'package:frontendlv/pages/settingPage.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.khachHang}) : super(key: key);
  final KhachHang khachHang;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int CurrentPage = 0;
  late KhachHang khachHang;
  @override
  void initState() {
    // TODO: implement initState
    khachHang = widget.khachHang;
    super.initState();

  }

  // final List<Widget> screens = [
  //   mainPage(),
  //   searchPage(),
  //   commentPage(),
  //   settingPage(),
  // ];
  final PageStorageBucket bucket = new PageStorageBucket();

  // Widget currentScreen = DashBoach

  @override
  Widget build(BuildContext context) {
    // khachHang = widget.khachHang;
    Widget currentScreen = CurrentPage == 0
        ? mainPage(khachHang: khachHang,)
        : CurrentPage == 1
            ? searchPage()
            : CurrentPage == 2
                ? commentPage()
                :  settingPage();
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("hello");
        },
        backgroundColor: AppColor.primaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(180.0),
          side: BorderSide(color: AppColor.textColor, width: 0.5),
        ),
        child: Icon(
          Icons.star,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape:  CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          color: AppColor.buttonColorPrimary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = mainPage(khachHang: khachHang,);
                        CurrentPage = 0;
                      });


                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_filled,
                            color: CurrentPage == 0
                                ? AppColor.iconColor
                                : AppColor.textColor),
                        Text(
                          "HOME",
                          style: AppStyles.h6.copyWith(
                              color: CurrentPage == 0
                                  ? AppColor.textColor
                                  : AppColor.textColor),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        print(khachHang.email);
                        currentScreen = searchPage();
                        CurrentPage = 1;
                      });

                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search,
                            color: CurrentPage == 1
                                ? AppColor.iconColor
                                : AppColor.textColor),
                        Text(
                          "SEARCH",
                          style: AppStyles.h6.copyWith(
                              color: CurrentPage == 1
                              ? AppColor.iconColor
                                  : AppColor.textColor),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = commentPage();
                        CurrentPage = 2;
                      });


                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat,
                            color: CurrentPage == 2
                                ? AppColor.iconColor
                                : AppColor.textColor),
                        Text(
                          "COMMENT",
                          style: AppStyles.h6.copyWith(
                              color: CurrentPage == 2
                                  ? AppColor.iconColor
                                  : AppColor.textColor),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = settingPage();
                        CurrentPage = 3;
                      });

                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings,
                            color: CurrentPage == 3
                                ? AppColor.iconColor
                                : AppColor.textColor),
                        Text(
                          "SETTING",
                          style: AppStyles.h6.copyWith(
                              color: CurrentPage == 3
                                  ? AppColor.iconColor
                                  : AppColor.textColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),

        ),
      ),
    );
  }
}
