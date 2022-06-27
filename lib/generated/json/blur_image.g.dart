import 'package:easyenglish/core/models/blur_image.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

BlurImage $BlurImageFromJson(Map<String, dynamic> json) {
	final BlurImage blurImage = BlurImage();
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		blurImage.image = image;
	}
	final String? blurHash = jsonConvert.convert<String>(json['blurhash']);
	if (blurHash != null) {
		blurImage.blurHash = blurHash;
	}
	return blurImage;
}

Map<String, dynamic> $BlurImageToJson(BlurImage entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['image'] = entity.image;
	data['blurhash'] = entity.blurHash;
	return data;
}