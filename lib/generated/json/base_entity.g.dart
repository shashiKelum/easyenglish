import 'package:easyenglish/core/models/base_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

BaseEntity $BaseEntityFromJson(Map<String, dynamic> json) {
	final BaseEntity baseEntity = BaseEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		baseEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		baseEntity.code = code;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		baseEntity.message = message;
	}
	final List<String>? error = jsonConvert.convertListNotNull<String>(json['error']);
	if (error != null) {
		baseEntity.error = error;
	}
	return baseEntity;
}

Map<String, dynamic> $BaseEntityToJson(BaseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['message'] = entity.message;
	data['error'] =  entity.error;
	return data;
}