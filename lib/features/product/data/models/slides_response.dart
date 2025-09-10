import 'slide_model.dart';

class SlidesResponse {
  final String message;
  final List<SlideModel> slides;
  final bool status;

  const SlidesResponse({
    required this.message,
    required this.slides,
    required this.status,
  });

  factory SlidesResponse.fromJson(Map<String, dynamic> json) {
    return SlidesResponse(
      message: json['message'] ?? '',
      slides:
          (json['slides'] as List<dynamic>?)
              ?.map((slide) => SlideModel.fromJson(slide))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}
