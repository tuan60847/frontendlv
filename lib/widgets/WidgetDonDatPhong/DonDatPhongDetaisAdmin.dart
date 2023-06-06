import 'package:flutter/material.dart';
import 'package:frontendlv/responsity/DonDatPhongResponsity.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:intl/intl.dart';

import '../../Control/ConverEntity.dart';
import '../../models/CTDDP.dart';
import '../../models/DonDatPhong.dart';
import '../../models/KhachHang.dart';
import '../../models/KhachSan.dart';
import '../../responsity/CTDDPResponsity.dart';
import '../../responsity/KhachSanResponsity.dart';
import '../../values/app_color.dart';
import '../../values/app_styles.dart';
import '../WidgetCTDDP/ItemsCTDDPUSSER.dart';

class DonDatPhongPageDetails extends StatefulWidget {
  const DonDatPhongPageDetails({Key? key, required this.donDatPhong})
      : super(key: key);
  final DonDatPhong donDatPhong;

  @override
  State<DonDatPhongPageDetails> createState() => _DonDatPhongPageDetailsState();
}

class _DonDatPhongPageDetailsState extends State<DonDatPhongPageDetails> {
  late KhachHang? khachHang;
  late DonDatPhong donDatPhong;
  late KhachSan _khachSan;
  bool chuaxacnhan = false;
  TextEditingController ngaydatPhongControler = new TextEditingController();
  bool visbleKS = false;
  List<String> diachi = [];
  late List<CTDDP> _dsCTDDP;
  String GiaTien = "";
  String ErrorNgayDatPhong = "";

