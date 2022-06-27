import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


Profile $ProfileFromJson(Map<String, dynamic> json) {
	final Profile profile = Profile();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		profile.id = id;
	}
	final String? firebaseRegId = jsonConvert.convert<String>(json['firebase_reg_id']);
	if (firebaseRegId != null) {
		profile.firebaseRegId = firebaseRegId;
	}
	final String? firstName = jsonConvert.convert<String>(json['first_name']);
	if (firstName != null) {
		profile.firstName = firstName;
	}
	final String? lastName = jsonConvert.convert<String>(json['last_name']);
	if (lastName != null) {
		profile.lastName = lastName;
	}
	final String? mobileNo = jsonConvert.convert<String>(json['mobile_no']);
	if (mobileNo != null) {
		profile.mobileNo = mobileNo;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		profile.email = email;
	}
	final int? isParent = jsonConvert.convert<int>(json['is_parent']);
	if (isParent != null) {
		profile.isParent = isParent;
	}
	return profile;
}

Map<String, dynamic> $ProfileToJson(Profile entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['firebase_reg_id'] = entity.firebaseRegId;
	data['first_name'] = entity.firstName;
	data['last_name'] = entity.lastName;
	data['mobile_no'] = entity.mobileNo;
	data['email'] = entity.email;
	data['is_parent'] = entity.isParent;
	return data;
}