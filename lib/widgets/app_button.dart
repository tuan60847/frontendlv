import 'package:flutter/material.dart';


import '../values/app_color.dart';
import '../values/app_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const AppButton({Key? key, required this.label,required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Colors.black38,
              offset: Offset(3,6),
              blurRadius: 6,
            ),

          ],
        ),
        child: Text(label,
          style: AppStyles.h5.copyWith(color: AppColor.textColor),
        ),
      ),
    );
  }
}
