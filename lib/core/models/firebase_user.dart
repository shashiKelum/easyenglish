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
import 'package:easyenglish/generated/json/firebase_user.g.dart';
import 'package:equatable/equatable.dart';

@JsonSerializable()
class FirebaseUser extends Equatable {

	FirebaseUser();

	factory FirebaseUser.fromJson(Map<String, dynamic> json) => $FirebaseUserFromJson(json);

	Map<String, dynamic> toJson() => $FirebaseUserToJson(this);

  String? uid;
  String? mobile;
  @JSONField(name: "mobile_uid")
  String? mobileUid;
  String? google;
  @JSONField(name: "google_uid")
  String? googleUid;
  String? facebook;
  @JSONField(name: "facebook_uid")
  String? facebookUid;
  String? apple;
  @JSONField(name: "apple_uid")
  String? appleUid;
  @JSONField(name: "first_name")
  String? firstName;
  @JSONField(name: "last_name")
  String? lastName;

  @override
  List<Object?> get props => [
        uid,
        mobile,
        mobileUid,
        google,
        googleUid,
        facebook,
        facebookUid,
        apple,
        appleUid,
        firstName,
        lastName
      ];
}
