import 'package:flutter/material.dart';
import 'package:frontendlv/values/app_color.dart';

class Appbar_main extends StatelessWidget {
  const Appbar_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 169,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: AppColor.appbarColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
              ),
              flexibleSpace: Stack(
                children: [
                  Container(

                    decoration: BoxDecoration(

                    ),
                  ),
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.hotel))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
