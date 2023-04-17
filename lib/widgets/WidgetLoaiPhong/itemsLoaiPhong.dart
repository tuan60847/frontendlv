import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/LoaiPhongDetailsAdmin.dart';
import 'package:frontendlv/widgets/WidgetLoaiPhong/formLoaiPhongRepair.dart';
import 'package:intl/intl.dart';

import '../../models/ImageLoaiPhong.dart';
import '../../responsity/ImageLoaiPhongResponsity.dart';
import '../../values/app_color.dart';
import '../../values/app_http.dart';

class KindRoomAdmin extends StatefulWidget {
  const KindRoomAdmin({Key? key, required this.LoaiPhong}) : super(key: key);
  final Loaiphong LoaiPhong;

  @override
  State<KindRoomAdmin> createState() => _KindRoomAdminState();
}

class _KindRoomAdminState extends State<KindRoomAdmin> {
  late Loaiphong loaiphong;
  List<ImageLoaiPhong> _dsHALoaiPhong = [];
  late String HinhAnhsrc;
  bool PcAcesss = false;
  bool _Visble = true;

  void _getImageLoaiPhong() async {
    final HinhAnhLoaiPhong =
        await getImageLoaiPhong(loaiphong.UIDLoaiPhong.toString());
    setState(() {
      _dsHALoaiPhong = HinhAnhLoaiPhong;
      HinhAnhsrc = "${HTTP.imageSrc}${HinhAnhLoaiPhong[0].src}";
      PcAcesss = true;
    });
  }

  _Deleteloai() async{
    _dsHALoaiPhong.forEach((element) async {
      bool a = await deleteImageLoaiPhong(element.src) ;
      print(a);
    });
    bool a = await deleteLoaiPhong(loaiphong);
    print(a);

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaiphong = widget.LoaiPhong;
    _getImageLoaiPhong();
  }

  @override
  Widget build(BuildContext context) {
    String formattedNumber = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(loaiphong.Gia);
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
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(180)),
                  child: PcAcesss
                      ? Image.network("$HinhAnhsrc")
                      : Image.asset(AppAssets.logo),
                ),
              ),
            ),
            Container(
              width: 150,
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
                          builder: (context) => LoaiPhongAdminDetails(
                              loaiphong: loaiphong,
                              dsHinhAnh: _dsHALoaiPhong)));
                },
                icon: Icon(Icons.info)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pageLoaiPhongRepair(
                            loaiPhong: loaiphong, dsHinhAnh: _dsHALoaiPhong),
                      ));
                },
                icon: Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  _Deleteloai();
                  setState(() {
                    _Visble = false;
                  });
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
