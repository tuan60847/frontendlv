import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontendlv/models/CTDDP.dart';
import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/responsity/CTDDPResponsity.dart';
import 'package:frontendlv/responsity/DonDatPhongResponsity.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/LoaiPhongDetailsUser.dart';
import 'package:intl/intl.dart';

import '../../Control/ConverEntity.dart';
import '../../models/ImageLoaiPhong.dart';
import '../../models/SharePreferenceKH.dart';
import '../../models/loaiphong.dart';
import '../../responsity/ImageLoaiPhongResponsity.dart';
import '../../responsity/KhachHangResponsity.dart';
import '../../values/app_assets.dart';
import '../../values/app_http.dart';
import '../../values/app_styles.dart';

class itemsLoaiPhongUser extends StatefulWidget {
  const itemsLoaiPhongUser({Key? key, required this.loaiphong})
      : super(key: key);
  final Loaiphong loaiphong;

  @override
  State<itemsLoaiPhongUser> createState() => _itemsLoaiPhongUserState();
}

class _itemsLoaiPhongUserState extends State<itemsLoaiPhongUser> {
  late Loaiphong loaiphong;
  List<ImageLoaiPhong> _dsHALoaiPhong = [];
  late String HinhAnhsrc;
  bool PcAcesss = false;
  bool _Visble = true;
  late KhachHang khachHang;

  void _getImageLoaiPhong() async {
    final HinhAnhLoaiPhong =
        await getImageLoaiPhong(loaiphong.UIDLoaiPhong.toString());
    setState(() {
      _dsHALoaiPhong = HinhAnhLoaiPhong;
      HinhAnhsrc = "${HTTP.imageSrc}${HinhAnhLoaiPhong[0].src}";
      PcAcesss = true;
    });
  }

  _getKhachHang() async {
    final a = await SharedPreferencesService.getKhachHang();
    setState(() {
      khachHang = a!;
    });
  }

  void DatPhong(BuildContext context) async {
    try {
      final a = await getNewDonDatPhongByEmail(khachHang.email);

      if (a.isChecked == 5) {
        String Thoigian =
        CovertEntity().CovertDateDonDatPhongToString(DateTime.now());
        String UIDDonDatPhong =
            "${khachHang.cmnd}-${loaiphong.UIDKS}-$Thoigian";
        DonDatPhong donDatPhong = DonDatPhong(
            UIDDatPhong: UIDDonDatPhong,
            EmailKH: khachHang.email,
            NgayDatPhong: CovertEntity().CovertDateToString(DateTime.now()),
            isChecked: 0,
            TienCoc: 0);
        final b = await insertDonDatPhong(donDatPhong);
        CTDDP ctddp = CTDDP(
            UIDCTDDP: 0,
            MaDDP: UIDDonDatPhong,
            UIDLoaiPhong: loaiphong.UIDLoaiPhong,
            SoNgayO: 0,
            soLuongPhong: 0,
            Tien: 0);
        final c = await insertCTDDP(ctddp);
      }
      else if (a.isChecked == 0) {
        List<String> listString = a.UIDDatPhong.split('-');
        if (loaiphong.UIDKS == listString[1]) {
          CTDDP ctddp = CTDDP(
              UIDCTDDP: 0,
              MaDDP: a.UIDDatPhong,
              UIDLoaiPhong: loaiphong.UIDLoaiPhong,
              SoNgayO: 0,
              soLuongPhong: 0,
              Tien: 0);
          final c = await insertCTDDP(ctddp);
          thongBaoDaDatPhong(context,1);
        } else {
          thongBaoDaDatPhong(context,0);
        }
      } else {
        thongBaoDaDatPhong(context,0);
      }
    }catch(e)
    {
      String Thoigian =
      CovertEntity().CovertDateDonDatPhongToString(DateTime.now());
      String UIDDonDatPhong =
          "${khachHang.cmnd}-${loaiphong.UIDKS}-$Thoigian";
      DonDatPhong donDatPhong = DonDatPhong(
          UIDDatPhong: UIDDonDatPhong,
          EmailKH: khachHang.email,
          NgayDatPhong: CovertEntity().CovertDateToString(DateTime.now()),
          isChecked: 0,
          TienCoc: 0);
      final b = await insertDonDatPhong(donDatPhong);
      CTDDP ctddp = CTDDP(
          UIDCTDDP: 0,
          MaDDP: UIDDonDatPhong,
          UIDLoaiPhong: loaiphong.UIDLoaiPhong,
          SoNgayO: 0,
          soLuongPhong: 0,
          Tien: 0);
      final c = await insertCTDDP(ctddp);
      khachHang.isDatPhong=true;
      final d = await getSetON(khachHang.email);
      thongBaoDaDatPhong(context,1);


    }
    
  }

  void thongBaoDaDatPhong(BuildContext context,int x)=> showDialog(
      context: context, builder: (context) => AlertDialog(
      title: Text('Thông báo'),
      content: x==0?Text('Đơn Đặt phòng Phòng của bạn đã có xin vui lòng không đặt nữa '):Text('Đơn Đặt phòng Thành Công '),
      actions: [

        TextButton(
          child: Text('OK'),
          onPressed: () {
            // Xử lý khi người dùng chọn Đồng ý
            Navigator.of(context).pop();
          },
        ),
      ],
  ));

  @override
  void initState() {
    // TODO: implement initState
    _getKhachHang();
    super.initState();
    loaiphong = widget.loaiphong;
    _getImageLoaiPhong();
  }


  @override
  Widget build(BuildContext context) {
    String formattedNumber = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(loaiphong.Gia);
    final size = MediaQuery.of(context).size;
    return Visibility(
      visible: _Visble,
      child: Container(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.width * 1 / 5,
                width: size.width * 1 / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(180)),
                  child: PcAcesss
                      ? Image.network("$HinhAnhsrc")
                      : Image.asset(AppAssets.logo),
                ),
              ),
            ),
            Container(
              width: size.width * 1 / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(loaiphong.TenLoaiPhong,
                      style: AppStyles.h5.copyWith(color: AppColor.appbarColor),
                      maxLines: 1),
                  Text(loaiphong.soGiuong),
                  Text("price $formattedNumber"),
                  loaiphong.isMayLanh
                      ? AutoSizeText(
                          "Air-conditioned rooms: Yes",
                          maxLines: 1,
                        )
                      : AutoSizeText(
                          "Air-conditioned rooms: No",
                          maxLines: 1,
                        )
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoaiPhongAdminUser(
                              loaiphong: loaiphong,
                              dsHinhAnh: _dsHALoaiPhong)));
                },
                icon: Icon(Icons.info)),
            IconButton(onPressed: () {
              DatPhong(context);
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }

}

