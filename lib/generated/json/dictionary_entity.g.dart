import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


DictionaryEntity $DictionaryEntityFromJson(Map<String, dynamic> json) {
	final DictionaryEntity dictionaryEntity = DictionaryEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		dictionaryEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		dictionaryEntity.code = code;
	}
	final DictionaryData? data = jsonConvert.convert<DictionaryData>(json['data']);
	if (data != null) {
		dictionaryEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		dictionaryEntity.message = message;
	}
	return dictionaryEntity;
}

Map<String, dynamic> $DictionaryEntityToJson(DictionaryEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

DictionaryData $DictionaryDataFromJson(Map<String, dynamic> json) {
	final DictionaryData dictionaryData = DictionaryData();
	final List<Dictionary>? bookTerms = jsonConvert.convertListNotNull<Dictionary>(json['book_terms']);
	if (bookTerms != null) {
		dictionaryData.bookTerms = bookTerms;
	}
	return dictionaryData;
}

Map<String, dynamic> $DictionaryDataToJson(DictionaryData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['book_terms'] =  entity.bookTerms.map((v) => v.toJson()).toList();
	return data;
}

Dictionary $DictionaryFromJson(Map<String, dynamic> json) {
	final Dictionary dictionary = Dictionary();
	final String? letter = jsonConvert.convert<String>(json['letter']);
	if (letter != null) {
		dictionary.letter = letter;
	}
	final List<Term>? terms = jsonConvert.convertListNotNull<Term>(json['terms']);
	if (terms != null) {
		dictionary.terms = terms;
	}
	return dictionary;
}

Map<String, dynamic> $DictionaryToJson(Dictionary entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['letter'] = entity.letter;
	data['terms'] =  entity.terms.map((v) => v.toJson()).toList();
	return data;
}