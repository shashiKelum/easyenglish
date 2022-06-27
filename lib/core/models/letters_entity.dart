import 'dart:convert';

import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/letters_entity.g.dart';

@JsonSerializable()
class LettersEntity {

	late List<Letter> letters;
  
  LettersEntity();

  factory LettersEntity.fromJson(Map<String, dynamic> json) => $LettersEntityFromJson(json);

  Map<String, dynamic> toJson() => $LettersEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class Letter {

	late int index;
	late int start;
	late int end;
  
  Letter();

  factory Letter.fromJson(Map<String, dynamic> json) => $LetterFromJson(json);

  Map<String, dynamic> toJson() => $LetterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}