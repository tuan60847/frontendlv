class Validate {
  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
  bool lenRequire(String string){
    return string.length<=10?false:true;
  }
  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(r'^0\d{9,10}$');
    return regex.hasMatch(input);
  }
  bool isValidPrices(String input){
    try{
      double a = double.parse(input);
      if(a<10000){
        return false;

      }else
        return true;
    }catch(e){
      return false;
    }

  }

  bool isValidNumber(String input){
    try{
      double a = double.parse(input);
      if(a<0){
        return false;

      }else
        return true;
    }catch(e){
      return false;
    }

  }

}
