
class FieldValidator {
  static String? required(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }

    return null;
  }

}
