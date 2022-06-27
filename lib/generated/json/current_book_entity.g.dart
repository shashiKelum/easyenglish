import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/current_book_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


CurrentBookEntity $CurrentBookEntityFromJson(Map<String, dynamic> json) {
	final CurrentBookEntity currentBookEntity = CurrentBookEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		currentBookEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		currentBookEntity.code = code;
	}
	final CurrentBookData? data = jsonConvert.convert<CurrentBookData>(json['data']);
	if (data != null) {
		currentBookEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		currentBookEntity.message = message;
	}
	return currentBookEntity;
}

Map<String, dynamic> $CurrentBookEntityToJson(CurrentBookEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

CurrentBookData $CurrentBookDataFromJson(Map<String, dynamic> json) {
	final CurrentBookData currentBookData = CurrentBookData();
	final Book? books = jsonConvert.convert<Book>(json['books']);
	if (books != null) {
		currentBookData.books = books;
	}
	return currentBookData;
}

Map<String, dynamic> $CurrentBookDataToJson(CurrentBookData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['books'] = entity.books.toJson();
	return data;
}