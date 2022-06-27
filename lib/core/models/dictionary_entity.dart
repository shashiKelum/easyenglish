import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/dictionary_entity.g.dart';

@JsonSerializable()
class DictionaryEntity {

	DictionaryEntity();

	factory DictionaryEntity.fromJson(Map<String, dynamic> json) => $DictionaryEntityFromJson(json);

	Map<String, dynamic> toJson() => $DictionaryEntityToJson(this);

	late bool status;
	late int code;
	DictionaryData? data;
	String? message;
}

@JsonSerializable()
class DictionaryData {

	DictionaryData();

	factory DictionaryData.fromJson(Map<String, dynamic> json) => $DictionaryDataFromJson(json);

	Map<String, dynamic> toJson() => $DictionaryDataToJson(this);

	@JSONField(name: "book_terms")
	late List<Dictionary> bookTerms;
}

@JsonSerializable()
class Dictionary {

	Dictionary();

	factory Dictionary.fromJson(Map<String, dynamic> json) => $DictionaryFromJson(json);

	Map<String, dynamic> toJson() => $DictionaryToJson(this);

	late String letter;
	late List<Term> terms;
}