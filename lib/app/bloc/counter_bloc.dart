import 'dart:async';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc {
  final _stateController = StreamController<CounterState>(); // Controlador para o estado do contador.
  final _eventController = StreamController<CounterEvent>(); // Controlador para eventos.

  int _counter = 0; // Valor atual do contador.

  CounterBloc() {
    // Escuta os eventos e processa as mudanças de estado.
    _eventController.stream.listen(_mapEventToState);
    // Adiciona o estado inicial ao fluxo.
    _stateController.add(CounterInitial(_counter));
  }

  Stream<CounterState> get state => _stateController.stream; // Saída do estado do contador.

  // Método para adicionar o evento de incremento.
  void increment() {
    _eventController.sink.add(IncrementEvent());
  }

  // Verifica o evento e atualiza o estado do contador.
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
      _stateController.add(CounterValue(_counter));
    }
  }

  // Libera recursos ao descartar a página.
  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}