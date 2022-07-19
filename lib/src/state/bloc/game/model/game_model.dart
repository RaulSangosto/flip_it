import 'card_collection.dart';

enum GameStatus { win, lose, playing }

enum SpecialCardsAmount { none, minimal, normal, extra }

class GameController {
  final GameStatus status;
  final List<int> cards;
  final List<CardCollection> collections;
  final List<int> hand;
  final int maxCardNumber;
  final int decksNumber;
  final int handSize;
  final SpecialCardsAmount specialCardsAmount;

  const GameController(
    this.cards,
    this.collections,
    this.hand,
    this.status,
    this.maxCardNumber,
    this.decksNumber,
    this.handSize,
    this.specialCardsAmount,
  );

  factory GameController.initial() {
    int maxCardNumber = 80;
    int decksNumber = 2;
    SpecialCardsAmount specialCardsAmount = SpecialCardsAmount.normal;

    return GameController(
      _generateCards(maxCardNumber, decksNumber, specialCardsAmount),
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
      8,
      specialCardsAmount,
    );
  }

  factory GameController.fromSettings({
    required int maxCardNumber,
    required int decksNumber,
    required int handSize,
    required SpecialCardsAmount specialCardsAmount,
  }) {
    return GameController(
      _generateCards(maxCardNumber, decksNumber, specialCardsAmount),
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
      specialCardsAmount,
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
    SpecialCardsAmount? specialCardsAmount,
  }) {
    return GameController(
      cards ?? this.cards,
      collections ?? this.collections,
      hand ?? this.hand,
      status ?? this.status,
      maxCardNumber ?? this.maxCardNumber,
      decksNumber ?? this.decksNumber,
      handSize ?? this.handSize,
      specialCardsAmount ?? this.specialCardsAmount,
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
      SpecialCardsAmount.values.elementAt(json["specialCardsAmount"]),
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
    json["specialCardsAmount"] = specialCardsAmount.index;
    return json;
  }

  bool win() {
    return status == GameStatus.win;
  }

  static List<int> _generateCards(int maxCardNumber, int decksNumber,
      SpecialCardsAmount specialCardsAmount) {
    return [
      ...[
        for (var i = 2; i < maxCardNumber; i++)
          for (var j = 1; j <= decksNumber; j++) i
      ],
      ..._generateSpecialCards(specialCardsAmount),
    ];
  }

  static List<int> _generateSpecialCards(
      SpecialCardsAmount specialCardsAmount) {
    switch (specialCardsAmount) {
      case SpecialCardsAmount.none:
        return [];
      case SpecialCardsAmount.minimal:
        return [0, -1, -2, -3, -4, -5];
      case SpecialCardsAmount.normal:
        return [0, -1, -2, -2, -3, -3, -4, -4, -5];
      case SpecialCardsAmount.extra:
        return [
          ...[0, -1, -2, -2, -3, -3, -4, -4, -5],
          ...[0, -1, -2, -2, -3, -3, -4, -4, -5]
        ];
      default:
        return [0, -1, -2, -3, -4, -5];
    }
  }
}
