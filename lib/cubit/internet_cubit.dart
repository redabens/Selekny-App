import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetStatus> {
  InternetCubit()
      : super(const InternetStatus(ConnectivityStatus.disconnected));

  final Connectivity _connectivity = Connectivity();

  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    emit(InternetStatus(connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi
        ? ConnectivityStatus.connected
        : ConnectivityStatus.disconnected)); // Extract status
  }

  late StreamSubscription<ConnectivityResult>
      subscription; // Modification du type de la variable

  void trackConnectivityChange() {
    subscription = _connectivity.onConnectivityChanged.listen((result) {
      emit(InternetStatus(result == ConnectivityResult.none
          ? ConnectivityStatus.disconnected
          : ConnectivityStatus.connected));
    });
  }

  @override
  Future<void> close() async {
    subscription.cancel(); // Ensure proper subscription cancellation
    return super.close();
  }
}