  void _DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime.now().add(Duration(days: 1)),
            lastDate: DateTime.now().add(Duration(days: 14)))
        .then((value) {
      setState(() {
        // print("hello");
        if (donDatPhong.isChecked == 0) {
          ngaydatPhongControler.text =
              CovertEntity().CovertDateToString(value ?? DateTime.now());
        }
      });
    });
  }

  _getData() async {
    List<String> tam = donDatPhong.UIDDatPhong.split("-");
    final a = await getKhachSan(tam[1]);
    final b = await getCTDDPByMaDP(donDatPhong.UIDDatPhong);
    final c = await getKhachHang(donDatPhong.EmailKH);
    setState(() {
      _khachSan = a;
      _dsCTDDP = b;
      khachHang = c;
      GiaTien = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
          .format(donDatPhong.tongtien);
      diachi = a.DiaChi.split(",");
      if (donDatPhong.isChecked != 0) {
        ngaydatPhongControler.text = donDatPhong.NgayDatPhong;
      }
      visbleKS = true;
    });
  }

  _acceptDDP() async {
    if (donDatPhong.isChecked == 1) {
      _dsCTDDP.forEach((element) async {
        final a = await getLoaiPhong(element.UIDLoaiPhong);
        // a.phongConLai = a.phongConLai - element.soLuongPhong;
        final b = await updateloaiphonghave(a);
      });
      donDatPhong.isChecked = 2;
      final c = await updateDonDatPhong(donDatPhong);
      setState(() {
        donDatPhong.isChecked = 2;
      });
    } else if (donDatPhong.isChecked == 2) {
      donDatPhong.isChecked = 3;
      final c = await updateDonDatPhong(donDatPhong);
      setState(() {
        donDatPhong.isChecked = 3;
      });
    }else if (donDatPhong.isChecked == 3) {
      _dsCTDDP.forEach((element) async {
        final a = await getLoaiPhong(element.UIDLoaiPhong);
        // a.phongConLai = a.phongConLai + element.soLuongPhong;
        final b = await updateloaiphonghave(a);
      });
      donDatPhong.isChecked = 5;
      final c = await updateDonDatPhong(donDatPhong);
      setState(() {
        donDatPhong.isChecked = 5;
      });
  }

  }

  _deleteDDP() async {
    if (donDatPhong.isChecked != 0) {
      _dsCTDDP.forEach((element) async {
        final a = await getLoaiPhong(element.UIDLoaiPhong);
        // a.phongConLai = a.phongConLai + element.soLuongPhong;
        final b = await updateloaiphonghave(a);
      });
      donDatPhong.isChecked = 5;
      final c = await updateDonDatPhong(donDatPhong);
      setState(() {
        donDatPhong.isChecked = 5;
      });
    }
  }

  void updatectddp(CTDDP ctddp) {
    donDatPhong.tongtien = 0;
    setState(() {
      _dsCTDDP.forEach((element) {
        if (element.UIDCTDDP == ctddp.UIDCTDDP) {
          element = ctddp;
        }
        donDatPhong.tongtien += element.Tien;
        GiaTien = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
            .format(donDatPhong.tongtien);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    donDatPhong = widget.donDatPhong;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'Booking Details',
          style: AppStyles.h4.copyWith(color: AppColor.primaryColor),
        ),
      ),
      body: khachHang == null
          ? Text("")
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width / 4,
                            child: Text(
                              "ID BOOKING ",
                              style: AppStyles.h5
                                  .copyWith(color: AppColor.textColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: size.width * 5 / 8,
                            child: Text(
                              "${donDatPhong.UIDDatPhong}",
                              style: AppStyles.h5
                                  .copyWith(color: AppColor.textColor),
                            ),
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
                            width: size.width / 4,
                            child: Text(
                              "Email",
                              style: AppStyles.h5
                                  .copyWith(color: AppColor.textColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: size.width * 5 / 8,
                            child: Text(
                              "${donDatPhong.EmailKH}",
                              style: AppStyles.h5
                                  .copyWith(color: AppColor.textColor),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: visbleKS,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width / 4,
                              child: Text(
                                "CMND Custumer",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.width * 5 / 8,
                              child: Text(
                                "${khachHang!.cmnd} ",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: visbleKS,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width / 4,
                              child: Text(
                                "Date Born Custumer",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.width * 5 / 8,
                              child: Text(
                                "${khachHang!.ChuoiNgaySinh}",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: visbleKS,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width / 4,
                              child: Text(
                                "Number Phone User",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.width * 5 / 8,
                              child: Text(
                                "${khachHang!.SDT} ",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: visbleKS,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width / 4,
                              child: Text(
                                "Total",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: size.width * 5 / 8,
                              child: Text(
                                "${GiaTien} ",
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondPrimary,
                      // border: Border.fromBorderSide(BorderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * (3 / 4),
                          child: TextField(
                            controller: ngaydatPhongControler,
                            enabled: false,
                            decoration: InputDecoration(
                                fillColor: Colors.blue,
                                errorText: ErrorNgayDatPhong == ""
                                    ? null
                                    : ErrorNgayDatPhong,
                                border: InputBorder.none,
                                labelText: 'Enter your Date Check IN',
                                // icon: Icon(Icons.mail_outline,),
                                prefixIcon: Icon(Icons.date_range_sharp),
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (donDatPhong.isChecked == 0) {
                                _DatePicker();
                              }
                            },
                            color: Colors.blue,
                            icon: Icon(Icons.date_range_outlined)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: _dsCTDDP.length,
                      itemBuilder: (context, index) => itemsCTDDPUser(
                            ctddp: _dsCTDDP[index],
                            isChecked: donDatPhong.isChecked,
                            updatectddp: updatectddp,
                          )),
                ),
                Visibility(
                  visible: donDatPhong.isChecked == 0 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Container(
                        height: 50,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColor.buttonColorPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        alignment: Alignment.center,
                        child: Text(
                          "Booking Room",
                          style: AppStyles.h4
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: donDatPhong.isChecked != 0
                      ? true
                      : donDatPhong.isChecked != 5
                          ? true
                          : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: MaterialButton(
                      onPressed: () {
                        _acceptDDP();
                      },
                      child: Container(
                        height: 50,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: donDatPhong.isChecked == 1
                                ? AppColor.greenCheckingButtonColor
                                : donDatPhong.isChecked == 2
                                    ? AppColor.greenAcpectedButtonColor
                                    : AppColor.greenAcpectedButtonColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        alignment: Alignment.center,
                        child: donDatPhong.isChecked == 1
                            ? Text("Accept Booking room",
                                style: AppStyles.h4
                                    .copyWith(color: AppColor.primaryColor))
                            : donDatPhong.isChecked == 2
                                ? Text("Check In",
                                    style: AppStyles.h4
                                        .copyWith(color: AppColor.primaryColor))
                                : Text("Check out",
                                    style: AppStyles.h4.copyWith(
                                        color: AppColor.primaryColor)),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: donDatPhong.isChecked == 0||donDatPhong.isChecked == 5||donDatPhong.isChecked == 3?false:true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: MaterialButton(
                      onPressed: () {
                        _deleteDDP();
                      },
                      child: Container(
                        height: 50,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColor.appbarColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        alignment: Alignment.center,
                        child: Text(
                          "Delete Booking Room",
                          style: AppStyles.h4
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
