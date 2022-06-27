import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

SongEntity $SongEntityFromJson(Map<String, dynamic> json) {
	final SongEntity songEntity = SongEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		songEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		songEntity.code = code;
	}
	final SongData? data = jsonConvert.convert<SongData>(json['data']);
	if (data != null) {
		songEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		songEntity.message = message;
	}
	return songEntity;
}

Map<String, dynamic> $SongEntityToJson(SongEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

SongData $SongDataFromJson(Map<String, dynamic> json) {
	final SongData songData = SongData();
	final Song? song = jsonConvert.convert<Song>(json['song']);
	if (song != null) {
		songData.song = song;
	}
	return songData;
}

Map<String, dynamic> $SongDataToJson(SongData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['song'] = entity.song.toJson();
	return data;
}

Song $SongFromJson(Map<String, dynamic> json) {
	final Song song = Song();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		song.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		song.name = name;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		song.icon = icon;
	}
	final String? iconBlurhash = jsonConvert.convert<String>(json['icon_blurhash']);
	if (iconBlurhash != null) {
		song.iconBlurhash = iconBlurhash;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		song.image = image;
	}
	final String? imageBlurhash = jsonConvert.convert<String>(json['image_blurhash']);
	if (imageBlurhash != null) {
		song.imageBlurhash = imageBlurhash;
	}
	final String? audio = jsonConvert.convert<String>(json['audio']);
	if (audio != null) {
		song.audio = audio;
	}
	final List<Lyrics>? lyrics = jsonConvert.convertListNotNull<Lyrics>(json['lyrics']);
	if (lyrics != null) {
		song.lyrics = lyrics;
	}
	return song;
}

Map<String, dynamic> $SongToJson(Song entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['icon'] = entity.icon;
	data['icon_blurhash'] = entity.iconBlurhash;
	data['image'] = entity.image;
	data['image_blurhash'] = entity.imageBlurhash;
	data['audio'] = entity.audio;
	data['lyrics'] =  entity.lyrics?.map((v) => v.toJson()).toList();
	return data;
}

Lyrics $LyricsFromJson(Map<String, dynamic> json) {
	final Lyrics lyrics = Lyrics();
	final int? songId = jsonConvert.convert<int>(json['song_id']);
	if (songId != null) {
		lyrics.songId = songId;
	}
	final String? text = jsonConvert.convert<String>(json['text']);
	if (text != null) {
		lyrics.text = text;
	}
	final String? timestamp = jsonConvert.convert<String>(json['timestamp']);
	if (timestamp != null) {
		lyrics.timestamp = timestamp;
	}
	return lyrics;
}

Map<String, dynamic> $LyricsToJson(Lyrics entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['song_id'] = entity.songId;
	data['text'] = entity.text;
	data['timestamp'] = entity.timestamp;
	return data;
}