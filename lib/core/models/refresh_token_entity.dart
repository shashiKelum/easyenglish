import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/refresh_token_entity.g.dart';


@JsonSerializable()
class RefreshTokenEntity {

	RefreshTokenEntity();

	factory RefreshTokenEntity.fromJson(Map<String, dynamic> json) => $RefreshTokenEntityFromJson(json);

	Map<String, dynamic> toJson() => $RefreshTokenEntityToJson(this);

  late bool status;
  String? token;
}
