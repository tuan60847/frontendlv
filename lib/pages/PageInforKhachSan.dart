import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/widgets/FormKhachKhachSan/itemsManagerKS.dart';

import '../values/app_color.dart';

class PageInformationKhachSan extends StatelessWidget {
  const PageInformationKhachSan({Key? key, required this.khachSan}) : super(key: key);
  final KhachSan khachSan;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('Booking Hotel',style: TextStyle(color: AppColor.buttonColorPrimary),),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.hotel),
              onPressed:(){},
            ),
          ),

        ],

      ),
      body: itemsManagerKS(khachSan: khachSan,repairKhachSan: false),

    );
  }
}

