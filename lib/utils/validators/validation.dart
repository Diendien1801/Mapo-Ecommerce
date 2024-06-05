class TValidator{
  static String? validateEmptyText(String? field,String? value){
    if(value == null || value.isEmpty){
      return "$field is required";
    }
    return null;
  }
 


  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Email is required";
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
      return "Invalid email address";
    }
    return null;
  }




  static String? validatePassword(String? value)
  {
    if(value == null || value.isEmpty){
      return "Password is required";
    }
    if(value.length < 6){
      return "Password must be at least 6 characters";
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return "Password must contain at least one number";
    }
    if(!value.contains(RegExp(r'[A-Z]'))){
      return "Password must contain at least one uppercase letter";
    }
    return null;
  }


  static String? validatePhone(String? value){
    if(value == null || value.isEmpty){
      return "Phone number is required";
    }
    if(!RegExp(r'^\d{10}$').hasMatch(value)){
      return "Invalid phone number";
    }
    return null;
  }
}