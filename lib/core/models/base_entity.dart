import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/base_entity.g.dart';

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


@JsonSerializable()
class BaseEntity {

	BaseEntity();

	factory BaseEntity.fromJson(Map<String, dynamic> json) => $BaseEntityFromJson(json);

	Map<String, dynamic> toJson() => $BaseEntityToJson(this);

  late bool status;
  late int code;
  String? message;
  List<String>? error;
}
