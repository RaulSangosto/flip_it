import 'dart:math';

enum Direction { up, down }

const int changeDirectionCard = -1;
const int suffleCard = -2;
const int deleteCard = -3;
const int reduceCard = -4;
const int interchangeCard = -5;

class CardCollection {
  Direction direction;
  late int initialCard;
  late int maxCardNumber;
  List<int> cards = [];

  CardCollection.complete(
    this.direction,
    this.initialCard,
    this.maxCardNumber,
    this.cards,
  );

  CardCollection(this.direction, this.maxCardNumber) {
    if (direction == Direction.up) {
      initialCard = 1;
    } else {
      initialCard = maxCardNumber;
    }
    cards = [initialCard];
  }

  factory CardCollection.fromJson(Map<String, dynamic> json) {
    return CardCollection.complete(
      Direction.values.elementAt(json["direction"]),
      json["initialCard"],
      json["maxCardNumber"],
      json["cards"],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json["direction"] = direction.index;
    json["initialCard"] = initialCard;
    json["maxCardNumber"] = maxCardNumber;
    json["cards"] = cards;
    return json;
  }

  bool place(int card) {
    if (card < 0) {
      placeSpecialCards(card);
      return true;
    } else if (card == 0) {
      cards = [initialCard];
      return true;
    } else if (isValidCardPlace(card)) {
      cards.add(card);
      return true;
    }
    return false;
  }

  bool _isValidCardPlaceUp(int card) {
    final last = cards.last;
    return (last < card || isImproveCard(card));
  }

  bool _isValidCardPlaceDown(int card) {
    final last = cards.last;
    return (last > card || isImproveCard(card));
  }

  bool isImproveCard(int card) {
    final last = cards.last;
    if (direction == Direction.up && last == card + 10) {
      return true;
    } else if (direction == Direction.down && last == card - 10) {
      return true;
    }
    return false;
  }

  bool isValidCardPlace(int card) {
    if (isSpecialCard(card)) return isValidSpecialCardPlace(card);
    if (direction == Direction.up) {
      return _isValidCardPlaceUp(card);
    } else {
      return _isValidCardPlaceDown(card);
    }
  }

  bool isSpecialCard(int card) {
    return card <= 0;
  }

  bool isValidSpecialCardPlace(int card) {
    var last = cards.last;
    if (cards.length <= 1) {
      return false;
    }
    if (card == reduceCard) {
      if (last > 20 && last < maxCardNumber - 19) {
        return true;
      } else if (direction == Direction.up && last > 21) {
        return true;
      } else if (direction == Direction.down && last < maxCardNumber - 20) {
        return true;
      } else {
        return false;
      }
    } else if (card == interchangeCard) {
      if (cards.isEmpty || cards.last == 1 || cards.last == maxCardNumber) {
        return false;
      }
    }
    return true;
  }

  void placeSpecialCards(int card) {
    switch (card) {
      case changeDirectionCard:
        changeDirection();
        break;
      case suffleCard:
        suffleCards();
        break;
      case deleteCard:
        removeOneCard();
        break;
      case reduceCard:
        reduceLastCard();
        break;
      default:
    }
  }

  void changeDirection() {
    if (direction == Direction.up) {
      direction = Direction.down;
      initialCard = maxCardNumber;
    } else {
      direction = Direction.up;
      initialCard = 1;
    }
  }

  void suffleCards() {
    final last = cards.last;
    cards.removeLast();
    cards.shuffle();
    final index = Random().nextInt(cards.length);
    cards.insert(index, last);
  }

  void removeOneCard() {
    cards.removeLast();
  }

  void reduceLastCard() {
    var last = cards.last;
    last -= (direction == Direction.up ? 20 : -20);
    cards.removeLast();
    cards.add(last);
  }

  int takeCard() {
    var last = cards.last;
    cards.removeLast();
    return last;
  }
}
