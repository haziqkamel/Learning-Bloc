import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_bloc/constants/enums.dart';
import 'package:learning_bloc/logic/cubit/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  // final InternetCubit internetCubit;
  // StreamSubscription internetStreamSubscription;

  CounterCubit() : super(CounterState(counterValue: 0)) {}

  // // StreamSubscription to store the connection type
  // // internetCubit.stream.listen keep on listening the changes made for ConnectionType
  // StreamSubscription<InternetState> monitorInternetCubit() {
  //   return internetStreamSubscription =
  //       internetCubit.stream.listen((internetState) {
  //     if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectionType.Wifi) {
  //       increment();
  //     } else if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectionType.Mobile) {
  //       decrement();
  //     }
  //   });
  // }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  // @override
  // Future<void> close() {
  //   internetStreamSubscription.cancel();
  //   return super.close();
  // }
}
