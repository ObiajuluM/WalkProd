import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/backend/requests.dart';
import 'package:walkit/modules/models/backend_model.dart';

class BackendUserProvider extends StateNotifier<WalkUserBackend> {
  BackendUserProvider() : super(WalkUserBackend());

  Future<void> getData() async {
    final user = await getUser();
    state = user;
  }
}

final backendUserProvider =
    StateNotifierProvider<BackendUserProvider, WalkUserBackend>((ref) {
  return BackendUserProvider();
});
