

import 'package:flutter/material.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_styles.dart';
import 'package:frontendlv/widgets/FormKhachKhachSan/itemsManagerKS.dart';

class bodyManageHotel extends StatefulWidget {
  const bodyManageHotel({Key? key, required this.khachSan}) : super(key: key);
  final KhachSan khachSan;

  @override
  State<bodyManageHotel> createState() => _bodyManageHotelState();
}

class _bodyManageHotelState extends State<bodyManageHotel> {
  int selectItems= 0;
  late  KhachSan khachSan;
  void updateParentValue(int newValue) {
    setState(() {
      selectItems = newValue;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachSan= widget.khachSan;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CataloryKSManager(childValue: selectItems,updateParentValue: updateParentValue,),
        Container(
          // child: selectItems==0?itemsManagerKS(khachSan: khachSan):Text("xinchaof")
            child: selectItems==0?itemsManagerKS(khachSan: khachSan,repairKhachSan: true,):Text("xinchaof")
        )
      ],
    );
  }
}


class CataloryKSManager extends StatefulWidget {
  const CataloryKSManager({Key? key, required this.childValue, required this.updateParentValue}) : super(key: key);
  final int childValue;
  final void Function(int) updateParentValue;



  @override
  State<CataloryKSManager> createState() => _CataloryKSManagerState();
}

class _CataloryKSManagerState extends State<CataloryKSManager> {
  int selectItem = 0;
  List<String> itemsList = ["Information Hotel", "Room Booking List"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectItem=widget.childValue;
  }


  @override
  Widget build(BuildContext context) {

    return Container(
        height: 60,
        width: double.infinity,
        child: ListView.builder(
          itemCount: itemsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return BuildCatalogyKS(context, index);
          },
        ));
  }

  Padding BuildCatalogyKS(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: GestureDetector(
        onTap: (){
          setState(() {
            selectItem = index;
          });
          widget.updateParentValue(index);

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemsList[index].toString(),
                style: AppStyles.h4.copyWith(
                    color:  index==selectItem? AppColor.textColor:AppColor.textGray.withOpacity(0.7), 
                    fontWeight: FontWeight.w500)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16/2),
              height: 6,
              width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: index==selectItem? AppColor.buttonColorPrimary:Colors.transparent

              ),

            )
          ],
        ),
      ),
    );
  }
}
