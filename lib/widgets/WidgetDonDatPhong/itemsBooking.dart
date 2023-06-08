import 'package:flutter/material.dart';
import 'package:frontendlv/Control/Validate.dart';
import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/responsity/DonDatPhongResponsity.dart';
import 'package:frontendlv/responsity/KhachSanResponsity.dart';
import 'package:frontendlv/widgets/WidgetCTDDP/ItemsCTDDPUSSER.dart';
import 'package:intl/intl.dart';

import '../../Control/ConverEntity.dart';
import '../../models/CTDDP.dart';
import '../../responsity/CTDDPResponsity.dart';
import '../../values/app_color.dart';
import '../../values/app_styles.dart';

class itemBookingManager extends StatefulWidget {
  const itemBookingManager(
      {Key? key, required this.khachHang, required this.donDatPhong})
      : super(key: key);
  final KhachHang khachHang;
  final DonDatPhong donDatPhong;

  @override
  State<itemBookingManager> createState() => _itemBookingManagerState();
}

class _itemBookingManagerState extends State<itemBookingManager> {
  late KhachHang khachHang;
  late DonDatPhong donDatPhong;
  late KhachSan _khachSan;
  bool chuaxacnhan = false;
  TextEditingController ngaydatPhongControler = new TextEditingController();
  bool visbleKS = false;
  List<String> diachi = [];
  List<CTDDP> _dsCTDDP =<CTDDP>[]  ;
  String GiaTien ="";
  String ErrorNgayDatPhong="";


