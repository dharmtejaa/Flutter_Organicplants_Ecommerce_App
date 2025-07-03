import 'package:flutter/material.dart';

class CarouselProvider with ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
