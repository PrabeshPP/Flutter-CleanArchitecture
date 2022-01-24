class InputConverter {
  final String? strNum;

  InputConverter({this.strNum});

  int? coverToInt() {
    int number = int.parse(strNum!);
    return number;
  }
}
