import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendlv/Control/Validate.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/responsity/KhachSanResponsity.dart';
import 'package:frontendlv/values/app_http.dart';

import 'package:frontendlv/values/app_styles.dart';
import 'package:image_picker/image_picker.dart';

import '../../responsity/ImageKSReponsity.dart';
import '../../values/app_assets.dart';
import '../../values/app_color.dart';

class RepairKhachSan extends StatefulWidget {
  const RepairKhachSan({Key? key, required this.khachSan, this.UriHinhAnh = ""})
      : super(key: key);
  final KhachSan khachSan;
  final String UriHinhAnh;

  @override
  State<RepairKhachSan> createState() => _RepairKhachSanState();
}

class _RepairKhachSanState extends State<RepairKhachSan> {
  TextEditingController TenKhachSanController = new TextEditingController();
  TextEditingController AndressCityController = new TextEditingController();
  TextEditingController AndressDistrictsController =
      new TextEditingController();
  TextEditingController AndressWardController = new TextEditingController();
  TextEditingController AndressController = new TextEditingController();
  TextEditingController SDTController = new TextEditingController();
  String ErrorTenKS = "";
  String ErrorAndressCity = "";
  String ErrorAndressDistricts = "";
  String ErrorAndressWard = "";
  String ErrorAndress = "";
  String ErrorSDT = "";

  late KhachSan khachSan;
  late String srcHinhAnh;
  File? ImageFile;
  final _ImagePicker = ImagePicker();

