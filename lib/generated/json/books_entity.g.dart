import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/books_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


BooksEntity $BooksEntityFromJson(Map<String, dynamic> json) {
	final BooksEntity booksEntity = BooksEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		booksEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		booksEntity.code = code;
	}
	final BooksData? data = jsonConvert.convert<BooksData>(json['data']);
	if (data != null) {
		booksEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		booksEntity.message = message;
	}
	return booksEntity;
}

Map<String, dynamic> $BooksEntityToJson(BooksEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

BooksData $BooksDataFromJson(Map<String, dynamic> json) {
	final BooksData booksData = BooksData();
	final List<Book>? books = jsonConvert.convertListNotNull<Book>(json['books']);
	if (books != null) {
		booksData.books = books;
	}
	return booksData;
}

Map<String, dynamic> $BooksDataToJson(BooksData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['books'] =  entity.books?.map((v) => v.toJson()).toList();
	return data;
}