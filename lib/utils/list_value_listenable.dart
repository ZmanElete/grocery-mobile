import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final logger = Logger('ListValueListenable');

class ListValueListenable<T> extends ListBase<T> with ChangeNotifier implements ValueListenable<List<T>> {
  List<T> _list;

  ListValueListenable(this._list);

  @override
  List<T> get value => this;
  set value(List<T> list) {
    logger.warning('Notify Listeners value');
    notifyListeners();
    _list = list;
  }

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    if (newLength != length) {
      logger.warning('Notify Listeners length');
      notifyListeners();
      _list.length = newLength;
    }
  }

  @override
  T operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, T value) {
    logger.warning('Notify Listeners []=');
    notifyListeners();
    _list[index] = value;
  }
}
