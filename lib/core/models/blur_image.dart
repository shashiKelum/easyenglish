import 'package:easyenglish/generated/json/blur_image.g.dart';

import '../../generated/json/base/json_field.dart';

@JsonSerializable()
class BlurImage {

	BlurImage();

	factory BlurImage.fromJson(Map<String, dynamic> json) => $BlurImageFromJson(json);

	Map<String, dynamic> toJson() => $BlurImageToJson(this);

  String? image;
  @JSONField(name: "blurhash")
  String? blurHash;
}
