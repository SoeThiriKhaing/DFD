class FavCuisineModel {
  final String foodName;
  final int foodCount;
  final List<ImageData> images;

  FavCuisineModel({
    required this.foodName,
    required this.foodCount,
    required this.images,
  });

  // Factory method to parse JSON into FoodData
  factory FavCuisineModel.fromJson(Map<String, dynamic> json) {
    return FavCuisineModel(
      foodName: json['food-name'] ?? '',
      foodCount: json['food_count'] ?? 0,
      images: (json['images'] as List<dynamic>)
          .map((image) => ImageData.fromJson(image))
          .toList(),
    );
  }

  // Method to convert FoodData to JSON
  Map<String, dynamic> toJson() {
    return {
      'food-name': foodName,
      'food_count': foodCount,
      'images': images.map((image) => image.toJson()).toList(),
    };
  }
}

class ImageData {
  final int linkId;
  final String uploadUrl;

  ImageData({
    required this.linkId,
    required this.uploadUrl,
  });

  // Factory method to parse JSON into ImageData
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      linkId: json['link_id/platform_user_id'] ?? 0,
      uploadUrl: json['upload_url'] ?? '',
    );
  }

  // Method to convert ImageData to JSON
  Map<String, dynamic> toJson() {
    return {
      'link_id/platform_user_id': linkId,
      'upload_url': uploadUrl,
    };
  }
}
