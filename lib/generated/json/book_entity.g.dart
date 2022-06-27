import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';


BookEntity $BookEntityFromJson(Map<String, dynamic> json) {
	final BookEntity bookEntity = BookEntity();
	final bool? status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		bookEntity.status = status;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		bookEntity.code = code;
	}
	final BookData? data = jsonConvert.convert<BookData>(json['data']);
	if (data != null) {
		bookEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		bookEntity.message = message;
	}
	return bookEntity;
}

Map<String, dynamic> $BookEntityToJson(BookEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

BookData $BookDataFromJson(Map<String, dynamic> json) {
	final BookData bookData = BookData();
	final Book? book = jsonConvert.convert<Book>(json['book']);
	if (book != null) {
		bookData.book = book;
	}
	return bookData;
}

Map<String, dynamic> $BookDataToJson(BookData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['book'] = entity.book.toJson();
	return data;
}

Book $BookFromJson(Map<String, dynamic> json) {
	final Book book = Book();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		book.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		book.title = title;
	}
	final String? subtitle = jsonConvert.convert<String>(json['subtitle']);
	if (subtitle != null) {
		book.subtitle = subtitle;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		book.image = image;
	}
	final String? imageBlurHash = jsonConvert.convert<String>(json['image_blur_hash']);
	if (imageBlurHash != null) {
		book.imageBlurHash = imageBlurHash;
	}
	final int? freeOrPaid = jsonConvert.convert<int>(json['free_or_paid']);
	if (freeOrPaid != null) {
		book.freeOrPaid = freeOrPaid;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		book.price = price;
	}
	final int? level = jsonConvert.convert<int>(json['level']);
	if (level != null) {
		book.level = level;
	}
	final int? subscribe = jsonConvert.convert<int>(json['subscribe']);
	if (subscribe != null) {
		book.subscribe = subscribe;
	}
	final int? listen = jsonConvert.convert<int>(json['listen']);
	if (listen != null) {
		book.listen = listen;
	}
	final int? speaking = jsonConvert.convert<int>(json['speaking']);
	if (speaking != null) {
		book.speaking = speaking;
	}
	final int? grammer = jsonConvert.convert<int>(json['grammer']);
	if (grammer != null) {
		book.grammer = grammer;
	}
	final int? bookStatus = jsonConvert.convert<int>(json['book_status']);
	if (bookStatus != null) {
		book.bookStatus = bookStatus;
	}
	final List<BookPage>? pages = jsonConvert.convertListNotNull<BookPage>(json['pages']);
	if (pages != null) {
		book.pages = pages;
	}
	final BookGames? games = jsonConvert.convert<BookGames>(json['games']);
	if (games != null) {
		book.games = games;
	}
	final String? primaryColor = jsonConvert.convert<String>(json['primary_color']);
	if (primaryColor != null) {
		book.primaryColor = primaryColor;
	}
	final String? secondaryColor = jsonConvert.convert<String>(json['secondary_color']);
	if (secondaryColor != null) {
		book.secondaryColor = secondaryColor;
	}
	final List<Term>? preludeTerms = jsonConvert.convertListNotNull<Term>(json['prelude_terms']);
	if (preludeTerms != null) {
		book.preludeTerms = preludeTerms;
	}
	return book;
}

Map<String, dynamic> $BookToJson(Book entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['subtitle'] = entity.subtitle;
	data['image'] = entity.image;
	data['image_blur_hash'] = entity.imageBlurHash;
	data['free_or_paid'] = entity.freeOrPaid;
	data['price'] = entity.price;
	data['level'] = entity.level;
	data['subscribe'] = entity.subscribe;
	data['listen'] = entity.listen;
	data['speaking'] = entity.speaking;
	data['grammer'] = entity.grammer;
	data['book_status'] = entity.bookStatus;
	data['pages'] =  entity.pages.map((v) => v.toJson()).toList();
	data['games'] = entity.games.toJson();
	data['primary_color'] = entity.primaryColor;
	data['secondary_color'] = entity.secondaryColor;
	data['prelude_terms'] =  entity.preludeTerms.map((v) => v.toJson()).toList();
	return data;
}

