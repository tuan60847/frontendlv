import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/models/ThanhPho.dart';
import 'package:frontendlv/pages/AdminKH_Page.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart';
import 'package:frontendlv/responsity/KhachSanResponsity.dart';
import 'package:frontendlv/responsity/ThanhPhoResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/WidgetThanhPho/itemsThanhPho.dart';
import 'package:frontendlv/widgets/itemsksContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/SharePreferenceKH.dart';
import 'DonDatPhongKHPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key, required this.khachHang}) : super(key: key);
  final KhachHang khachHang;

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  late KhachHang khachHang;
  late List<KhachSan> listKS = <KhachSan>[];
  late List<ThanhPho> listTP = <ThanhPho>[];

  void _fetchAllKS() async {
    final a = await getKhachHang(khachHang.email);
    List<KhachSan> khachsans = await getDataKS();
    khachsans = checkKS(khachsans);
    List<ThanhPho> thanhphos = await getDataThanhpho();
    thanhphos = checkTP(thanhphos);

    setState(() {
      khachHang = a;
      listKS = khachsans;
      listTP = thanhphos;
    });
  }

  List<KhachSan> checkKS(List<KhachSan> listkhachSan) {
    List<KhachSan> ds = [];
    listkhachSan.forEach((element) {
      if (element.isActive == true) {
        ds.add(element);
      }
    });
    return ds;
  }

  List<ThanhPho> checkTP(List<ThanhPho> listthanhpho) {
    List<ThanhPho> ds = [];
    int len = 8;
    List<int> array =
        fixedLIstRandom(len: len, max: listthanhpho.length, min: 1);
    array.forEach((element) {
      ds.add(listthanhpho[element]);
    });
    return ds;
  }

  List<int> fixedLIstRandom({int len = 1, int max = 128, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }

    return newList;
  }

  // void _enterADMINKS() async{
  //   if(khachHang.isAdminKH==""){
  //     bool kt = await getIsAdmin(khachHang.email);
  //     khachHang.isAdminKH = "${khachHang.cmnd}_${khachHang.SDT}";
  //   }
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => adminKH_Page(UIDKS: khachHang.isAdminKH),));
  //
  //
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    khachHang = widget.khachHang;
    _fetchAllKS();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          toolbarHeight: 100,
          title: Text(
            'Hi ${khachHang.HoTen}',
            style: TextStyle(color: AppColor.buttonColorPrimary),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
          actions: [
            Visibility(
              visible: khachHang.isDatPhong,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  icon: Icon(Icons.notification_important),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonDatPhongPage(
                            khachHang: khachHang,
                          ),
                        ));
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 4.0),
            //   child: IconButton(
            //     icon: Icon(Icons.hotel),
            //     onPressed:_enterADMINKS,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(AppAssets.logo),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(32.0),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: AppColor.yellowButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Text("Khách Sạn"),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: AppColor.yellowButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Text("Nhà Nghỉ"),
                    )
                  ],
                )),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: size.height / 40,
                child: Text(
                  "City",
                  style: AppStyles.h5.copyWith(color: AppColor.textColor),
                ),
              ),
            ),
            Container(
              height: size.height / 5,
              child: ListView.builder(
                  itemCount: listTP.length < 10 ? listTP.length + 1 : 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index < listTP.length)
                      return itemsThanhPho(thanhPho: listTP[index]);
                    else {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            print("Next");
                          },
                          child: Container(
                            height: size.height,
                            width: 120,

                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: AppColor.textColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: size.height * 1 / 8,
                                  width: size.height * 1 / 8,

                                  child: ClipRRect(

                                    child: Icon(Icons.navigate_next_outlined,size: size.height * 1 / 8,),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(180)),
                                  ),
                                ),
                                Text(
                                  "Show More",
                                  style: AppStyles.h5
                                      .copyWith(color: AppColor.textColor),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                itemCount: listKS.length,
                itemBuilder: (context, index) {
                  return ItemsKSContainer(
                    khachsan: listKS[index],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
