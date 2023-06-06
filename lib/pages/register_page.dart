
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontendlv/models/ChuKhachSan.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/pages/register_s2_page.dart';
import 'package:frontendlv/responsity/ChuKhachSanResponsity.dart';
import 'package:frontendlv/responsity/KhachHangResponsity.dart';




import '../values/app_assets.dart';
import '../values/app_color.dart';
import '../values/app_styles.dart';
import '../Control/Validate.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';



class Register_page extends StatefulWidget {
  const Register_page({Key? key}) : super(key: key);

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  TextEditingController emailControler = new  TextEditingController();
  TextEditingController passwordControler = new  TextEditingController();
  TextEditingController repasswordControler = new  TextEditingController();
  String ErorEmail="";
  String ErorPassword="";
  String ReErorPassword="";
  bool isvisiblepasword = true ;
  bool isvisiblerepasword = true;

  bool AdminKS = false;

  dynamic sendEmail(String email) async {
    final smtpServer = gmail('tuan60847@gmail.com', 'vipkute517');

    // Tạo mã xác nhận ngẫu nhiên
    final random = Random();
    final code = random.nextInt(900000) + 100000;

    // Tạo nội dung email
    final message = Message()
      ..from = Address('tuan60847@gmail.com', 'Tuan')
      ..recipients.add('$email')
      ..subject = 'Verification Code'
      ..text = 'Your verification code is: $code';

    // Gửi email
    final sendResponse = await send(message, smtpServer);
    print('Code sent to ${message.recipients} with response: ${sendResponse.toString()}');
    return code;
  }
  //Trong đó, bạn cần thay đổi các thông tin như địa chỉ email của bạn (your.email@gmail.com), mật khẩu email của bạn (your.password), địa chỉ email người nhận (recipient.email@example.com) và tên người gửi (Your Name) theo đúng thông tin của bạn. Mã xác nhận được tạo ngẫu nhiên bằng hàm Random(), và được đưa vào nội dung email bằng cách sử dụng chuỗi ký tự '$code'. Sau khi gửi email thành công, bạn sẽ nhận được một thông báo trên console.
void checkRegisterLogin(String Email,String password,String repassword, bool AdminKS) async{
    if(Email.isEmpty||password.isEmpty||repassword.isEmpty){
      setState(() {
        if(Email.isEmpty){
          ErorEmail = "Email is Empty";
        }
        if(password.isEmpty){
          ErorPassword = "Password is Empty";
        }
        if(repassword.isEmpty){
          ReErorPassword = "Repassword is reEmpty";
        }
      });
    }
    else{
      if(password.compareTo(repassword)!=0){
        setState(() {
          ErorPassword = "Password and RePassword  are  different";
          ReErorPassword = "Password and RePassword  are  different";
          passwordControler.text="";
          repasswordControler.text="";
        });

      }
      else {
        if(Validate().isEmail(Email)&&Validate().lenRequire(Email)){

            try {
              if(AdminKS==false) {
              KhachHang khachHang = await getKhachHang(Email);
              print(khachHang);
            }
              else{
                ChuKhachSan chuKhachSan = await getChuKhachSan(Email);
                print(chuKhachSan);
              }
            setState(() {
                ErorEmail = "Email was exist";
                ErorPassword = "";
                ReErorPassword = "";
              });
            } catch (e) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register_s2_page(
                      Email: Email,
                      Password: password,
                      AdminKS: AdminKS,
                    ),
                  ));
            }
          }
        else {
          if(Validate().lenRequire(Email)==false){
            ErorEmail= "Email is require length 10 character";
          }else {
            if(Validate().isEmail(Email)==false){
              ErorEmail="Email was not expected";
            }
          }
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical:16),
            child: Container(

              decoration: const BoxDecoration(
                color: AppColor.secondPrimary,
                // border: Border.fromBorderSide(BorderSide),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: TextField(
                controller: emailControler,
                decoration:  InputDecoration(
                    errorText: ErorEmail==""?null:ErorEmail,
                    fillColor: Colors.blue ,
                    border: InputBorder.none,
                    labelText: 'Enter your emails',
                    // icon: Icon(Icons.mail_outline,),
                    prefixIcon: Icon(Icons.mail_outline),
                    contentPadding: EdgeInsets.all(5)
                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      obscureText: isvisiblepasword,
                      controller: passwordControler,
                      decoration:  InputDecoration(
                          errorText: ErorPassword==""?null:ErorPassword,

                          fillColor: Colors.blue ,
                          border: InputBorder.none,
                          labelText: 'Enter your Password',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.password),
                          contentPadding: EdgeInsets.all(5)
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      isvisiblepasword = !isvisiblepasword;
                    });

                  },
                      color: Colors.blue,
                      icon: Icon(isvisiblepasword?Icons.visibility_off_outlined:Icons.visibility))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      obscureText: isvisiblerepasword,
                      controller: repasswordControler,
                      decoration:  InputDecoration(
                          errorText: ReErorPassword==""?null:ReErorPassword,
                          fillColor: Colors.blue ,
                          border: InputBorder.none,
                          labelText: 'Enter your Confirm Password',
                          // icon: Icon(Icons.mail_outline,),
                          prefixIcon: Icon(Icons.password),
                          contentPadding: EdgeInsets.all(5)
                      ),
                    ),
                  ),
              IconButton(onPressed: (){
                setState(() {
                  isvisiblerepasword = !isvisiblerepasword;
                });

              },
                  color: Colors.blue,
                  icon: Icon(isvisiblerepasword?Icons.visibility_off_outlined:Icons.visibility))
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
                onPressed: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                    checkRegisterLogin(emailControler.value.text,passwordControler.value.text,repasswordControler.value.text,AdminKS);
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
