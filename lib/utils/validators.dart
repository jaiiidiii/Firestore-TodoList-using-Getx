class Validators {
  static final _instance = Validators._internal();
  factory Validators() => _instance;
  Validators._internal();

  String validateEmail(String value, {bool optional = false}) {
    var message = "Email is required";
    if (value.isEmpty) {
      if (optional) {
        return null;
      }
      message = message;
    } else {
      // Regex condition and messages
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!emailValid) {
        message = "Valid email is required";
      } else {
        return null;
      }
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);
    return message;
  }

  String required(String value) {
    var message = "Required";
    if (value.isEmpty || value == null) {
      message = message;
    } else {
      return null;
    }
    // showSnackbar(cache.scaffoldState, cache.appContext, message);
    return message;
  }

  String validateExistingPassword(String value) {
    var message = "Password is required";
    if (value.isEmpty || value == null) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateNewPassword(String value, String oldPass) {
    var message = "New Password is required.";
    if (value.isEmpty || value == null) {
      message = message;
    } else if (oldPass != null && value == oldPass) {
      message = "Old & New Password cannot be same.";
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateConfirmPassword(String value, String newPass) {
    var message = "Confirm Password is required";
    if (value.isEmpty || value == null) {
      message = message;
    } else if (newPass != null && value != newPass) {
      message = "New Password & Confirm Password should be same.";
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  lengthValidator(String value, List<int> length) {
    bool result = false;
    for (int i = 0; i < length.length; i++) {
      if (value.length == length[i]) {
        result = true;
      }
    }
    return result;
  }

  String validateCnicSnackBar(String value) {
    var message = "CNIC is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains('.') ||
        value.contains(',') ||
        value.contains('-') ||
        !lengthValidator(value, [11, 13])) {
      message = "Valid CNIC is required";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateLoginIDSnackBar(String value) {
    var message = "Login ID is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.length < 3 || value.length > 16) {
      message = "Please enter valid login id.";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateConsumerNoSnackBar(String value, int noOfDigits) {
    var message = "Consumer Number is required";
    if (value.isEmpty || value == null) {
      message = message;
    } else if (value.contains('.') ||
        value.contains(',') ||
        value.contains('-') ||
        value.length != noOfDigits) {
      message = "Valid Consumer Number is required";
    } else {
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateAccountNumberSnackBar(String value) {
    var message = "Account number is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains(r'[.-]') || value.length < 14) {
      message = "Valid account number is required";
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateLoginIdSnackBar(String value) {
    var message = "Login id is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateMobileNumberSnackBar(String value) {
    var message = "Mobile number is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains(r'[.-]') || value.length < 11) {
      message = "Valid mobile number is required";
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateAccountOrIBAN(String value, bool isIban, int minLength) {
    String type = isIban ? "IBAN" : "Account";
    var message = "$type is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.length < minLength) {
      // Regex condition and messages
      message = " $type length cannot be less than $minLength";
    } else {
      // Regex condition and messages
      return null;
    }

    return message;
  }

  String validateAmount(String value, {double min, double max}) {
    var message = "Amount is required";
    if (value.isEmpty) {
      message = message;
    } else if (min != null && double.parse(value) < min) {
      // Regex condition and messages
      message = "Amount cannot be less than $min";
    } else if (max != null && double.parse(value) > max) {
      // Regex condition and messages
      message = "Amount cannot be greater than $max";
    } else {
      // Regex condition and messages
      return null;
    }
    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateDobSnackBar(String value) {
    var message = "Date of birth is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }

  String validateCommentsSnackBar(String value) {
    var message = "Comment is required";
    if (value.isEmpty) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }

    // showSnackbar(cache.scaffoldState, cache.appContext, message);

    return message;
  }
}
