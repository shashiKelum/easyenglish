import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/core/models/user.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


AppUser $AppUserFromJson(Map<String, dynamic> json) {
	final AppUser appUser = AppUser();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		appUser.id = id;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		appUser.token = token;
	}
	final Profile? profile = jsonConvert.convert<Profile>(json['profile']);
	if (profile != null) {
		appUser.profile = profile;
	}
	final String? refreshToken = jsonConvert.convert<String>(json['refreshToken']);
	if (refreshToken != null) {
		appUser.refreshToken = refreshToken;
	}
	final List<AuthProvider>? providers = jsonConvert.convertListNotNull<AuthProvider>(json['providers']);
	if (providers != null) {
		appUser.providers = providers;
	}
	return appUser;
}

Map<String, dynamic> $AppUserToJson(AppUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['token'] = entity.token;
	data['profile'] = entity.profile?.toJson();
	data['refreshToken'] = entity.refreshToken;
	data['providers'] =  entity.providers?.map((v) => v.toJson()).toList();
	return data;
}

AuthProvider $AuthProviderFromJson(Map<String, dynamic> json) {
	final AuthProvider authProvider = AuthProvider();
	final String? uid = jsonConvert.convert<String>(json['uid']);
	if (uid != null) {
		authProvider.uid = uid;
	}
	final String? provider = jsonConvert.convert<String>(json['provider']);
	if (provider != null) {
		authProvider.provider = provider;
	}
	final String? identifier = jsonConvert.convert<String>(json['identifier']);
	if (identifier != null) {
		authProvider.identifier = identifier;
	}
	final bool? isPrimary = jsonConvert.convert<bool>(json['isPrimary']);
	if (isPrimary != null) {
		authProvider.isPrimary = isPrimary;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		authProvider.name = name;
	}
	return authProvider;
}

Map<String, dynamic> $AuthProviderToJson(AuthProvider entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['uid'] = entity.uid;
	data['provider'] = entity.provider;
	data['identifier'] = entity.identifier;
	data['isPrimary'] = entity.isPrimary;
	data['name'] = entity.name;
	return data;
}