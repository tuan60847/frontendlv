import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/pages/home_page.dart';
import 'package:frontendlv/pages/AdminKH_Page.dart';

import '../models/ChuKhachSan.dart';
import '../models/SharePreferenceKH.dart';
import '../models/SharePreferenceCKS.dart';
import '../values/app_assets.dart';
import '../values/app_color.dart';
import '../values/app_styles.dart';
import 'register_page.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart' as KH;
import 'package:frontendlv/responsity/ChuKhachSanResponsity.dart' as CKS;

// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LadingPage(),
//     );
//   }
// }
class LadingPage extends StatefulWidget {
  const LadingPage({Key? key}) : super(key: key);

  @override
  State<LadingPage> createState() => _LadingPageState();
}

class _LadingPageState extends State<LadingPage> {
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passwordControler = new TextEditingController();
  bool _showPasword = true;
  String LoiTaiKhoang = "";
  String LoiMatKhau = "";

  bool AdminKS = false;

  void checkLogin(String Email, String Password,bool AdminKS) async {
    if (Email.isEmpty) {
      setState(() {
        LoiTaiKhoang = "Email none Value!!";
      });
    }
    else {
      try {
        if(!AdminKS) {
          KhachHang khachHang = await KH.getKhachHang(Email);
          if (khachHang.password.toString().compareTo(Password) != 0) {
            print("object");
            setState(() {
              LoiMatKhau = "Password is Fails";
              passwordControler.text = "";
            });
          } else {
            final tam = await SharedPreferencesService.saveKhachHang(khachHang);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(khachHang: khachHang),
                ),
                (route) => false);
          }
        }else{
          ChuKhachSan chuKhachSan = await CKS.getChuKhachSan(Email);
          if (chuKhachSan.password.toString().compareTo(Password) != 0) {
            print("object");
            setState(() {
              LoiMatKhau = "Password is Fails";
              passwordControler.text = "";
            });
          } else {
            final tam = await SharedPreferencesServiceChuKhachSan.saveChuKhachHang(chuKhachSan);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => adminKH_Page(UIDKS: chuKhachSan.AdminKS)
                ),
                    (route) => false);
          }
        }
      } catch (e) {
        setState(() {
          LoiTaiKhoang = "Email was not exist!!";
          emailControler.text = "";
          passwordControler.text = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height / 2,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.topBackground1),
                  fit: BoxFit.cover,
                ),

              ),
              child: Center(
                child: Image.asset(AppAssets.logo,
                  fit: BoxFit.fill,
                  width: size.width * (3 / 4),
                  height: size.width * (3 / 4),
                ),
              ),
            ),
          ),
          Container(
            // color: Colors.blue,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.topLeft,
            child: Text("Welcome Back",
              textAlign: TextAlign.start,
              style: AppStyles.h3.copyWith(color: AppColor.buttonColorPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(

              decoration: const BoxDecoration(
                color: AppColor.secondPrimary,
                // border: Border.fromBorderSide(BorderSide),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: TextField(
                controller: emailControler,

                decoration: InputDecoration(
                    errorText: LoiTaiKhoang == "" ? null : LoiTaiKhoang,
                    fillColor: Colors.blue,
                    border: InputBorder.none,
                    labelText: 'Enter your Emails',
                    // icon: Icon(Icons.mail_outline,),
                    prefixIcon: Icon(Icons.mail_outline),
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
                    width: size.width * (3 / 4),
                    child: TextField(
                      obscureText: _showPasword,
                      controller: passwordControler,
                      decoration: InputDecoration(
                          errorText: LoiMatKhau == "" ? null : LoiMatKhau,
                          fillColor: Colors.blue,
                          border: InputBorder.none,
                          labelText: 'Enter your  Password',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.password),
                          contentPadding: EdgeInsets.all(5)
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {
                    setState(() {
                      _showPasword = !_showPasword;
                    });
                  },
                      color: Colors.blue,
                      icon: Icon(
                          _showPasword ? Icons.visibility_off_outlined : Icons
                              .visibility))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 16),
            child: Row(
              children: [
                Checkbox(
                  value: AdminKS,
                    onChanged: (bool? value ){
                     setState(() {
                       AdminKS = value!;
                     });
                    },
                ),
                Text("Check If You Innkeeper " ,style: AppStyles.h5.copyWith(color: AppColor.textColor),),
              ],
            ),
          ),
          Expanded(
              child: RawMaterialButton(
                onPressed: () {
                  checkLogin(
                      emailControler.value.text, passwordControler.value.text,AdminKS);
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                },
                fillColor: AppColor.buttonColorPrimary,
                shape: CircleBorder(),
                //assets/images/3x/icons8-next-page.png
                //assets/images/3x/icons8-next-page.png
                child: Image.asset(
                    AppAssets.rightArrow, color: AppColor.secondPrimary),
              )
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(text: "Do you have an Account? ",
                      style: TextStyle(color: AppColor.textColor)
                  ),
                  TextSpan(text: "Sign Up Here",
                      style: TextStyle(color: AppColor.buttonColorPrimary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Register_page()));
                        }
                  ),


                ]),
              ),
            ),
          ),
        ],

      ),
      // body: Container(
      //   padding:  EdgeInsets.symmetric(horizontal: 16),
      //   child: Column(
      //
      //     children: [
      //       Expanded(
      //         child: Container(
      //           alignment: Alignment.centerLeft,
      //
      //           child: Text('Wecome To the App',
      //             style: AppStyles.h3
      //           ),
      //         ),
      //       ),
      //        Expanded(
      //         child: Container(
      //
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: [
      //               Text(
      //                 'English',
      //                 style: AppStyles.h2.copyWith(color: AppColor.backGray
      //                 ,fontWeight: FontWeight.bold),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 40),
      //                 child: Text(
      //                   'Quests',
      //                   style: AppStyles.h4.copyWith(height: 0.5),
      //                   textAlign: TextAlign.right,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //        Expanded(
      //         child: Padding(
      //           padding: const EdgeInsets.only(bottom:64 ),
      //           child: RawMaterialButton(
      //             onPressed: (){
      //               //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
      //               // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      //             },
      //             fillColor: AppColor.lightBlue,
      //             shape: CircleBorder(),
      //             //assets/images/3x/icons8-next-page.png
      //             //assets/images/3x/icons8-next-page.png
      //             child: Image.asset(AppAssets.rightArrow),
      //
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
}

