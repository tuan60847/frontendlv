import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendlv/Control/Validate.dart';
import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/responsity/ImageLoaiPhongResponsity.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/ImageLoaiPhong.dart';
import '../../values/app_styles.dart';

class pageLoaiPhongRepair extends StatefulWidget {
  const pageLoaiPhongRepair(
      {Key? key, required this.loaiPhong, required this.dsHinhAnh})
      : super(key: key);
  final Loaiphong loaiPhong;
  final List<ImageLoaiPhong> dsHinhAnh;

  @override
  State<pageLoaiPhongRepair> createState() => _pageLoaiPhongRepairState();
}

class _pageLoaiPhongRepairState extends State<pageLoaiPhongRepair> {
  TextEditingController TenLoaiPhongController = new TextEditingController();
  TextEditingController PricesControler = new TextEditingController();
  String SoLuongGiuong = "1 Single Bed";
  TextEditingController soLuongPhongController = new TextEditingController();
  bool isMayLanh = false;
  final List<String> listSoLuongGiuong = [
    "1 Single Bed",
    "2  Single Bed",
    "1  Couple Bed",
    "2 Couple Bed"
  ];

  String ErrorTenLP = "";
  String ErrorPrices = "";
  String ErrorSoLuongGiuong = "";
  String ErrorsoLuongPhong = "";

  File? ImageFile, ImageFile2, ImageFile3;
  final _ImagePicker = ImagePicker();

  _resetError() {
    ErrorTenLP = "";
    ErrorPrices = "";
    ErrorSoLuongGiuong = "";
    ErrorsoLuongPhong = "";
  }

