import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/core/models/profile_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


ProfileEntity $ProfileEntityFromJson(Map<String, dynamic> json) {
	final ProfileEntity profileEntity = ProfileEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		profileEntity.status = status;
	}
	final List<String>? error = jsonConvert.convertListNotNull<String>(json['error']);
	if (error != null) {
		profileEntity.error = error;
	}
	final Profile? user = jsonConvert.convert<Profile>(json['user']);
	if (user != null) {
		profileEntity.user = user;
	}
	return profileEntity;
}

Map<String, dynamic> $ProfileEntityToJson(ProfileEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['error'] =  entity.error;
	data['user'] = entity.user?.toJson();
	return data;
}