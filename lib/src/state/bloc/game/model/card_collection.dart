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

  CardCollection(this.direction, this.maxCardNumber) {
    if (direction == Direction.up) {
      initialCard = 1;
    } else {
      initialCard = maxCardNumber;
    }
    cards = [initialCard];
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
    return (last < card || last == card - 10 || last == card + 10);
  }

  bool _isValidCardPlaceDown(int card) {
    final last = cards.last;
    return (last > card || last == card - 10 || last == card + 10);
  }

  bool isValidCardPlace(int card) {
    if (card <= 0) return isValidSpecialCardPlace(card);
    if (direction == Direction.up) {
      return _isValidCardPlaceUp(card);
    } else {
      return _isValidCardPlaceDown(card);
    }
  }

  bool isValidSpecialCardPlace(int card) {
    if (card == reduceCard) {
      var last = cards.last;
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
