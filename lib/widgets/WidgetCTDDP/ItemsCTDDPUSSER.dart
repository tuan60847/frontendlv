import 'package:flutter/material.dart';
import 'package:frontendlv/models/CTDDP.dart';
import 'package:frontendlv/models/ImageLoaiPhong.dart';
import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/LoaiPhongDetailsAdmin.dart';

import '../../responsity/ImageLoaiPhongResponsity.dart';
import '../../values/app_styles.dart';

class itemsCTDDPUser extends StatefulWidget {
  const itemsCTDDPUser(
      {Key? key,
      required this.ctddp,
      required this.isChecked,
      required this.updatectddp})
      : super(key: key);
  final CTDDP ctddp;
  final int isChecked;
  final void Function(CTDDP) updatectddp;

  @override
  State<itemsCTDDPUser> createState() => _itemsCTDDPUserState();
}

class _itemsCTDDPUserState extends State<itemsCTDDPUser> {
  late CTDDP ctddp;
  late int isChecked;
  late bool visble = false;
  late Loaiphong loaiphong;
  late List<ImageLoaiPhong>? list;

  _getData() async {
    final a = await getLoaiPhong(ctddp.UIDLoaiPhong);
    final b = await getImageLoaiPhong(ctddp.UIDLoaiPhong.toString());
    setState(() {
      loaiphong = a;
      list = b;
      visble = true;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctddp = widget.ctddp;
    isChecked = widget.isChecked;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return list == null
        ? Text("")
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Visibility(
              visible: visble,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                    color: AppColor.secondPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Visibility(
                        visible: visble,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 5 / 8,
                                      child: Text(
                                        "${loaiphong.TenLoaiPhong}",
                                        style: AppStyles.h5.copyWith(
                                            color: AppColor.textColor),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: size.width * 1 / 4,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoaiPhongAdminDetails(
                                                          loaiphong: loaiphong,
                                                          dsHinhAnh: list!),
                                                ));
                                          },
                                          icon: Icon(Icons.info),
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 1 / 3,
                                      child: Text(
                                        "Number Room",
                                        style: AppStyles.h5.copyWith(
                                            color: AppColor.textColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: IconButton(
                                          onPressed: () {
                                            if(isChecked==0) {
                                              if (ctddp.soLuongPhong > 0) {
                                                setState(() {
                                                  ctddp.soLuongPhong -= 1;
                                                  ctddp.Tien=loaiphong.Gia*ctddp.SoNgayO*ctddp.soLuongPhong;
                                                });
                                                widget.updatectddp(ctddp);
                                              }
                                            }
                                          },
                                          icon: Icon(Icons.minimize_rounded)),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                            ctddp.soLuongPhong.toString())),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: IconButton(
                                          onPressed: () {
                                            if(isChecked==0) {
                                              if (ctddp.soLuongPhong <=
                                                  loaiphong.phongConLai) {
                                                setState(() {
                                                  ctddp.soLuongPhong += 1;
                                                  ctddp.Tien=loaiphong.Gia*ctddp.SoNgayO*ctddp.soLuongPhong;
                                                });
                                              }
                                              widget.updatectddp(ctddp);
                                            }
                                          },
                                          icon: Icon(Icons.add)),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 1 / 3,
                                      child: Text(
                                        "Days",
                                        style: AppStyles.h5.copyWith(
                                            color: AppColor.textColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: IconButton(

                                          onPressed: () {
                                            if(isChecked==0) {
                                              if (ctddp.SoNgayO > 0) {

                                                setState(() {
                                                  ctddp.SoNgayO -= 1;
                                                  ctddp.Tien=loaiphong.Gia*ctddp.SoNgayO*ctddp.soLuongPhong;
                                                });
                                              }
                                              widget.updatectddp(ctddp);
                                            }
                                          },
                                          icon: Icon(Icons.minimize_rounded)),
                                    ),
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(left: 30),
                                        child: Text(
                                            ctddp.SoNgayO.toString())),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: IconButton(
                                          onPressed: () {
                                            if(isChecked==0) {

                                              setState(() {
                                                ctddp.SoNgayO += 1;
                                                ctddp.Tien=loaiphong.Gia*ctddp.SoNgayO*ctddp.soLuongPhong;
                                              });
                                              widget.updatectddp(ctddp);
                                            }
                                          },
                                          icon: Icon(Icons.add)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