BookPage $BookPageFromJson(Map<String, dynamic> json) {
	final BookPage bookPage = BookPage();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		bookPage.id = id;
	}
	final int? pageNo = jsonConvert.convert<int>(json['page_no']);
	if (pageNo != null) {
		bookPage.pageNo = pageNo;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		bookPage.image = image;
	}
	final String? imageBlurhash = jsonConvert.convert<String>(json['image_blurhash']);
	if (imageBlurhash != null) {
		bookPage.imageBlurhash = imageBlurhash;
	}
	final String? audio = jsonConvert.convert<String>(json['audio']);
	if (audio != null) {
		bookPage.audio = audio;
	}
	final List<Sentence>? sentences = jsonConvert.convertListNotNull<Sentence>(json['sentences']);
	if (sentences != null) {
		bookPage.sentences = sentences;
	}
	final String? imagePath = jsonConvert.convert<String>(json['imagePath']);
	if (imagePath != null) {
		bookPage.imagePath = imagePath;
	}
	final String? audioPath = jsonConvert.convert<String>(json['audioPath']);
	if (audioPath != null) {
		bookPage.audioPath = audioPath;
	}
	return bookPage;
}

Map<String, dynamic> $BookPageToJson(BookPage entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['page_no'] = entity.pageNo;
	data['image'] = entity.image;
	data['image_blurhash'] = entity.imageBlurhash;
	data['audio'] = entity.audio;
	data['sentences'] =  entity.sentences.map((v) => v.toJson()).toList();
	data['imagePath'] = entity.imagePath;
	data['audioPath'] = entity.audioPath;
	return data;
}

Sentence $SentenceFromJson(Map<String, dynamic> json) {
	final Sentence sentence = Sentence();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		sentence.id = id;
	}
	final int? seq = jsonConvert.convert<int>(json['seq']);
	if (seq != null) {
		sentence.seq = seq;
	}
	final String? _sentence = jsonConvert.convert<String>(json['sentence']);
	if (_sentence != null) {
		sentence.sentence = _sentence;
	}
	final List<Word>? words = jsonConvert.convertListNotNull<Word>(json['words']);
	if (words != null) {
		sentence.words = words;
	}
	return sentence;
}

Map<String, dynamic> $SentenceToJson(Sentence entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['seq'] = entity.seq;
	data['sentence'] = entity.sentence;
	data['words'] =  entity.words.map((v) => v.toJson()).toList();
	return data;
}

Word $WordFromJson(Map<String, dynamic> json) {
	final Word word = Word();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		word.id = id;
	}
	final String? _word = jsonConvert.convert<String>(json['word']);
	if (_word != null) {
		word.word = _word;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		word.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		word.end = end;
	}
	final int? term = jsonConvert.convert<int>(json['term']);
	if (term != null) {
		word.term = term;
	}
	return word;
}

Map<String, dynamic> $WordToJson(Word entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['word'] = entity.word;
	data['start'] = entity.start;
	data['end'] = entity.end;
	data['term'] = entity.term;
	return data;
}

BookGames $BookGamesFromJson(Map<String, dynamic> json) {
	final BookGames bookGames = BookGames();
	final Game1? g1 = jsonConvert.convert<Game1>(json['G1']);
	if (g1 != null) {
		bookGames.g1 = g1;
	}
	final Game2? g2 = jsonConvert.convert<Game2>(json['G2']);
	if (g2 != null) {
		bookGames.g2 = g2;
	}
	final Game3? g3 = jsonConvert.convert<Game3>(json['G3']);
	if (g3 != null) {
		bookGames.g3 = g3;
	}
	final Game4? g4 = jsonConvert.convert<Game4>(json['G4']);
	if (g4 != null) {
		bookGames.g4 = g4;
	}
	return bookGames;
}

Map<String, dynamic> $BookGamesToJson(BookGames entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['G1'] = entity.g1.toJson();
	data['G2'] = entity.g2.toJson();
	data['G3'] = entity.g3.toJson();
	data['G4'] = entity.g4.toJson();
	return data;
}

Game1 $Game1FromJson(Map<String, dynamic> json) {
	final Game1 game1 = Game1();
	final int? completed = jsonConvert.convert<int>(json['completed']);
	if (completed != null) {
		game1.completed = completed;
	}
	final List<Game1Option>? games = jsonConvert.convertListNotNull<Game1Option>(json['games']);
	if (games != null) {
		game1.games = games;
	}
	return game1;
}

Map<String, dynamic> $Game1ToJson(Game1 entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['completed'] = entity.completed;
	data['games'] =  entity.games.map((v) => v.toJson()).toList();
	return data;
}

