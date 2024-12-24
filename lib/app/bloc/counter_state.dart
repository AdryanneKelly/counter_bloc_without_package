// lib/app/bloc/counter_state.dart

abstract class CounterState {}

class CounterInitial extends CounterState {
  final int counterValue;

  CounterInitial(this.counterValue);
}

class CounterValue extends CounterState {
  final int counterValue;

  CounterValue(this.counterValue); 
}

class CounterError extends CounterState {
  final String message;

  CounterError(this.message); 
}