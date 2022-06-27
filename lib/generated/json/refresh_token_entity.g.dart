import 'package:easyenglish/core/models/refresh_token_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

RefreshTokenEntity $RefreshTokenEntityFromJson(Map<String, dynamic> json) {
	final RefreshTokenEntity refreshTokenEntity = RefreshTokenEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		refreshTokenEntity.status = status;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		refreshTokenEntity.token = token;
	}
	return refreshTokenEntity;
}

Map<String, dynamic> $RefreshTokenEntityToJson(RefreshTokenEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['token'] = entity.token;
	return data;
}