Game1Option $Game1OptionFromJson(Map<String, dynamic> json) {
	final Game1Option game1Option = Game1Option();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		game1Option.id = id;
	}
	final String? question = jsonConvert.convert<String>(json['question']);
	if (question != null) {
		game1Option.question = question;
	}
	final int? answer = jsonConvert.convert<int>(json['answer']);
	if (answer != null) {
		game1Option.answer = answer;
	}
	final String? image1 = jsonConvert.convert<String>(json['image1']);
	if (image1 != null) {
		game1Option.image1 = image1;
	}
	final String? image1blur = jsonConvert.convert<String>(json['image1blur']);
	if (image1blur != null) {
		game1Option.image1blur = image1blur;
	}
	final String? image1text = jsonConvert.convert<String>(json['image1text']);
	if (image1text != null) {
		game1Option.image1text = image1text;
	}
	final String? image2 = jsonConvert.convert<String>(json['image2']);
	if (image2 != null) {
		game1Option.image2 = image2;
	}
	final String? image2blur = jsonConvert.convert<String>(json['image2blur']);
	if (image2blur != null) {
		game1Option.image2blur = image2blur;
	}
	final String? image2text = jsonConvert.convert<String>(json['image2text']);
	if (image2text != null) {
		game1Option.image2text = image2text;
	}
	final String? image3 = jsonConvert.convert<String>(json['image3']);
	if (image3 != null) {
		game1Option.image3 = image3;
	}
	final String? image3blur = jsonConvert.convert<String>(json['image3blur']);
	if (image3blur != null) {
		game1Option.image3blur = image3blur;
	}
	final String? image3text = jsonConvert.convert<String>(json['image3text']);
	if (image3text != null) {
		game1Option.image3text = image3text;
	}
	final String? image4 = jsonConvert.convert<String>(json['image4']);
	if (image4 != null) {
		game1Option.image4 = image4;
	}
	final String? image4blur = jsonConvert.convert<String>(json['image4blur']);
	if (image4blur != null) {
		game1Option.image4blur = image4blur;
	}
	final String? image4text = jsonConvert.convert<String>(json['image4text']);
	if (image4text != null) {
		game1Option.image4text = image4text;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		game1Option.status = status;
	}
	return game1Option;
}

Map<String, dynamic> $Game1OptionToJson(Game1Option entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['question'] = entity.question;
	data['answer'] = entity.answer;
	data['image1'] = entity.image1;
	data['image1blur'] = entity.image1blur;
	data['image1text'] = entity.image1text;
	data['image2'] = entity.image2;
	data['image2blur'] = entity.image2blur;
	data['image2text'] = entity.image2text;
	data['image3'] = entity.image3;
	data['image3blur'] = entity.image3blur;
	data['image3text'] = entity.image3text;
	data['image4'] = entity.image4;
	data['image4blur'] = entity.image4blur;
	data['image4text'] = entity.image4text;
	data['status'] = entity.status;
	return data;
}

Game2 $Game2FromJson(Map<String, dynamic> json) {
	final Game2 game2 = Game2();
	final int? completed = jsonConvert.convert<int>(json['completed']);
	if (completed != null) {
		game2.completed = completed;
	}
	final List<Game2Option>? games = jsonConvert.convertListNotNull<Game2Option>(json['games']);
	if (games != null) {
		game2.games = games;
	}
	return game2;
}

Map<String, dynamic> $Game2ToJson(Game2 entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['completed'] = entity.completed;
	data['games'] =  entity.games.map((v) => v.toJson()).toList();
	return data;
}

Game2Option $Game2OptionFromJson(Map<String, dynamic> json) {
	final Game2Option game2Option = Game2Option();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		game2Option.id = id;
	}
	final String? question = jsonConvert.convert<String>(json['question']);
	if (question != null) {
		game2Option.question = question;
	}
	final int? answer = jsonConvert.convert<int>(json['answer']);
	if (answer != null) {
		game2Option.answer = answer;
	}
	final String? image1 = jsonConvert.convert<String>(json['image1']);
	if (image1 != null) {
		game2Option.image1 = image1;
	}
	final String? image1blur = jsonConvert.convert<String>(json['image1blur']);
	if (image1blur != null) {
		game2Option.image1blur = image1blur;
	}
	final String? image1text = jsonConvert.convert<String>(json['image1text']);
	if (image1text != null) {
		game2Option.image1text = image1text;
	}
	final String? image2 = jsonConvert.convert<String>(json['image2']);
	if (image2 != null) {
		game2Option.image2 = image2;
	}
	final String? image2blur = jsonConvert.convert<String>(json['image2blur']);
	if (image2blur != null) {
		game2Option.image2blur = image2blur;
	}
	final String? image2text = jsonConvert.convert<String>(json['image2text']);
	if (image2text != null) {
		game2Option.image2text = image2text;
	}
	final String? image3 = jsonConvert.convert<String>(json['image3']);
	if (image3 != null) {
		game2Option.image3 = image3;
	}
	final String? image3blur = jsonConvert.convert<String>(json['image3blur']);
	if (image3blur != null) {
		game2Option.image3blur = image3blur;
	}
	final String? image3text = jsonConvert.convert<String>(json['image3text']);
	if (image3text != null) {
		game2Option.image3text = image3text;
	}
	final String? image4 = jsonConvert.convert<String>(json['image4']);
	if (image4 != null) {
		game2Option.image4 = image4;
	}
	final String? image4blur = jsonConvert.convert<String>(json['image4blur']);
	if (image4blur != null) {
		game2Option.image4blur = image4blur;
	}
	final String? image4text = jsonConvert.convert<String>(json['image4text']);
	if (image4text != null) {
		game2Option.image4text = image4text;
	}
	final String? audio = jsonConvert.convert<String>(json['audio']);
	if (audio != null) {
		game2Option.audio = audio;
	}
	final String? audioPath = jsonConvert.convert<String>(json['audioPath']);
	if (audioPath != null) {
		game2Option.audioPath = audioPath;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		game2Option.status = status;
	}
	return game2Option;
}

