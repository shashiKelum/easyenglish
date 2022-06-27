import 'package:easyenglish/core/models/login_entity.dart';
import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
	final LoginEntity loginEntity = LoginEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		loginEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		loginEntity.code = code;
	}
	final LoginData? data = jsonConvert.convert<LoginData>(json['data']);
	if (data != null) {
		loginEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		loginEntity.message = message;
	}
	return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

LoginData $LoginDataFromJson(Map<String, dynamic> json) {
	final LoginData loginData = LoginData();
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginData.token = token;
	}
	final Profile? customer = jsonConvert.convert<Profile>(json['customer']);
	if (customer != null) {
		loginData.customer = customer;
	}
	return loginData;
}

Map<String, dynamic> $LoginDataToJson(LoginData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['token'] = entity.token;
	data['customer'] = entity.customer?.toJson();
	return data;
}