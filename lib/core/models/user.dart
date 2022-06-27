import 'package:easyenglish/core/enums/auth_provider_type.dart';
import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/user.g.dart';
import 'package:equatable/equatable.dart';


// ignore: must_be_immutable
@JsonSerializable()
class AppUser extends Equatable {

	AppUser();

	factory AppUser.fromJson(Map<String, dynamic> json) => $AppUserFromJson(json);

	Map<String, dynamic> toJson() => $AppUserToJson(this);

  String? id;
  String? token;
  Profile? profile;

  // for auth process
  String? refreshToken;
  List<AuthProvider>? providers;

  @override
  List<Object?> get props => [id, token, refreshToken, profile];

  @override
  bool get stringify => true;
}

@JsonSerializable()
class AuthProvider {

	AuthProvider();

	factory AuthProvider.fromJson(Map<String, dynamic> json) => $AuthProviderFromJson(json);

	Map<String, dynamic> toJson() => $AuthProviderToJson(this);

  late String uid;
  late String provider;
  late String identifier;
  late bool isPrimary;

  //additional information
  String? name;

  AuthProviderType get providerType {
    return AuthProviderType.values
        .singleWhere((element) => element.id == provider);
  }
}
