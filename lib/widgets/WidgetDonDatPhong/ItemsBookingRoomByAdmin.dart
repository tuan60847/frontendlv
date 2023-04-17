import 'package:flutter/material.dart';
import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/responsity/DonDatPhongResponsity.dart';

import 'ItemsBookingAdmin.dart';

class itemsBookingRoomByAdmin extends StatefulWidget {
  const itemsBookingRoomByAdmin({Key? key, required this.khachSan}) : super(key: key);
  final KhachSan khachSan;

  @override
  State<itemsBookingRoomByAdmin> createState() => _itemsBookingRoomByAdminState();
}

class _itemsBookingRoomByAdminState extends State<itemsBookingRoomByAdmin> {
  late KhachSan khachSan;
  List<DonDatPhong> _listDonDatPhong= [];
  
  _getData() async{
    
    final ds = await getDataDonDatPhongProcessing();
    List<DonDatPhong> dstam = [];
    ds.forEach((element) {
      List<String> array = element.UIDDatPhong.split("-");
      if(khachSan.UIDKS==array[1]){
        dstam.add(element);
      }
    });
    setState(() {
      _listDonDatPhong=dstam;
    });
  }





  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachSan =widget.khachSan;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height - 140;
    return _listDonDatPhong.length<0?Text("Loading"):Container(
      height: height,
      child: ListView.builder(
        itemCount: _listDonDatPhong.length,
          itemBuilder: (context, index) {
          return ItemsBookingAdmin(donDatPhong: _listDonDatPhong[index],);
          },),
    )
    ;
  }
}

