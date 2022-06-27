import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';

TermEntity $TermEntityFromJson(Map<String, dynamic> json) {
	final TermEntity termEntity = TermEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		termEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		termEntity.code = code;
	}
	final TermData? data = jsonConvert.convert<TermData>(json['data']);
	if (data != null) {
		termEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		termEntity.message = message;
	}
	return termEntity;
}

Map<String, dynamic> $TermEntityToJson(TermEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data.toJson();
	data['message'] = entity.message;
	return data;
}

TermData $TermDataFromJson(Map<String, dynamic> json) {
	final TermData termData = TermData();
	final Term? term = jsonConvert.convert<Term>(json['term']);
	if (term != null) {
		termData.term = term;
	}
	return termData;
}

Map<String, dynamic> $TermDataToJson(TermData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['term'] = entity.term.toJson();
	return data;
}

Term $TermFromJson(Map<String, dynamic> json) {
	final Term term = Term();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		term.id = id;
	}
	final String? englishTerm = jsonConvert.convert<String>(json['english_term']);
	if (englishTerm != null) {
		term.englishTerm = englishTerm;
	}
	final String? sinhalaTerm = jsonConvert.convert<String>(json['sinhala_term']);
	if (sinhalaTerm != null) {
		term.sinhalaTerm = sinhalaTerm;
	}
	final String? tamilTerm = jsonConvert.convert<String>(json['tamil_term']);
	if (tamilTerm != null) {
		term.tamilTerm = tamilTerm;
	}
	final String? audioClip = jsonConvert.convert<String>(json['audio_clip']);
	if (audioClip != null) {
		term.audioClip = audioClip;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		term.image = image;
	}
	final String? imageBlurhash = jsonConvert.convert<String>(json['image_blurhash']);
	if (imageBlurhash != null) {
		term.imageBlurhash = imageBlurhash;
	}
	final List<Term>? similarTerms = jsonConvert.convertListNotNull<Term>(json['similar_terms']);
	if (similarTerms != null) {
		term.similarTerms = similarTerms;
	}
	final String? audioPath = jsonConvert.convert<String>(json['audioPath']);
	if (audioPath != null) {
		term.audioPath = audioPath;
	}
	return term;
}

Map<String, dynamic> $TermToJson(Term entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['english_term'] = entity.englishTerm;
	data['sinhala_term'] = entity.sinhalaTerm;
	data['tamil_term'] = entity.tamilTerm;
	data['audio_clip'] = entity.audioClip;
	data['image'] = entity.image;
	data['image_blurhash'] = entity.imageBlurhash;
	data['similar_terms'] =  entity.similarTerms?.map((v) => v.toJson()).toList();
	data['audioPath'] = entity.audioPath;
	return data;
}