import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/term_entity.g.dart';

@JsonSerializable()
class TermEntity {

	TermEntity();

	factory TermEntity.fromJson(Map<String, dynamic> json) => $TermEntityFromJson(json);

	Map<String, dynamic> toJson() => $TermEntityToJson(this);

	late bool status;
	late int code;
	late TermData data;
	late String message;
}

@JsonSerializable()
class TermData {

	TermData();

	factory TermData.fromJson(Map<String, dynamic> json) => $TermDataFromJson(json);

	Map<String, dynamic> toJson() => $TermDataToJson(this);

	late Term term;
}

@JsonSerializable()
class Term {

	Term();

	factory Term.fromJson(Map<String, dynamic> json) => $TermFromJson(json);

	Map<String, dynamic> toJson() => $TermToJson(this);

	late int id;
	@JSONField(name: "english_term")
	late String englishTerm;
	@JSONField(name: "sinhala_term")
	String? sinhalaTerm;
	@JSONField(name: "tamil_term")
	String? tamilTerm;
	@JSONField(name: "audio_clip")
	String? audioClip;
	String? image;
	@JSONField(name: "image_blurhash")
	String? imageBlurhash;
	@JSONField(name: "similar_terms")
	List<Term>? similarTerms;
  String? audioPath;
}
