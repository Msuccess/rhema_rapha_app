class Result<T> {
  bool isSuccessful;
  T data;
  String message;

  Result({this.isSuccessful = false, this.message = '', this.data});
}