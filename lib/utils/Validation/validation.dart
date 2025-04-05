class Validation {
  static String? nameValidator({required String name}) {
    if (name.isEmpty) {
      return "Please enter your name";
    }
    if (name.length < 3) {
      return "Name must be at least 3 characters long";
    }
    return null;
  }

  static String? emailValidator({required String email}) {
    if (email.isEmpty) {
      return "Please enter an email";
    }
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwordValidator({required String password}) {
    if (password.isEmpty) {
      return "Please enter a password";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  static String? mobileNoValidator({required String mobileNo}) {
    if (mobileNo.isEmpty) {
      return "Please enter your mobile number";
    }
    String mobilePattern = r'^\d{10}$'; // Allows exactly 10 digits
    RegExp regExp = RegExp(mobilePattern);
    if (!regExp.hasMatch(mobileNo)) {
      return "Please enter a valid 10-digit mobile number";
    }
    return null;
  }

  static String? addressValidator({required String address}) {
    if (address.isEmpty) {
      return "Please enter your address";
    }
    if (address.length < 5) {
      return "Address must be at least 5 characters long";
    }
    return null;
  }
}
