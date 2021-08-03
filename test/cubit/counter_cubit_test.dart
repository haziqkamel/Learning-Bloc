import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_bloc/logic/cubit/counter_cubit.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
        'the initial state for the COunterCubit is CounterState(counterValue: 0)',
        () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });

    blocTest(
        'the cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called',
        build: () => counterCubit,
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest(
        'the cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.increment() function is called',
        build: () => counterCubit,
        act: (cubit) => cubit.decremented(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
