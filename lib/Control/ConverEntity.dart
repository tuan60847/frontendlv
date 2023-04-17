import 'package:intl/intl.dart';

class CovertEntity{
  String CovertDateToString(DateTime a){
    if(a.month<10) {
      if(a.day>10) {
        return "${a.year}-0${a.month}-${a.day}";
      }
      else{
        return "${a.year}-0${a.month}-0${a.day}";
      }

    } else
    if(a.day>10) {
      return "${a.year}-${a.month}-${a.day}";
    }
    else{
      return "${a.year}-${a.month}-0${a.day}";
    }
  }
  DateTime CovertStringtoDate(String){
    return DateFormat("YYYY-mm-dd").parse(String);
  }

  String CovertDateDonDatPhongToString(DateTime a){
    if(a.month<10) {
      if(a.day>10) {
        return "${a.year}0${a.month}${a.day}";
      }
      else{
        return "${a.year}0${a.month}0${a.day}";
      }

    } else
    if(a.day>10) {
      return "${a.year}${a.month}${a.day}";
    }
    else{
      return "${a.year}${a.month}0${a.day}";
    }
  }

}
