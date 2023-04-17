import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:intl/intl.dart';

import '../../models/ImageLoaiPhong.dart';
import '../../values/app_color.dart';
import '../../values/app_styles.dart';

class LoaiPhongAdminUser extends StatelessWidget {
  const LoaiPhongAdminUser(
      {Key? key, required this.loaiphong, required this.dsHinhAnh})
      : super(key: key);
  final Loaiphong loaiphong;
  final List<ImageLoaiPhong> dsHinhAnh;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String formattedNumber = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(loaiphong.Gia);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          loaiphong.TenLoaiPhong,
          style: AppStyles.h4.copyWith(color: AppColor.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: size.width,
                height: size.height / 3,
                child: dsHinhAnh.length != 0
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dsHinhAnh.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        1, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Image(
                                  image: NetworkImage(
                                      "${HTTP.imageSrc}${dsHinhAnh[index].src}"),
                                  fit: BoxFit.fill,
                                  width: size.width - 20,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Image(image: AssetImage(AppAssets.logo))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: AutoSizeText(
                  loaiphong.TenLoaiPhong,
                  style:
                      AppStyles.h3.copyWith(color: AppColor.buttonColorPrimary),
                  maxLines: 3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "Price ",
                          style:
                              AppStyles.h4.copyWith(color: AppColor.textColor),
                        ),
                      ),
                      Text(
                        ": $formattedNumber",
                        style: AppStyles.h4.copyWith(color: AppColor.textColor),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "Type Of Bed",
                          style:
                              AppStyles.h4.copyWith(color: AppColor.textColor),
                        ),
                      ),
                      Text(
                        ": ${loaiphong.soGiuong}",
                        style: AppStyles.h4.copyWith(color: AppColor.textColor),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "Max Room ",
                          style:
                              AppStyles.h4.copyWith(color: AppColor.textColor),
                        ),
                      ),
                      Text(
                        ": ${loaiphong.soLuongPhong}",
                        style: AppStyles.h4.copyWith(color: AppColor.textColor),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "Room left ",
                          style:
                              AppStyles.h4.copyWith(color: AppColor.textColor),
                        ),
                      ),
                      Text(
                        ": ${loaiphong.phongConLai}",
                        style: AppStyles.h4.copyWith(color: AppColor.textColor),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "Air-Conditions",
                          style:
                              AppStyles.h4.copyWith(color: AppColor.textColor),
                        ),
                      ),

                      Container(
                        child: Checkbox(

                          checkColor: AppColor.secondPrimary,
                          value: loaiphong.isMayLanh,
                          onChanged: (bool? value) {},

                        ),
                      ),
                    ],
                  )),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
              child: MaterialButton(onPressed: (){
                print("Dat Phong ${loaiphong.UIDKS}");
              },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColor.buttonColorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(
                        16))),
                    
                    alignment: Alignment.center,
                    child: Text("Booking Room"),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