  _PickImageGallery() async {
    final XFile? image =
        await _ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ImageFile = File(image.path);
      });
    }
  }

  _PickImageGallery2() async {
    final XFile? image =
        await _ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ImageFile2 = File(image.path);
      });
    }
  }

  _PickImageGallery3() async {
    final XFile? image =
        await _ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ImageFile3 = File(image.path);
      });
    }
  }

  _checkedInforLoaiPhong(int UIDLoaiPhong, String TenLoaiPhong, String Gia,
      String LoaiGiuong, String SoLuongPhong, bool isAirCondition) async {
    _resetError();
    if (TenLoaiPhong == "" || Gia == "" || SoLuongPhong == "") {
      setState(() {
        if (TenLoaiPhong == "") ErrorTenLP = "Please set Name Hotel";
        if (Gia == "") ErrorPrices = "Please set price Hotel";
        if (SoLuongPhong == "")
          ErrorsoLuongPhong = "Please set Number Room Hotel";
      });
    } else {
      if (!Validate().isValidNumber(SoLuongPhong) ||
          !Validate().isValidPrices(Gia)) {
        setState(() {
          if (!Validate().isValidPrices(Gia)) {
            ErrorPrices = "Error form Prices Room not small 10000";
            PricesControler.text = "";
          }
          if (!Validate().isValidNumber(SoLuongPhong)) {
            ErrorsoLuongPhong = "Error form Number";
            soLuongPhongController.text = "";
          }
        });
      } else {
        int giachinh = int.parse(Gia);
        int SoLuongPhongchinh = int.parse(SoLuongPhong);
        Loaiphong loaiphong = new Loaiphong(
            UIDLoaiPhong: UIDLoaiPhong,
            TenLoaiPhong: TenLoaiPhong,
            Gia: giachinh,
            UIDKS: UIDKS,
            soGiuong: LoaiGiuong,
            soLuongPhong: SoLuongPhongchinh,
            isMayLanh: isAirCondition);
        try {
          final a = await updateloaiphong(loaiphong);

          if (ImageFile != null) {
            if(dsHinhAnh[0]!=null){
              bool xacNhanXoa= await deleteImageLoaiPhong(dsHinhAnh[0].src);
              print(xacNhanXoa);
            }
            bool xacNhan =
                await uploadImageLoaiPhong(UIDLoaiPhong, ImageFile!);
            print(xacNhan.toString());
          }
          if (ImageFile2 != null) {
            if(dsHinhAnh[1]!=null){
              bool xacNhanXoa= await deleteImageLoaiPhong(dsHinhAnh[1].src);
              print(xacNhanXoa);
            }
            bool xacNhan =
                await uploadImageLoaiPhong(UIDLoaiPhong, ImageFile2!);
            print(xacNhan.toString());
          }
          if (ImageFile3 != null) {
            if(dsHinhAnh[2]!=null){
              bool xacNhanXoa= await deleteImageLoaiPhong(dsHinhAnh[2].src);
              print(xacNhanXoa);
            }
            bool xacNhan =
                await uploadImageLoaiPhong(UIDLoaiPhong, ImageFile3!);
            print(xacNhan.toString());
          }
          Navigator.pop(context);
        } catch (e) {
          print("lỗi ");
        }
      }
    }
  }

  late String UIDKS;
  late Loaiphong loaiphongtam;
  late List<ImageLoaiPhong> dsHinhAnh;

  _getData() {
    TenLoaiPhongController.text = loaiphongtam.TenLoaiPhong;
    PricesControler.text = loaiphongtam.Gia.toString();
    SoLuongGiuong = loaiphongtam.soGiuong;
    soLuongPhongController.text = loaiphongtam.soLuongPhong.toString();
    isMayLanh = loaiphongtam.isMayLanh;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UIDKS = widget.loaiPhong.UIDKS;
    loaiphongtam = widget.loaiPhong;
    dsHinhAnh = widget.dsHinhAnh;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'REPAIR KIND OF ROOM',
          style: AppStyles.h4.copyWith(color: AppColor.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.secondPrimary,
                  // border: Border.fromBorderSide(BorderSide),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  controller: TenLoaiPhongController,
                  decoration: InputDecoration(
                      errorText: ErrorTenLP == "" ? null : ErrorTenLP,
                      fillColor: Colors.blue,
                      border: InputBorder.none,
                      labelText: 'Enter your Hotel Name',
                      // icon: Icon(Icons.mail_outline,),
                      prefixIcon: Icon(Icons.hotel_class),
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.secondPrimary,
                  // border: Border.fromBorderSide(BorderSide),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  controller: PricesControler,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                      errorText: ErrorPrices == "" ? null : ErrorPrices,
                      fillColor: Colors.blue,
                      border: InputBorder.none,
                      labelText: 'Enter your Room prices',
                      // icon: Icon(Icons.mail_outline,),
                      prefixIcon: Icon(Icons.price_change),
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.secondPrimary,
                    // border: Border.fromBorderSide(BorderSide),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.bed,
                          color: AppColor.textGray,
                        ),
                      ),
                      DropdownButton<String>(
                        value: SoLuongGiuong,
                        items: listSoLuongGiuong.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                width: size.width * 3 / 4, child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            SoLuongGiuong = newValue ?? "";
                          });
                        },
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.secondPrimary,
                  // border: Border.fromBorderSide(BorderSide),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  controller: soLuongPhongController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                      errorText:
                          ErrorsoLuongPhong == "" ? null : ErrorsoLuongPhong,
                      fillColor: Colors.blue,
                      border: InputBorder.none,
                      labelText: 'Enter your Number Room ',
                      // icon: Icon(Icons.mail_outline,),
                      prefixIcon: Icon(Icons.door_back_door),
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.secondPrimary,
                    // border: Border.fromBorderSide(BorderSide),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.air_rounded,
                          color: AppColor.textGray,
                        ),
                      ),
                      Container(
                        width: size.width * 4 / 5,
                        child: CheckboxListTile(
                          value: isMayLanh,
                          onChanged: (bool? value) {
                            setState(() {
                              isMayLanh = value ?? false;
                            });
                          },
                          title: Text("is Room with air-conditioner"),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _PickImageGallery,
                  child: Container(
                    width: size.width / 3,
                      child: ImageFile != null
                          ? Image.file(ImageFile!)
                          : dsHinhAnh.length>0
                          ? Image.network(
                          "${HTTP.imageSrc}${dsHinhAnh[0].src}")
                          : Image.asset(AppAssets.logo)
                  ),
                ),
                Text("Picture One")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _PickImageGallery2,
                  child: Container(
                    width: size.width / 3,
                      child: ImageFile2 != null
                          ? Image.file(ImageFile2!)
                          : dsHinhAnh.length>1
                          ? Image.network(
                          "${HTTP.imageSrc}${dsHinhAnh[1].src}")
                          : Image.asset(AppAssets.logo)
                  ),
                ),
                Text("Picture two")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _PickImageGallery3,
                  child: Container(
                      width: size.width / 3,
                      child: ImageFile3 != null
                          ? Image.file(ImageFile3!)
                          : dsHinhAnh.length>2
                              ? Image.network(
                                  "${HTTP.imageSrc}${dsHinhAnh[2].src}")
                              : Image.asset(AppAssets.logo)
                  ),
                ),
                Text("Picture Three")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * 1 / 4,
              height: size.width * 1 / 4,
              child: RawMaterialButton(
                onPressed: () {
                  // checkInforKS(UIDKS.toString(),TenKhachSanController.value.text,AndressCityController.value.text,
                  //     AndressDistrictsController.value.text,AndressWardController.value.text,AndressController.value.text,
                  //     SDTController.value.text
                  // );
                  // _checkedInforLoaiPhong(String TenLoaiPhong, String Gia, String LoaiGiuong,
                  //     String SoLuongPhong, bool isAirCondition)
                  _checkedInforLoaiPhong(
                      loaiphongtam.UIDLoaiPhong,
                      TenLoaiPhongController.value.text,
                      PricesControler.value.text,
                      SoLuongGiuong,
                      soLuongPhongController.value.text,
                      isMayLanh);
                },
                fillColor: AppColor.buttonColorSecond,
                shape: CircleBorder(),
                child: Image.asset(AppAssets.rightArrow,
                    color: AppColor.secondPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
