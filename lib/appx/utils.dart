extension TimeExtension on DateTime{
  Duration operator-(DateTime other){
    return Duration(microseconds: microsecondsSinceEpoch - other.microsecondsSinceEpoch);
  }

  String _timeToString(DateTime time){
    var current = DateTime.now();
    if(current.millisecondsSinceEpoch < time.millisecondsSinceEpoch){
      return "Error";
    }
    if(current.difference(time).inDays > 360){
      return "@year years ago";
    }else if(current.difference(time).inDays > 30){
      return "@month mouths ago";
    }else if(current.difference(time).inHours > 24){
      return "@day days ago";
    }else if(current.difference(time).inMinutes > 60){
      return "@hour hours ago";
    }else if(current.difference(time).inSeconds > 60){
      return "@minute minutes ago";
    }else{
      return "Just now";
    }
  }

  String get toCompareString => _timeToString(this);
}

extension StringExtension on String{
  ///Remove all value that would display blank on the screen.
  String get removeAllBlank => replaceAll("\n", "").replaceAll(" ", "").replaceAll("\t", "");

  bool get isNum => double.tryParse(this) != null;

  String _nums(){
    String res = "";
    for(int i=0; i<length; i++){
      res += this[i].isNum?this[i]:"";
    }
    return res;
  }

  /// get all numbers in this string.
  String get nums => _nums();

  bool _isURL(){
    final regex = RegExp(
        r'^((http|https|ftp)://)?[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-|]*[\w@?^=%&/~+#-])?$',
        caseSensitive: false);
    return regex.hasMatch(this);
  }

  /// check if this string is a valid url.
  bool get isURL => _isURL();

  /// set the value at [index] to [value].
  String setValueAt(String value, int index){
    return replaceRange(index, index+1, value);
  }

  /// get the substring from [start] to [end]. if invalid param, return null.
  String? subStringOrNull(int start, [int? end]){
    if(start < 0 || (end != null && end > length)){
      return null;
    }
    return substring(start, end);
  }

  /// replace the last [from] with [to].
  String replaceLast(String from, String to) {
    if (isEmpty || from.isEmpty) {
      return this;
    }

    final lastIndex = lastIndexOf(from);
    if (lastIndex == -1) {
      return this;
    }

    final before = substring(0, lastIndex);
    final after = substring(lastIndex + from.length);
    return '$before$to$after';
  }
}

extension ListExtension<T> on List<T>{
  /// Remove all blank value and return new list.
  List<T> getNoBlankList(){
    List<T> newList = [];
    for(var value in this){
      if(value.toString() != ""){
        newList.add(value);
      }
    }
    return newList;
  }

  /// find the first element that match the test, if not found, return null.
  T? firstWhereOrNull(bool Function(T element) test){
    for(var element in this){
      if(test(element)){
        return element;
      }
    }
    return null;
  }

  /// add value to this list if value is not null.
  void addIfNotNull(T? value){
    if(value != null){
      add(value);
    }
  }
}