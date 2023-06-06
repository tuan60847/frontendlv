import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachSan.dart';

import 'package:frontendlv/responsity/KhachSanResponsity.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/FormKhachKhachSan/formKhachSan.dart';
import 'package:frontendlv/widgets/bodyManageHotelWidget.dart';



class adminKH_Page extends StatefulWidget {
  const adminKH_Page({Key? key, required this.UIDKS}) : super(key: key);
  final String UIDKS;

  @override
  State<adminKH_Page> createState() => _adminKH_PageState();
}

class _adminKH_PageState extends State<adminKH_Page> {
  late String UIDKS;
  late KhachSan khachSan;
  bool isRegisterKH= false;

  void _getKhachSanitem() async  {
    try{
      KhachSan ks = await getKhachSan(UIDKS);
      setState(() {
        khachSan=ks;
        isRegisterKH=true;
      });
    }catch(e)
    {
      print(e);
    }

  }






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UIDKS = widget.UIDKS;
    _getKhachSanitem();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text('MANAGE HOTEL',style: AppStyles.h4.copyWith(color: AppColor.primaryColor),),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.list),
              onPressed: (){},
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: Image.asset(AppAssets.logo,height: 12,width: 40,),
          // ),
        ],

      ),
      body:isRegisterKH==false?RegisterKhachSan(UIDKS:UIDKS):bodyManageHotel(khachSan: khachSan),

    );
  }
}
