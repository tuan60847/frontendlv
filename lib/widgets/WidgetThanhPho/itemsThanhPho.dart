import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontendlv/models/ImageThanhPho.dart';
import 'package:frontendlv/responsity/ImageTPReponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/WidgetThanhPho/PageThanhPhoDetail.dart';

import '../../models/ThanhPho.dart';

class itemsThanhPho extends StatefulWidget {
  const itemsThanhPho({Key? key, required this.thanhPho}) : super(key: key);
  final ThanhPho thanhPho;

  @override
  State<itemsThanhPho> createState() => _itemsThanhPhoState();
}

class _itemsThanhPhoState extends State<itemsThanhPho> {
  late ThanhPho thanhPho;
  List<ImageTP> _list= <ImageTP>[];

  void _getImageThanhPho() async{
    final ImageTPs= await getImageTP(thanhPho.MaTP.toString());
    setState(() {
      _list=ImageTPs;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thanhPho = widget.thanhPho;
    _getImageThanhPho();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PageThanhPhoDetails(thanhPho: thanhPho,listImageTP: _list),));
          
        },
        child: Container(
          height: size.height,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: AppColor.textColor),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height*1/8,
                width: size.height*1/8,
                child: ClipRRect(
                  child: _list.length==0?Image.asset(AppAssets.logo):Image.network(HTTP.imageSrc+_list[0].src),
                  borderRadius: BorderRadius.all(Radius.circular(180)),
                ),
              ),
              AutoSizeText(thanhPho.TenTP,style: AppStyles.h5.copyWith(color: AppColor.textColor),textAlign: TextAlign.center,maxLines: 2,)
            ],
          ),
        ),
      ),
    );
  }
}


