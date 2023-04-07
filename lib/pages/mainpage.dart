import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/pages/AdminKH_Page.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart';
import 'package:frontendlv/responsity/KhachSanResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/widgets/itemsksContainer.dart';


class mainPage extends StatefulWidget {
  const mainPage({Key? key, required this.khachHang}) : super(key: key);
  final KhachHang khachHang;

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  late KhachHang khachHang;
  late List<KhachSan> listKS=<KhachSan>[];

  void _fetchAllKS() async{
    final khachsans= await getDataKS();
    setState(() {
      listKS= khachsans;
    });
  }

  void _enterADMINKS() async{
    if(khachHang.isAdminKH==""){
      bool kt = await getIsAdmin(khachHang.email);
      khachHang.isAdminKH = "${khachHang.cmnd}_${khachHang.SDT}";
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => adminKH_Page(UIDKS: khachHang.isAdminKH),));


  }

  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    _fetchAllKS();
  }


  @override
  Widget build(BuildContext context) {
    khachHang = widget.khachHang;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        toolbarHeight: 100,
        title: Text('Hello ${khachHang.HoTen}',style: TextStyle(color: AppColor.buttonColorPrimary),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.hotel),
              onPressed:_enterADMINKS,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(AppAssets.logo),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(onPressed: (){},
                    color: AppColor.yellowButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))
                    ),
                    child: Text("Khách Sạn"),
                  ),
                  MaterialButton(onPressed: (){},
                    color: AppColor.yellowButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))
                    ),
                    child: Text("Nhà Nghỉ"),
                  )
                ],
              )
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listKS.length,
          itemBuilder: (context, index) {
              return ItemsKSContainer(khachsan: listKS[index],);
          },
      )
    );
  }
}



