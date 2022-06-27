/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/profile.g.dart';
import 'package:equatable/equatable.dart';

@JsonSerializable()
class Profile extends Equatable {

	Profile();

	factory Profile.fromJson(Map<String, dynamic> json) => $ProfileFromJson(json);

	Map<String, dynamic> toJson() => $ProfileToJson(this);

  late int id;
  @JSONField(name: "firebase_reg_id")
  String? firebaseRegId;
  @JSONField(name: "first_name")
  String? firstName;
  @JSONField(name: "last_name")
  String? lastName;
  @JSONField(name: "mobile_no")
  String? mobileNo;
  String? email;
  @JSONField(name: "is_parent")
  late int isParent = 1;

  @override
  List<Object?> get props => [id, firebaseRegId];
}