import 'package:flutter/material.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/ItemsLoaiPhongUser.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/formLoaiPhongRegister.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/itemsLoaiPhong.dart';

import '../models/loaiphong.dart';
import '../values/app_color.dart';
import '../values/app_styles.dart';

class QLLoaiPhongPage extends StatelessWidget {
  const QLLoaiPhongPage({Key? key, required this.loaiphongs, required this.admin, required this.UIDKS}) : super(key: key);
  final List<Loaiphong> loaiphongs;
  final String UIDKS;
  final bool admin;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text('KIND OF ROOM',style: AppStyles.h4.copyWith(color: AppColor.primaryColor),),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        // ),


      ),
      body: ListView.builder(
        itemCount: loaiphongs.length,
          itemBuilder: (context, index) {
            return admin?KindRoomAdmin(LoaiPhong: loaiphongs[index]):itemsLoaiPhongUser(loaiphong: loaiphongs[index]);
          },
      ),
      floatingActionButton: Visibility(
        visible: admin,
        child: FloatingActionButton(
          backgroundColor: AppColor.buttonColorPrimary,
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => pageLoaiPhongRegister(UIDKS: UIDKS),));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

