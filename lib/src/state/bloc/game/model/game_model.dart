import 'card_collection.dart';

enum GameStatus { win, lose, playing }

final specialCards = [0, -1, -2, -2, -3, -3, -4, -4, -5];

class GameController {
  final GameStatus status;
  final List<int> cards;
  final List<CardCollection> collections;
  final List<int> hand;

  const GameController(
    this.cards,
    this.collections,
    this.hand,
    this.status,
  );

  factory GameController.initial(int maxCardNumber) {
    return GameController(
      [
        ...[
          for (var i = 2; i < maxCardNumber; i++)
            for (var j = 1; j <= 2; j++) i
        ],
        ...specialCards,
      ],
      [
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.up, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
        CardCollection(Direction.down, maxCardNumber),
      ],
      [],
      GameStatus.playing,
    );
  }

  GameController copyWith({
    GameStatus? status,
    List<int>? cards,
    List<CardCollection>? collections,
    List<int>? hand,
  }) {
    return GameController(
      cards ?? this.cards,
      collections ?? this.collections,
      hand ?? this.hand,
      status ?? this.status,
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
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json["status"] = status.index;
    json["cards"] = cards;
    json["collections"] =
        collections.map((collection) => collection.toJson()).toList();
    json["hand"] = hand;
    return json;
  }

  bool win() {
    return status == GameStatus.win;
  }
}
