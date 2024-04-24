class ErrorMessage {
  final String errormessage;
  ErrorMessage({required this.errormessage});
  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(errormessage: json['error_message']);
  }
}
