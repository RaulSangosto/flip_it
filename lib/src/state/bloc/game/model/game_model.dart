import 'card_collection.dart';

enum GameStatus { win, lose, playing }

final specialCards = [0, -1, -2, -2, -3, -3, -4, -4, -5];

class GameController {
  final GameStatus status;
  final List<int> cards;
  final List<CardCollection> collections;
  final List<int> hand;
  final int maxCardNumber;
  final int decksNumber;
  final int handSize;

  const GameController(
    this.cards,
    this.collections,
    this.hand,
    this.status,
    this.maxCardNumber,
    this.decksNumber,
    this.handSize,
  );

  factory GameController.initial() {
    int maxCardNumber = 80;
    return GameController(
      _generateCards(maxCardNumber, 2),
      [
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
      ],
      [],
      GameStatus.playing,
      maxCardNumber,
      2,
      8,
    );
  }

  factory GameController.fromSettings({
    required int maxCardNumber,
    required int decksNumber,
    required int handSize,
  }) {
    return GameController(
      _generateCards(maxCardNumber, decksNumber),
      [
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
      ],
      [],
      GameStatus.playing,
      maxCardNumber,
      decksNumber,
      handSize,
    );
  }

  GameController copyWith({
    GameStatus? status,
    List<int>? cards,
    List<CardCollection>? collections,
    List<int>? hand,
    int? maxCardNumber,
    int? decksNumber,
    int? handSize,
  }) {
    return GameController(
      cards ?? this.cards,
      collections ?? this.collections,
      hand ?? this.hand,
      status ?? this.status,
      maxCardNumber ?? this.maxCardNumber,
      decksNumber ?? this.decksNumber,
      handSize ?? this.handSize,
    );
  }

  factory GameController.fromJson(Map<String, dynamic> json) {
    List<CardCollection> collections = [];
    for (var item in json["collections"]) {
      collections.add(CardCollection.fromJson(item));
    }
    return GameController(
      json["cards"],
      collections,
      json["hand"],
      GameStatus.values.elementAt(json["status"]),
      json["maxCardNumber"],
      json["decksNumber"],
      json["handSize"],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json["status"] = status.index;
    json["cards"] = cards;
    json["collections"] =
        collections.map((collection) => collection.toJson()).toList();
    json["hand"] = hand;
    json["maxCardNumber"] = maxCardNumber;
    json["decksNumber"] = decksNumber;
    json["handSize"] = handSize;
    return json;
  }

  bool win() {
    return status == GameStatus.win;
  }

  static List<int> _generateCards(int maxCardNumber, int decksNumber) {
    return [
      ...[
        for (var i = 2; i < maxCardNumber; i++)
          for (var j = 1; j <= decksNumber; j++) i
      ],
      ...specialCards,
    ];
  }
}