  PickImageGallery() async {
    final XFile? image =
        await _ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ImageFile = File(image.path);
      });
    }
  }

  void checkInforKS(String UIDKS, String TenKS, String City, String Distric,
      String ward, String Location, String SDT) async {
    if (TenKS.isEmpty ||
        City.isEmpty ||
        Distric.isEmpty ||
        ward.isEmpty ||
        Location.isEmpty ||
        SDT.isEmpty) {
      setState(() {
        if (TenKS.isEmpty) {
          ErrorTenKS = "Name Hotel is not Empty";
        }
        if (City.isEmpty) {
          ErrorTenKS = "City is not Empty";
        }
        if (Distric.isEmpty) {
          ErrorTenKS = "Distric is not Empty";
        }
        if (ward.isEmpty) {
          ErrorTenKS = "Ward is not Empty";
        }
        if (Location.isEmpty) {
          ErrorTenKS = "Location Hotel is not Empty";
        }
        if (SDT.isEmpty) {
          ErrorTenKS = "Phone Number is not Empty";
        }
      });
    } else {
      if (!Validate().lenRequire(TenKS) ||
          !Validate().isValidPhoneNumber(SDT)) {
        if (Validate().lenRequire(TenKS) == false) {
          ErrorTenKS = "The hotel name must be at least 10";
        }
        if (Validate().isValidPhoneNumber(SDT) == false) {
          ErrorTenKS = "The Phone hotel not corrects";
        }
      } else {
        String DiaChi = "$Location,$ward,$Distric,$City";
        KhachSan khachSan =
            new KhachSan(UIDKS: UIDKS, TenKS: TenKS, DiaChi: DiaChi, SDT: SDT);
        print(khachSan.DiaChi);
        bool a = await updateKhachsan(khachSan);

        if (ImageFile != null) {
          if(srcHinhAnh!="") {
            bool xoa = await deleteimageKS(srcHinhAnh.toString());
            print(xoa.toString());
          }
          bool xacNhan = await uploadImageKS(UIDKS, ImageFile!);

          print(xacNhan.toString());
        }
        Navigator.pop(context);
      }
    }
  }

  void _getKhachSan() {
    TenKhachSanController.text = khachSan.TenKS.toString();

    SDTController.text = khachSan.SDT.toString();
    List<String> list = khachSan.DiaChi.split(",");
    AndressCityController.text = list[3].toString();
    AndressDistrictsController.text = list[2].toString();
    AndressWardController.text = list[1].toString();
    AndressController.text = list[0].toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachSan = widget.khachSan;
    srcHinhAnh = widget.UriHinhAnh;
    _getKhachSan();
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
          'REPAIR HOTEL',
          style: AppStyles.h4.copyWith(color: AppColor.primaryColor),
        ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {},
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: Image.asset(AppAssets.logo,height: 12,width: 40,),
          // ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: size.height,
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
                  controller: TenKhachSanController,
                  decoration: InputDecoration(
                      errorText: ErrorTenKS == "" ? null : ErrorTenKS,
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondPrimary,
                      // border: Border.fromBorderSide(BorderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: 220,
                    child: TextField(
                      controller: AndressCityController,
                      decoration: InputDecoration(
                          errorText:
                              ErrorAndressCity == "" ? null : ErrorAndressCity,
                          fillColor: Colors.blue,
                          border: InputBorder.none,
                          labelText: 'Place hotel city',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondPrimary,
                      // border: Border.fromBorderSide(BorderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: size.width * 1 / 3,
                    child: TextField(
                      controller: AndressDistrictsController,
                      decoration: InputDecoration(
                          errorText: ErrorAndressDistricts == ""
                              ? null
                              : ErrorAndressDistricts,
                          fillColor: Colors.blue,
                          border: InputBorder.none,
                          labelText: 'Hotels Districs',
                          // icon: Icon(Icons.mail_outline,),
                          // prefixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondPrimary,
                      // border: Border.fromBorderSide(BorderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: size.width * 2 / 5,
                    child: TextField(
                      controller: AndressWardController,
                      decoration: InputDecoration(
                          errorText:
                              ErrorAndressWard == "" ? null : ErrorAndressWard,
                          fillColor: Colors.blue,
                          border: InputBorder.none,
                          labelText: 'Hotels wards',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.location_on),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondPrimary,
                      // border: Border.fromBorderSide(BorderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: size.width * 2 / 4,
                    child: TextField(
                      controller: AndressController,
                      decoration: InputDecoration(
                          errorText: ErrorAndress == "" ? null : ErrorAndress,
                          fillColor: Colors.blue,
                          border: InputBorder.none,
                          labelText: 'Hotels Location',
                          // icon: Icon(Icons.mail_outline,),
                          // prefixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ],
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
                  controller: SDTController,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                      errorText: ErrorSDT == "" ? null : ErrorSDT,
                      fillColor: Colors.blue,
                      border: InputBorder.none,
                      labelText: 'Enter your Phone Number Hotel',
                      // icon: Icon(Icons.mail_outline,),
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // child: srcHinhAnh!=""?
                    // Image.network("${HTTP.imageSrc}${srcHinhAnh}"):
                    // ImageFile == null
                    //     ? Image.asset(AppAssets.logo, fit: BoxFit.cover)
                    //     : Image.file(File(ImageFile!.path)),
                    child: ImageFile != null
                        ? Image.file(File(ImageFile!.path))
                        : srcHinhAnh != ""
                            ? Image.network("${HTTP.imageSrc}${srcHinhAnh}")
                            : Image.asset(AppAssets.logo, fit: BoxFit.cover),
                    width: 100,
                    height: 100,
                  ),
                  MaterialButton(
                    onPressed: () {
                      PickImageGallery();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColor.buttonColorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Select Images",
                          style: AppStyles.h5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: RawMaterialButton(
              onPressed: () {
                // print(ImageFile!);

                //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                checkInforKS(
                    khachSan.UIDKS,
                    TenKhachSanController.value.text,
                    AndressCityController.value.text,
                    AndressDistrictsController.value.text,
                    AndressWardController.value.text,
                    AndressController.value.text,
                    SDTController.value.text);
              },
              fillColor: AppColor.buttonColorSecond,
              shape: CircleBorder(),
              child: Image.asset(AppAssets.rightArrow,
                  color: AppColor.secondPrimary),
            )),
          ],
        ),
      ),
    );
  }
}