Map<String, dynamic> $Game2OptionToJson(Game2Option entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['question'] = entity.question;
	data['answer'] = entity.answer;
	data['image1'] = entity.image1;
	data['image1blur'] = entity.image1blur;
	data['image1text'] = entity.image1text;
	data['image2'] = entity.image2;
	data['image2blur'] = entity.image2blur;
	data['image2text'] = entity.image2text;
	data['image3'] = entity.image3;
	data['image3blur'] = entity.image3blur;
	data['image3text'] = entity.image3text;
	data['image4'] = entity.image4;
	data['image4blur'] = entity.image4blur;
	data['image4text'] = entity.image4text;
	data['audio'] = entity.audio;
	data['audioPath'] = entity.audioPath;
	data['status'] = entity.status;
	return data;
}

Game3 $Game3FromJson(Map<String, dynamic> json) {
	final Game3 game3 = Game3();
	final int? completed = jsonConvert.convert<int>(json['completed']);
	if (completed != null) {
		game3.completed = completed;
	}
	final List<Game3Option>? games = jsonConvert.convertListNotNull<Game3Option>(json['games']);
	if (games != null) {
		game3.games = games;
	}
	return game3;
}

Map<String, dynamic> $Game3ToJson(Game3 entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['completed'] = entity.completed;
	data['games'] =  entity.games.map((v) => v.toJson()).toList();
	return data;
}

Game3Option $Game3OptionFromJson(Map<String, dynamic> json) {
	final Game3Option game3Option = Game3Option();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		game3Option.id = id;
	}
	final String? question = jsonConvert.convert<String>(json['question']);
	if (question != null) {
		game3Option.question = question;
	}
	final List<Game3Word>? words = jsonConvert.convertListNotNull<Game3Word>(json['words']);
	if (words != null) {
		game3Option.words = words;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		game3Option.status = status;
	}
	return game3Option;
}

Map<String, dynamic> $Game3OptionToJson(Game3Option entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['question'] = entity.question;
	data['words'] =  entity.words.map((v) => v.toJson()).toList();
	data['status'] = entity.status;
	return data;
}

Game3Word $Game3WordFromJson(Map<String, dynamic> json) {
	final Game3Word game3Word = Game3Word();
	final String? word = jsonConvert.convert<String>(json['word']);
	if (word != null) {
		game3Word.word = word;
	}
	final int? term = jsonConvert.convert<int>(json['term']);
	if (term != null) {
		game3Word.term = term;
	}
	return game3Word;
}

Map<String, dynamic> $Game3WordToJson(Game3Word entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['word'] = entity.word;
	data['term'] = entity.term;
	return data;
}

Game4 $Game4FromJson(Map<String, dynamic> json) {
	final Game4 game4 = Game4();
	final int? completed = jsonConvert.convert<int>(json['completed']);
	if (completed != null) {
		game4.completed = completed;
	}
	final List<Game4Option>? games = jsonConvert.convertListNotNull<Game4Option>(json['games']);
	if (games != null) {
		game4.games = games;
	}
	return game4;
}

Map<String, dynamic> $Game4ToJson(Game4 entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['completed'] = entity.completed;
	data['games'] =  entity.games.map((v) => v.toJson()).toList();
	return data;
}

Game4Option $Game4OptionFromJson(Map<String, dynamic> json) {
	final Game4Option game4Option = Game4Option();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		game4Option.id = id;
	}
	final String? question = jsonConvert.convert<String>(json['question']);
	if (question != null) {
		game4Option.question = question;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		game4Option.status = status;
	}
	return game4Option;
}

Map<String, dynamic> $Game4OptionToJson(Game4Option entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['question'] = entity.question;
	data['status'] = entity.status;
	return data;
}