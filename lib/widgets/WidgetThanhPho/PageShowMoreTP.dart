import 'package:flutter/material.dart';
import 'package:frontendlv/values/app_styles.dart';

import '../../models/ThanhPho.dart';
import '../../values/app_color.dart';

class PageShowMoreThanhPho extends StatefulWidget {
  const PageShowMoreThanhPho({Key? key, required this.thanhphos})
      : super(key: key);
  final List<ThanhPho> thanhphos;

  @override
  State<PageShowMoreThanhPho> createState() => _PageShowMoreThanhPhoState();
}

class _PageShowMoreThanhPhoState extends State<PageShowMoreThanhPho> {
  late List<ThanhPho> thanhpho = <ThanhPho>[];
  ScrollController _scrollController = ScrollController();
  int a = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thanhpho = widget.thanhphos;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void loadData() {

    setState(() {
      a +=5 ;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      // Kiểm tra nếu đến cuối danh sách và ngừng cuộn
      loadData();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "City",
          style: AppStyles.h4.copyWith(color: AppColor.buttonColorPrimary),
        ),
      ),
      body: ListView.builder(
        itemCount: a,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Text("${thanhpho[index].TenTP}");
        },

      ),

    );
  }
}
