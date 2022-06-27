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
import 'package:easyenglish/generated/json/song_entity.g.dart';

@JsonSerializable()
class SongEntity {

	SongEntity();

	factory SongEntity.fromJson(Map<String, dynamic> json) => $SongEntityFromJson(json);

	Map<String, dynamic> toJson() => $SongEntityToJson(this);

  late bool status;
  late int code;
  SongData? data;
  String? message;
}

@JsonSerializable()
class SongData {

	SongData();

	factory SongData.fromJson(Map<String, dynamic> json) => $SongDataFromJson(json);

	Map<String, dynamic> toJson() => $SongDataToJson(this);

  late Song song;
}

@JsonSerializable()
class Song {

	Song();

	factory Song.fromJson(Map<String, dynamic> json) => $SongFromJson(json);

	Map<String, dynamic> toJson() => $SongToJson(this);

  late int id;
  late String name;
  late String icon;
  @JSONField(name: "icon_blurhash")
  late String iconBlurhash;
  late String image;
  @JSONField(name: "image_blurhash")
  late String imageBlurhash;
  late String audio;
  List<Lyrics>? lyrics;
}

@JsonSerializable()
class Lyrics {

	Lyrics();

	factory Lyrics.fromJson(Map<String, dynamic> json) => $LyricsFromJson(json);

	Map<String, dynamic> toJson() => $LyricsToJson(this);

  @JSONField(name: "song_id")
  late int songId;
  late String text;
  late String timestamp;
}
