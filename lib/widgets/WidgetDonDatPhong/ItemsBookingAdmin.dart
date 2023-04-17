import 'package:flutter/material.dart';
import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/WidgetDonDatPhong/DonDatPhongDetaisAdmin.dart';
import 'package:intl/intl.dart';

import '../../responsity/CTDDPResponsity.dart';
import '../../responsity/DonDatPhongResponsity.dart';
import '../../responsity/loaiphongResponsity.dart';

class ItemsBookingAdmin extends StatefulWidget {
  const ItemsBookingAdmin({Key? key, required this.donDatPhong})
      : super(key: key);
  final DonDatPhong donDatPhong;

  @override
  State<ItemsBookingAdmin> createState() => _ItemsBookingAdminState();
}

class _ItemsBookingAdminState extends State<ItemsBookingAdmin> {
  late DonDatPhong _donDatPhong;
  String GiaTien = "";

  _getData() {
    setState(() {
      GiaTien = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
          .format(_donDatPhong.tongtien);
    });
  }

  void setDonDatPhong(DonDatPhong donDatPhong){
    setState(() {
      _donDatPhong=donDatPhong;
    });
  }

  _acceptDDP() async{
    if(_donDatPhong.isChecked==1){
      final tam = await getCTDDPByMaDP(_donDatPhong.UIDDatPhong);
      tam.forEach((element) async {
        final a = await getLoaiPhong(element.UIDLoaiPhong);
        a.phongConLai=a.phongConLai-element.soLuongPhong;
        final b = await updateloaiphonghave(a);
      });
      _donDatPhong.isChecked=2;
      final c = await updateDonDatPhong(_donDatPhong);
      setState(() {
        _donDatPhong.isChecked=2;
      });
    }
    else if(_donDatPhong.isChecked==2){
      _donDatPhong.isChecked=3;
      final c = await updateDonDatPhong(_donDatPhong);
      setState(() {
        _donDatPhong.isChecked=3;
      });
    }
    else if(_donDatPhong.isChecked==3){
      _donDatPhong.isChecked=3;
      final c = await updateDonDatPhong(_donDatPhong);
      setState(() {
        _donDatPhong.isChecked=5;
      });
    }
  }

  _deleteDDP() async{
    if(_donDatPhong.isChecked!=0&&_donDatPhong.isChecked!=5){
      final tam = await getCTDDPByMaDP(_donDatPhong.UIDDatPhong);
      tam.forEach((element) async {
        final a = await getLoaiPhong(element.UIDLoaiPhong);
        a.phongConLai=a.phongConLai+element.soLuongPhong;
        final b = await updateloaiphonghave(a);
      });
      _donDatPhong.isChecked=5;
      final c = await updateDonDatPhong(_donDatPhong);
      setState(() {
        _donDatPhong.isChecked=5;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _donDatPhong = widget.donDatPhong;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _donDatPhong == null
        ? Text("")
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 170,
                decoration: const BoxDecoration(
                    color: AppColor.secondPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: size.width * 3 / 4,
                              child: Text(
                                _donDatPhong.UIDDatPhong,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DonDatPhongPageDetails(
                                              donDatPhong: _donDatPhong),
                                    ));
                              },
                              icon: Icon(
                                Icons.info_outlined,
                                color: AppColor.appbarColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: size.width * 1 / 2,
                              child: Text(
                                "prices: $GiaTien",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: MaterialButton(
                              onPressed: () {
                                print("hello");
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                child: Container(
                                  alignment: Alignment.center,
                                  color: AppColor.greenAcpectedButtonColor,
                                  width: size.width/4,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: _donDatPhong.isChecked==1?Text("Accept"):_donDatPhong.isChecked==2?Text("Check In"):Text("Check out"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: size.width * 1 / 2,
                              child: Text(
                                "Email: ${_donDatPhong.EmailKH}",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: AppStyles.h5
                                    .copyWith(color: AppColor.textColor),
                              )),
                          Visibility(
                            visible: _donDatPhong.isChecked!=3?true:false,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: MaterialButton(
                                onPressed: () {
                                  print("hello");
                                },
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width/4,
                                    color: AppColor.buttonColorPrimary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      "Cancel",
                                      style: AppStyles.h5
                                          .copyWith(color: AppColor.textColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
  }
}
