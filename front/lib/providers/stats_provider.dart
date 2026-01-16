import 'package:flutter/foundation.dart';

import '../data/repositories/stats_repository.dart';

class StatsProvider extends ChangeNotifier {
  StatsProvider({required StatsRepository repository})
    : _repository = repository;

  final StatsRepository _repository;

  StatsRepository get repository => _repository;
}
