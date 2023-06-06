import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendlv/Control/Validate.dart';
import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/responsity/ImageLoaiPhongResponsity.dart';
import 'package:frontendlv/responsity/loaiphongResponsity.dart';
import 'package:frontendlv/values/app_assets.dart';
import 'package:frontendlv/values/app_color.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/app_styles.dart';

class pageLoaiPhongRegister extends StatefulWidget {
  const pageLoaiPhongRegister({Key? key, required this.UIDKS})
      : super(key: key);
  final String UIDKS;

  @override
  State<pageLoaiPhongRegister> createState() => _pageLoaiPhongRegisterState();
}

class _pageLoaiPhongRegisterState extends State<pageLoaiPhongRegister> {
  TextEditingController TenLoaiPhongController = new TextEditingController();
  TextEditingController PricesControler = new TextEditingController();
  String SoLuongGiuong =  "1 Single Bed";
  TextEditingController soLuongPhongController = new TextEditingController();

  final List<String> listSoLuongGiuong = [
    "1 Single Bed",
    "2  Single Bed",
    "1  Couple Bed",
    "2 Couple Bed"
  ];

  bool isMayLanh = false;
  String ErrorTenLP = "";
  String ErrorPrices = "";
  String ErrorSoLuongGiuong = "";
  String ErrorsoLuongPhong = "";

  File? ImageFile, ImageFile2, ImageFile3;
  final _ImagePicker = ImagePicker();
_resetError(){
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

  _checkedInforLoaiPhong(String TenLoaiPhong, String Gia, String LoaiGiuong,
      String SoLuongPhong, bool isAirCondition) async {
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
            UIDLoaiPhong: 0,
            TenLoaiPhong: TenLoaiPhong,
            Gia: giachinh,
            UIDKS: UIDKS,
            soGiuong: LoaiGiuong,
            soLuongPhong: SoLuongPhongchinh,
            isMayLanh: isAirCondition
        );
        try {
          final a = await insertloaiphong(loaiphong);
          final  b =await getFindLastLoaiPhong(UIDKS);
          if(ImageFile!=null){
            bool xacNhan = await  uploadImageLoaiPhong(b.UIDLoaiPhong,ImageFile!);
            print(xacNhan.toString());
          }
          if(ImageFile2!=null){
            bool xacNhan = await  uploadImageLoaiPhong(b.UIDLoaiPhong,ImageFile2!);
            print(xacNhan.toString());
          }
          if(ImageFile3!=null){
            bool xacNhan = await  uploadImageLoaiPhong(b.UIDLoaiPhong,ImageFile3!);
            print(xacNhan.toString());
          }



        } catch (e) {
          print("lỗi ");
        }
        Navigator.pop(context);

      }
    }
  }

  late String UIDKS;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UIDKS = widget.UIDKS;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'ADD KIND OF ROOM',
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
                    child: ImageFile == null
                        ? Image.asset(AppAssets.logo)
                        : Image.file(ImageFile!),
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
                    child: ImageFile2 == null
                        ? Image.asset(AppAssets.logo)
                        : Image.file(ImageFile2!),
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
                    child: ImageFile3 == null
                        ? Image.asset(AppAssets.logo)
                        : Image.file(ImageFile3!),
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
                  _checkedInforLoaiPhong(TenLoaiPhongController.value.text,
                      PricesControler.value.text,SoLuongGiuong,
                      soLuongPhongController.value.text,isMayLanh);

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
