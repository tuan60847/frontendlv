import 'package:flutter/material.dart';
import 'package:frontendlv/models/ThanhPho.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_styles.dart';

import '../../models/ImageThanhPho.dart';
import '../../values/app_color.dart';
import '../../values/app_http.dart';

class PageThanhPhoDetails extends StatelessWidget {
  const PageThanhPhoDetails(
      {Key? key, required this.thanhPho, required this.listImageTP})
      : super(key: key);
  final ThanhPho thanhPho;
  final List<ImageTP> listImageTP;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "${thanhPho.TenTP}",
          style: TextStyle(color: AppColor.buttonColorPrimary),
        ),
      ),
      body: Container(
        height: size.height + 100,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: listImageTP.length == 0
                      ? Container(
                          width: size.width / 2,
                          child: Image.asset(AppAssets.logo))
                      : Container(
                        height: size.height/3,
                        child: ListView.builder(
                            itemCount: listImageTP.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4,),
                                  child: Container(
                                  width: size.width ,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    child: Image.network(HTTP.imageSrc+listImageTP[index].src,fit: BoxFit.fill,),
                                  ),
                              ),
                                );
                            },
                          ),
                      )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                child: Container(
                    width: size.width,
                    child: Text(
                      "${thanhPho.Mota}",
                      style: AppStyles.h4.copyWith(color: AppColor.textColor),
                    )),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
        child: InkWell(
          onTap: () {
            print("Search Location In City");
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.buttonColorSecond,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Text("Search Location In City",textAlign: TextAlign.center, style: AppStyles.h5,),
          ),
        ),
      ),
    );
  }
}
