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

import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/current_book_entity.g.dart';

@JsonSerializable()
class CurrentBookEntity {

	CurrentBookEntity();

	factory CurrentBookEntity.fromJson(Map<String, dynamic> json) => $CurrentBookEntityFromJson(json);

	Map<String, dynamic> toJson() => $CurrentBookEntityToJson(this);

  late bool status;
  late int code;
  CurrentBookData? data;
  String? message;
}

@JsonSerializable()
class CurrentBookData {

	CurrentBookData();

	factory CurrentBookData.fromJson(Map<String, dynamic> json) => $CurrentBookDataFromJson(json);

	Map<String, dynamic> toJson() => $CurrentBookDataToJson(this);

  late Book books;
}