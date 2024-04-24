class ImageUploadResponse {
  final String status;
  final List<String> data;
  final String message;

  ImageUploadResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
      status: json['status'],
      data: List<String>.from(json['data']),
      message: json['message'],
    );
  }
}
