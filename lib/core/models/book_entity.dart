/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:easyenglish/core/models/game_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_field.dart';
import 'package:easyenglish/generated/json/book_entity.g.dart';

@JsonSerializable()
class BookEntity {

	BookEntity();

	factory BookEntity.fromJson(Map<String, dynamic> json) => $BookEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookEntityToJson(this);

  late bool status;
  late int code;
  BookData? data;
  String? message;
}

@JsonSerializable()
class BookData {

	BookData();

	factory BookData.fromJson(Map<String, dynamic> json) => $BookDataFromJson(json);

	Map<String, dynamic> toJson() => $BookDataToJson(this);

  late Book book;
}

@JsonSerializable()
class Book {

	Book();

	factory Book.fromJson(Map<String, dynamic> json) => $BookFromJson(json);

	Map<String, dynamic> toJson() => $BookToJson(this);

  late int id;
  late String title;
  late String subtitle;
  late String image;
  @JSONField(name: "image_blur_hash")
  late String imageBlurHash;
  @JSONField(name: "free_or_paid")
  late int freeOrPaid;
  late String price;
  late int level;
  late int subscribe;
  late int listen;
  late int speaking;
  late int grammer;
  @JSONField(name: "book_status")
  late int bookStatus;
  late List<BookPage> pages;
  late BookGames games;
  @JSONField(name: "primary_color")
  late String primaryColor;
  @JSONField(name: "secondary_color")
  late String secondaryColor;
  @JSONField(name: "prelude_terms")
  late List<Term> preludeTerms;
}

@JsonSerializable()
class BookPage {

	BookPage();

	factory BookPage.fromJson(Map<String, dynamic> json) => $BookPageFromJson(json);

	Map<String, dynamic> toJson() => $BookPageToJson(this);

  late int id;
  @JSONField(name: "page_no")
  late int pageNo;
  late String image;
  @JSONField(name: "image_blurhash")
  late String imageBlurhash;
  late String audio;
  late List<Sentence> sentences;
  late String imagePath;
  late String audioPath;
}

@JsonSerializable()
class Sentence {

	Sentence();

	factory Sentence.fromJson(Map<String, dynamic> json) => $SentenceFromJson(json);

	Map<String, dynamic> toJson() => $SentenceToJson(this);

  late int id;
  late int seq;
  late String sentence;
  late List<Word> words;
}

@JsonSerializable()
class Word {

	Word();

	factory Word.fromJson(Map<String, dynamic> json) => $WordFromJson(json);

	Map<String, dynamic> toJson() => $WordToJson(this);

  late int id;
  late String word;
  late int start;
  late int end;
  late int term;
}

@JsonSerializable()
class BookGames {

	BookGames();

	factory BookGames.fromJson(Map<String, dynamic> json) => $BookGamesFromJson(json);

	Map<String, dynamic> toJson() => $BookGamesToJson(this);

  @JSONField(name: "G1")
  late Game1 g1;
  @JSONField(name: "G2")
  late Game2 g2;
  @JSONField(name: "G3")
  late Game3 g3;
  @JSONField(name: "G4")
  late Game4 g4;
}

@JsonSerializable()
class Game1 {

	Game1();

	factory Game1.fromJson(Map<String, dynamic> json) => $Game1FromJson(json);

	Map<String, dynamic> toJson() => $Game1ToJson(this);

  late int completed;
  late List<Game1Option> games;
}

@JsonSerializable()
class Game1Option extends GameBaseOption {

	Game1Option();

	factory Game1Option.fromJson(Map<String, dynamic> json) => $Game1OptionFromJson(json);

	Map<String, dynamic> toJson() => $Game1OptionToJson(this);

  late int id;
  late String question;
  late int answer;
  late String image1;
  late String image1blur;
  late String image1text;
  late String image2;
  late String image2blur;
  late String image2text;
  late String image3;
  late String image3blur;
  late String image3text;
  late String image4;
  late String image4blur;
  late String image4text;
  late int status;
}

@JsonSerializable()
class Game2 {

	Game2();

	factory Game2.fromJson(Map<String, dynamic> json) => $Game2FromJson(json);

	Map<String, dynamic> toJson() => $Game2ToJson(this);

  late int completed;
  late List<Game2Option> games;
}

@JsonSerializable()
class Game2Option extends GameBaseOption {

	Game2Option();

	factory Game2Option.fromJson(Map<String, dynamic> json) => $Game2OptionFromJson(json);

	Map<String, dynamic> toJson() => $Game2OptionToJson(this);

  late int id;
  late String question;
  late int answer;
  late String image1;
  late String image1blur;
  late String image1text;
  late String image2;
  late String image2blur;
  late String image2text;
  late String image3;
  late String image3blur;
  late String image3text;
  late String image4;
  late String image4blur;
  late String image4text;
  late String audio;
  late String? audioPath;
  late int status;
}

@JsonSerializable()
class Game3 {

	Game3();

	factory Game3.fromJson(Map<String, dynamic> json) => $Game3FromJson(json);

	Map<String, dynamic> toJson() => $Game3ToJson(this);

  late int completed;
  late List<Game3Option> games;
}

@JsonSerializable()
class Game3Option extends GameBaseOption {

	Game3Option();

	factory Game3Option.fromJson(Map<String, dynamic> json) => $Game3OptionFromJson(json);

	Map<String, dynamic> toJson() => $Game3OptionToJson(this);

  late int id;
  late String question;
  late List<Game3Word> words;
  late int status;
}

@JsonSerializable()
class Game3Word {

	Game3Word();

	factory Game3Word.fromJson(Map<String, dynamic> json) => $Game3WordFromJson(json);

	Map<String, dynamic> toJson() => $Game3WordToJson(this);

  late String word;
  late int term;
}

@JsonSerializable()
class Game4 {

	Game4();

	factory Game4.fromJson(Map<String, dynamic> json) => $Game4FromJson(json);

	Map<String, dynamic> toJson() => $Game4ToJson(this);

  late int completed;
  late List<Game4Option> games;
}

@JsonSerializable()
class Game4Option extends GameBaseOption {

	Game4Option();

	factory Game4Option.fromJson(Map<String, dynamic> json) => $Game4OptionFromJson(json);

	Map<String, dynamic> toJson() => $Game4OptionToJson(this);

  late int id;
  late String question;
  late int status;
}
