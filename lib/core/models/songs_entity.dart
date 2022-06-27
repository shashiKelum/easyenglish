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

import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/songs_entity.g.dart';

@JsonSerializable()
class SongsEntity {

	SongsEntity();

	factory SongsEntity.fromJson(Map<String, dynamic> json) => $SongsEntityFromJson(json);

	Map<String, dynamic> toJson() => $SongsEntityToJson(this);

  late bool status;
  late int code;
  SongsData? data;
  String? message;
}

@JsonSerializable()
class SongsData {

	SongsData();

	factory SongsData.fromJson(Map<String, dynamic> json) => $SongsDataFromJson(json);

	Map<String, dynamic> toJson() => $SongsDataToJson(this);

  List<Song>? songs;
}
