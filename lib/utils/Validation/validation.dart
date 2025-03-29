class Validation {
  static nameValidator({required String nameFieldValue}) {
    if (nameFieldValue.isEmpty) {
      return "Please fill the name field";
    }
    return null;
  }
}
