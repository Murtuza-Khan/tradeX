class ApiResponse {
  bool status;
  String? message;
  dynamic successContents;

  ApiResponse({
    this.status = false,
    this.message,
    this.successContents,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      successContents: json['data'],
    );
  }
}
