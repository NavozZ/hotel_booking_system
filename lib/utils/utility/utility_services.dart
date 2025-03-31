class UtilityService {
  static bool isInTheList(
      {required List<dynamic> list, required String value}) {
    bool isMatch = false;
    for (var item in list) {
      if (item == value) {
        isMatch = true;
        break;
      }
    }
    return isMatch;
  }
}