  void _DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime.now().add(Duration(days: 1)),
            lastDate: DateTime.now().add(Duration(days: 14)))
        .then((value) {
      setState(() {
        // print("hello");
        if(donDatPhong.isChecked==0) {
          ngaydatPhongControler.text =
              CovertEntity().CovertDateToString(value ?? DateTime.now());
        }
      });
    });
  }

  void _DatPhong(String NgayDatPhong) async{
    if(NgayDatPhong==""){
      ErrorNgayDatPhong="Please Set Day Check In";
    }else{
      _dsCTDDP.forEach((element) async {
        final boolupdateCTDDP= await updateCTDDP(element);
        print(boolupdateCTDDP);
      });
      donDatPhong.isChecked=1;
      donDatPhong.NgayDatPhong=NgayDatPhong;
      try {
        final boolupdateDDP = await updateDonDatPhong(donDatPhong);
        print("$boolupdateDDP");
        setState(() {
          donDatPhong.isChecked = 1;
          donDatPhong.NgayDatPhong = NgayDatPhong;
        });
      }catch(e){
        print(e);
      }


    }
  }



  void _HuyDonDatPhong()async{
    donDatPhong.isChecked=5;
    final boolupdateDDP = await updateDonDatPhong(donDatPhong);
  }









  _getData() async {
    List<String> tam = donDatPhong.UIDDatPhong.split("-");
    final a = await getKhachSan(tam[1]);
    final b = await getCTDDPByMaDP(donDatPhong.UIDDatPhong);
    setState(() {
      _khachSan = a;
      _dsCTDDP = b;
      b.forEach((element) {
        donDatPhong.tongtien+=element.Tien;
      });
      GiaTien =  NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(donDatPhong.tongtien);
      diachi = a.DiaChi.split(",");
      if (donDatPhong.isChecked != 0) {
        ngaydatPhongControler.text = donDatPhong.NgayDatPhong;
      }
      visbleKS = true;
    });
  }
  void  totalprices(int a){
    setState(() {


    });
  }

  void updatectddp(CTDDP ctddp){
    donDatPhong.tongtien=0;
    setState(() {
      _dsCTDDP.forEach((element) {
        if(element.UIDCTDDP==ctddp.UIDCTDDP){
          element=ctddp;
        }
        donDatPhong.tongtien+=element.Tien;
        GiaTien =  NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(donDatPhong.tongtien);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khachHang = widget.khachHang;
    donDatPhong = widget.donDatPhong;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: size.width / 4,
                    child: Text(
                      "ID BOOKING ",
                      style: AppStyles.h5.copyWith(color: AppColor.textColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: size.width * 5 / 8,
                    child: Text(
                      "${donDatPhong.UIDDatPhong}",
                      style: AppStyles.h5.copyWith(color: AppColor.textColor),
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: size.width / 4,
                    child: Text(
                      "Email",
                      style: AppStyles.h5.copyWith(color: AppColor.textColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: size.width * 5 / 8,
                    child: Text(
                      "${donDatPhong.EmailKH}",
                      style: AppStyles.h5.copyWith(color: AppColor.textColor),
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: visbleKS,
            child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 4,
                      child: Text(
                        "Name Hotel",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: size.width * 5 / 8,
                      child: Text(
                        "${_khachSan.TenKS} ",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: visbleKS,
            child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 4,
                      child: Text(
                        "Andress Hotel",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: size.width * 5 / 8,
                      child: Text(
                        "${diachi[0]},ward :${diachi[1]},District :${diachi[2]},${diachi[3]} city",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: visbleKS,
            child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 4,
                      child: Text(
                        "Number Phone Hotel",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: size.width * 5 / 8,
                      child: Text(
                        "${_khachSan.SDT} ",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: visbleKS,
            child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 4,
                      child: Text(
                        "Total",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: size.width * 5 / 8,
                      child: Text(
                        "${GiaTien} ",
                        style: AppStyles.h5.copyWith(color: AppColor.textColor),
                      ),
                    ),
                  ],
                )),
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
                    controller: ngaydatPhongControler,

                    enabled: false,
                    decoration:  InputDecoration(
                        fillColor: Colors.blue,
                        errorText: ErrorNgayDatPhong==""?null:ErrorNgayDatPhong,
                        border: InputBorder.none,
                        labelText: 'Enter your Date Check IN',
                        // icon: Icon(Icons.mail_outline,),
                        prefixIcon: Icon(Icons.date_range_sharp),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (donDatPhong.isChecked == 0) {
                        _DatePicker();
                      }
                    },
                    color: Colors.blue,
                    icon: Icon(Icons.date_range_outlined)),
              ],
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(itemCount: _dsCTDDP.length,itemBuilder: (context, index) {
            if(_dsCTDDP.length<0){
            return Text("No Data");
            }
            else {
                  return itemsCTDDPUser(
                      ctddp: _dsCTDDP[index],
                      isChecked: donDatPhong.isChecked,
                      updatectddp: updatectddp);
                }

              }),
        ),
        Visibility(
          visible: donDatPhong.isChecked!=5?true:false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
            child: MaterialButton(onPressed: (){
              if(donDatPhong.isChecked==0)
              _DatPhong(ngaydatPhongControler.value.text);
            },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                    color: donDatPhong.isChecked==0?AppColor.buttonColorPrimary:donDatPhong.isChecked==1?AppColor.greenCheckingButtonColor:AppColor.greenAcpectedButtonColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        16))),

                alignment: Alignment.center,
                child: donDatPhong.isChecked==0?Text("Booking Room" ,style: AppStyles.h4.copyWith(color: AppColor.primaryColor),):donDatPhong.isChecked==1?Text("Processing" ,style: AppStyles.h4.copyWith(color: AppColor.primaryColor),):Text("Accept" ,style: AppStyles.h4.copyWith(color: AppColor.primaryColor),),
              ),
            ),
          ),
        ),

        Visibility(
          visible: donDatPhong.isChecked!=3||donDatPhong.isChecked!=5?true:false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 16),
            child: MaterialButton(onPressed: (){
              print("Hủy");
            },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                    color: AppColor.appbarColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        16))),

                alignment: Alignment.center,
                child: Text("Delete Booking Room",style: AppStyles.h4.copyWith(color: AppColor.primaryColor),),
              ),
            ),
          ),
        )
      ],
    );
  }
}
