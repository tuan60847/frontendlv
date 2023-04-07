import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/responsity/ImageKSReponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';

import 'package:frontendlv/values/app_http.dart';

import '../models/ImageKhachSan.dart';
import '../pages/PageInforKhachSan.dart';

class ItemsKSContainer extends StatefulWidget {
  const ItemsKSContainer({Key? key, required this.khachsan}) : super(key: key);
  final KhachSan khachsan;

  @override
  State<ItemsKSContainer> createState() => _ItemsKSContainerState();
}

class _ItemsKSContainerState extends State<ItemsKSContainer> {
  late KhachSan khachSan;
  late ImageKS _imageKS;
  late String HinhAnhsrc;
  bool initPic = false;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachSan = widget.khachsan;
    _findHA();
    // khachsan = widget.khachsan;
  }

  @override
  Widget build(BuildContext context) {
    khachSan = widget.khachsan;
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),

      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PageInformationKhachSan(khachSan: khachSan)));

        },
        child: Row(children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              child: initPic
                  ? Image.network("$HinhAnhsrc")
                  : Image.asset(AppAssets.logo),
              borderRadius: BorderRadius.circular(180),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    khachSan.TenKS.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.textColor),
                  ),
                  SizedBox(
                    width: size.width * 3 / 4,
                    child: Text(khachSan.DiaChi.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColor.textColor)),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
