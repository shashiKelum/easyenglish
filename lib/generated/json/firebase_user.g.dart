import 'package:easyenglish/core/models/firebase_user.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


FirebaseUser $FirebaseUserFromJson(Map<String, dynamic> json) {
	final FirebaseUser firebaseUser = FirebaseUser();
	final String? uid = jsonConvert.convert<String>(json['uid']);
	if (uid != null) {
		firebaseUser.uid = uid;
	}
	final String? mobile = jsonConvert.convert<String>(json['mobile']);
	if (mobile != null) {
		firebaseUser.mobile = mobile;
	}
	final String? mobileUid = jsonConvert.convert<String>(json['mobile_uid']);
	if (mobileUid != null) {
		firebaseUser.mobileUid = mobileUid;
	}
	final String? google = jsonConvert.convert<String>(json['google']);
	if (google != null) {
		firebaseUser.google = google;
	}
	final String? googleUid = jsonConvert.convert<String>(json['google_uid']);
	if (googleUid != null) {
		firebaseUser.googleUid = googleUid;
	}
	final String? facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		firebaseUser.facebook = facebook;
	}
	final String? facebookUid = jsonConvert.convert<String>(json['facebook_uid']);
	if (facebookUid != null) {
		firebaseUser.facebookUid = facebookUid;
	}
	final String? apple = jsonConvert.convert<String>(json['apple']);
	if (apple != null) {
		firebaseUser.apple = apple;
	}
	final String? appleUid = jsonConvert.convert<String>(json['apple_uid']);
	if (appleUid != null) {
		firebaseUser.appleUid = appleUid;
	}
	final String? firstName = jsonConvert.convert<String>(json['first_name']);
	if (firstName != null) {
		firebaseUser.firstName = firstName;
	}
	final String? lastName = jsonConvert.convert<String>(json['last_name']);
	if (lastName != null) {
		firebaseUser.lastName = lastName;
	}
	return firebaseUser;
}

Map<String, dynamic> $FirebaseUserToJson(FirebaseUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['uid'] = entity.uid;
	data['mobile'] = entity.mobile;
	data['mobile_uid'] = entity.mobileUid;
	data['google'] = entity.google;
	data['google_uid'] = entity.googleUid;
	data['facebook'] = entity.facebook;
	data['facebook_uid'] = entity.facebookUid;
	data['apple'] = entity.apple;
	data['apple_uid'] = entity.appleUid;
	data['first_name'] = entity.firstName;
	data['last_name'] = entity.lastName;
	return data;
}