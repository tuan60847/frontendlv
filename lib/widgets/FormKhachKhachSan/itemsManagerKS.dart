

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontendlv/models/ImageKhachSan.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/pages/QLLoaiPhong.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/FormKhachKhachSan/formRepairKhachSan.dart';

import '../../models/loaiphong.dart';
import '../../responsity/ImageKSReponsity.dart';
import '../../values/app_color.dart';
import '../../values/app_http.dart';

class itemsManagerKS extends StatefulWidget {
  const itemsManagerKS(
      {Key? key, required this.khachSan, required this.repairKhachSan})
      : super(key: key);
  final KhachSan khachSan;

  final bool repairKhachSan;

  @override
  State<itemsManagerKS> createState() => _itemsManagerKSState();
}

class _itemsManagerKSState extends State<itemsManagerKS> {
  late KhachSan khachSan;
  late ImageKS _imageKS;
  late String HinhAnhsrc;
  bool initPic = false;
  late bool repairKhachSan;
  List<Loaiphong> _loaiphongs = [];

  void _findHA() async {
    try {
      final HAKS = await getImageKS(khachSan.UIDKS);
      setState(() {
        _imageKS = HAKS;
        HinhAnhsrc = "${HTTP.imageSrc}${_imageKS.src}";
        initPic = true;
      });
    } catch (e) {
      print("Lỗi");
    }
  }

  void _findloaiPhong() async {
    try {
      final loaiphonga = await getLoaiPhongByUIDKS(khachSan.UIDKS);
      setState(() {
        _loaiphongs = loaiphonga;
      });
    } catch (e) {
      print("Lỗi");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachSan = widget.khachSan;
    repairKhachSan = widget.repairKhachSan;
    _findHA();
    _findloaiPhong();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = repairKhachSan ? size.height - 160 : size.height;
    List<String> array= khachSan.DiaChi.split(",");
    return Container(
      height: height * 1,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.5 - 50,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  image: initPic == false
                      ? DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(AppAssets.logo))
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("$HinhAnhsrc")),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    if (repairKhachSan) {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ,))
                      if(initPic)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RepairKhachSan(khachSan: khachSan,UriHinhAnh: _imageKS.src)));
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RepairKhachSan(khachSan: khachSan)));
                      }
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QLLoaiPhongPage(loaiphongs: _loaiphongs, admin: false, UIDKS: khachSan.UIDKS),));
                    }
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: AppColor.secondPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 50,
                              color: AppColor.primaryColor)
                        ]),
                    child: Center(
                      child: repairKhachSan
                          ? Text("Repair Information",
                              style: AppStyles.h4
                                  .copyWith(color: AppColor.appbarColor))
                          : Text("book room",
                              style: AppStyles.h4
                                  .copyWith(color: AppColor.appbarColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AutoSizeText(
                        "${khachSan.TenKS}",
                        style: AppStyles.h3.copyWith(color: AppColor.textColor),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        "${array[0]},ward :${array[1]},District :${array[2]},${array[3]} city",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                        maxLines: 2,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if(repairKhachSan){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QLLoaiPhongPage(loaiphongs: _loaiphongs, admin: true, UIDKS: khachSan.UIDKS),));

                    }else{

                      print("Lưu");
                    }

                  },
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                        color: AppColor.buttonColorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: repairKhachSan!=true?Icon(Icons.book_outlined):Icon(Icons.list_alt),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
             alignment: Alignment.centerLeft,
              child: Text(
                "Number Kind of Room: ${_loaiphongs.length.toString()}",
                style: AppStyles.h5.copyWith(color: AppColor.textColor),
              ),
            ),
          ),
          SizedBox(
            height: height / 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number: ${khachSan.SDT.toString()}",
                style: AppStyles.h5.copyWith(color: AppColor.textColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
