import 'package:easyenglish/core/models/letters_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

LettersEntity $LettersEntityFromJson(Map<String, dynamic> json) {
	final LettersEntity lettersEntity = LettersEntity();
	final List<Letter>? letters = jsonConvert.convertListNotNull<Letter>(json['letters']);
	if (letters != null) {
		lettersEntity.letters = letters;
	}
	return lettersEntity;
}

Map<String, dynamic> $LettersEntityToJson(LettersEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['letters'] =  entity.letters.map((v) => v.toJson()).toList();
	return data;
}

Letter $LetterFromJson(Map<String, dynamic> json) {
	final Letter letter = Letter();
	final int? index = jsonConvert.convert<int>(json['index']);
	if (index != null) {
		letter.index = index;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		letter.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		letter.end = end;
	}
	return letter;
}

Map<String, dynamic> $LetterToJson(Letter entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['index'] = entity.index;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}