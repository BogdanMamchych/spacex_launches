import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/launch.dart';
import '../models/rocket.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final launchesListProvider = FutureProvider.autoDispose<List<Launch>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchAllLaunches();
});

final rocketsListProvider = FutureProvider.autoDispose<List<Rocket>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchAllRockets();
});

final currentIndexProvider = StateProvider<int>((ref) => 0);
