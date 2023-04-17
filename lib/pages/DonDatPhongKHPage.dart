import 'package:flutter/material.dart';
import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/responsity/DonDatPhongResponsity.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/widgets/WidgetDonDatPhong/itemsBooking.dart';

import '../values/app_styles.dart';

class DonDatPhongPage extends StatefulWidget {
  const DonDatPhongPage({Key? key, required this.khachHang}) : super(key: key);
  final KhachHang khachHang;


  @override
  State<DonDatPhongPage> createState() => _DonDatPhongPageState();
}

class _DonDatPhongPageState extends State<DonDatPhongPage> {
  late KhachHang khachHang;
  late DonDatPhong? donDatPhong=null;

  _findlastDonDatPhong() async{
    final a = await getNewDonDatPhongByEmail(khachHang.email);
    setState(() {
      donDatPhong = a;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachHang = widget.khachHang;
    _findlastDonDatPhong();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text('Booking Manager',style: AppStyles.h4.copyWith(color: AppColor.primaryColor),),
      ),
      body: donDatPhong==null||donDatPhong!.isChecked==5?Text(""):itemBookingManager(khachHang: khachHang, donDatPhong: donDatPhong!),

    );
  }
}
