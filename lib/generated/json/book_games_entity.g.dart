import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/book_games_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


BookGamesEntity $BookGamesEntityFromJson(Map<String, dynamic> json) {
	final BookGamesEntity bookGamesEntity = BookGamesEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		bookGamesEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		bookGamesEntity.code = code;
	}
	final BookGamesData? data = jsonConvert.convert<BookGamesData>(json['data']);
	if (data != null) {
		bookGamesEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		bookGamesEntity.message = message;
	}
	return bookGamesEntity;
}

Map<String, dynamic> $BookGamesEntityToJson(BookGamesEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

BookGamesData $BookGamesDataFromJson(Map<String, dynamic> json) {
	final BookGamesData bookGamesData = BookGamesData();
	final BookGames? games = jsonConvert.convert<BookGames>(json['games']);
	if (games != null) {
		bookGamesData.games = games;
	}
	return bookGamesData;
}

Map<String, dynamic> $BookGamesDataToJson(BookGamesData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['games'] = entity.games.toJson();
	return data;
}