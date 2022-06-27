import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/core/models/songs_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


SongsEntity $SongsEntityFromJson(Map<String, dynamic> json) {
	final SongsEntity songsEntity = SongsEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		songsEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		songsEntity.code = code;
	}
	final SongsData? data = jsonConvert.convert<SongsData>(json['data']);
	if (data != null) {
		songsEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		songsEntity.message = message;
	}
	return songsEntity;
}

Map<String, dynamic> $SongsEntityToJson(SongsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

SongsData $SongsDataFromJson(Map<String, dynamic> json) {
	final SongsData songsData = SongsData();
	final List<Song>? songs = jsonConvert.convertListNotNull<Song>(json['songs']);
	if (songs != null) {
		songsData.songs = songs;
	}
	return songsData;
}

Map<String, dynamic> $SongsDataToJson(SongsData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['songs'] =  entity.songs?.map((v) => v.toJson()).toList();
	return data;
}