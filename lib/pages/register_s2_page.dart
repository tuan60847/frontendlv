


import 'package:flutter/material.dart';
import 'package:frontendlv/Control/ConverEntity.dart';
import 'package:frontendlv/Control/Validate.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/pages/home_page.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart';
import '../models/SharePreferenceKH.dart';
import '../values/app_assets.dart';
import '../values/app_color.dart';
import '../values/app_styles.dart';




class Register_s2_page extends StatefulWidget {
  const Register_s2_page({Key? key, required this.Email, required this.Password}) : super(key: key);
  final String Email;
  final String Password;

  @override
  State<Register_s2_page> createState() => _Register_s2_pageState();
}

class _Register_s2_pageState extends State<Register_s2_page> {
  TextEditingController hotenController = new TextEditingController();
  TextEditingController cmndController = new TextEditingController();
  TextEditingController ngaySinhController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  late String Email;
  late String Password;
  String errorHoTen = "";
  String errorCmnd = "";
  String errorNgaySinh = "";
  String errorPhone= "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Email = widget.Email;
    Password= widget.Password;
  }

  void _DatePicker(){
    showDatePicker(
            context: context,
            initialDate: DateTime(DateTime.now().year-19),
            firstDate: DateTime(1959),
            lastDate: DateTime(DateTime.now().year-18))
        .then((value) {
      setState(() {
        // print("hello");
        ngaySinhController.text=CovertEntity().CovertDateToString(value??DateTime.now());
      });
    });
  }

  void _checkInformation(String Email,String Password,String Hoten,String cmnd , String phonenumber, String ngaysinh) async{
    if(Hoten.isEmpty||cmnd.isEmpty||phonenumber.isEmpty){
     setState(() {
       if(Hoten.isEmpty){
         errorHoTen="full name is not empty";

       }
       if(cmnd.isEmpty){
         errorCmnd="cmnd is not empty";
       }
       if(phonenumber.isEmpty){
         errorPhone="Phone is not empty";
       }
     });
    } else{
      if(cmnd.length>10&&Validate().isValidPhoneNumber(phonenumber)){
        KhachHang khachHang = new KhachHang(email: Email, password: Password, HoTen: Hoten, cmnd: cmnd, SDT: phonenumber, ChuoiNgaySinh: ngaysinh);
        try{
          // print(khachHang);
          bool a= await  insertKhachHang(khachHang);
          if(a==true){
            final tam = await SharedPreferencesService.saveKhachHang(khachHang);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(khachHang: khachHang),), (route) => false);
          }
          // print(a?"Thành Công":"Thất Bại");
        }catch(e){
          print(e);
        }
      }else{
        if(cmnd.length>10)
        errorCmnd = "CMND is lenght less 10 ";
        if(Validate().isValidPhoneNumber(phonenumber)){
          errorPhone = "NumberPhone is not able";
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height/4,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage(AppAssets.topBackground2,),
                  fit:  BoxFit.fill,
                ),

              ),
              child: Row(
                children: [
                  SizedBox(
                    width: size.height/8,
                    child: Container(

                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius:  BorderRadius.all(Radius.circular(180)),
                        child: Container(

                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          },
                            icon: Icon(Icons.arrow_back,size: 35,color: AppColor.primaryColor,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(AppAssets.logo,
                      fit: BoxFit.fill,
                      width: size.width*(1/2),
                      height: size.width*(1/2),
                    ),
                  ),
                  SizedBox(
                    width: size.height/8,
                  ),
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.blue,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.topLeft,
            child: Text("Welcome",
              textAlign: TextAlign.start,
              style: AppStyles.h2.copyWith(color: AppColor.buttonColorPrimary, fontWeight: FontWeight.bold),
            ),
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
                controller: hotenController,
                decoration:  InputDecoration(
                    errorText: errorHoTen==""?null:errorHoTen,
                    fillColor: Colors.blue ,
                    border: InputBorder.none,
                    labelText: 'Enter your full name',
                    // icon: Icon(Icons.mail_outline,),
                    prefixIcon: Icon(Icons.account_box),
                    contentPadding: EdgeInsets.all(5)
                ),

              ),
            ),
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
                  SizedBox(
                    width: size.width*(3/4),
                    child: TextField(

                      controller: cmndController,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                      decoration:  InputDecoration(
                          errorText: errorCmnd==""?null:errorCmnd,
                          fillColor: Colors.blue ,
                          border: InputBorder.none,
                          labelText: 'Enter your CMND',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.accessibility),
                          contentPadding: EdgeInsets.all(5)
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {

                    });

                  },
                      color: Colors.blue,
                      icon: Icon(Icons.qr_code))
                ],
              ),
            ),
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
                controller: phoneController,
                maxLength: 11,
                keyboardType: TextInputType.number,
                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                decoration:   InputDecoration(
                    errorText: errorPhone==""?null:errorPhone,
                    counter: null,
                    fillColor: Colors.blue ,
                    border: InputBorder.none,
                    labelText: 'Enter your phone number',
                    // icon: Icon(Icons.mail_outline,),
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.all(5)
                ),

              ),
            ),
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
                  SizedBox(
                    width: size.width*(3/4),
                    child: TextField(
                      controller: ngaySinhController,
                      enabled: false,

                      decoration: const  InputDecoration(

                          fillColor: Colors.blue ,
                          border: InputBorder.none,
                          labelText: 'Enter your Date Born',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.date_range_sharp),
                          contentPadding: EdgeInsets.all(5)
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    _DatePicker();


                  },
                      color: Colors.blue,
                      icon: Icon(Icons.date_range_outlined))
                ],
              ),
            ),
          ),
          Expanded(
              child: RawMaterialButton(
                onPressed: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                  _checkInformation(Email,Password,hotenController.value.text,cmndController.value.text,phoneController.value.text,ngaySinhController.value.text);
                },
                fillColor: AppColor.buttonColorSecond,
                shape: CircleBorder(),
                child: Image.asset(AppAssets.rightArrow,color: AppColor.secondPrimary),
              )
          ),

        ],

      ),

    );
  }
}
