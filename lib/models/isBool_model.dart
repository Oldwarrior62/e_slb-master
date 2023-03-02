class IsBool {
  bool? isDyslexic;
  bool? isTwentyFour;
  bool? isDarkMode;
  bool? isLoggedIn;

  IsBool({
    this.isDarkMode,
    this.isDyslexic,
    this.isTwentyFour,
    this.isLoggedIn,
  });

  IsBool.fromMap(dynamic, obj) {
    this.isDyslexic = obj['isDyslexic'] == 1;
    this.isTwentyFour = obj['isTwentyFour'] == 1;
    this.isDarkMode = obj['isDarkMode'] == 1;
    this.isLoggedIn = obj['isLoggedIn'] == 1;
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'isDyslexic': isDyslexic! ? 1 : 0,
      'isTwentyFour': isTwentyFour! ? 1 : 0,
      'isDarkMode': isDarkMode! ? 1 : 0,
      'isLoggedIn': isLoggedIn! ? 1 : 0,
    };
    return map;
  }
}
