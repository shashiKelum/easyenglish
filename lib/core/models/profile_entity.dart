import 'package:easyenglish/core/models/profile.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/profile_entity.g.dart';


@JsonSerializable()
class ProfileEntity {

	ProfileEntity();

	factory ProfileEntity.fromJson(Map<String, dynamic> json) => $ProfileEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProfileEntityToJson(this);

  late bool status;
  List<String>? error;
  Profile? user;
}
