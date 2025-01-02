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
    _stateController.add(CounterState(_counter));
  }
  
  // Saída do estado do contador.
  Stream<CounterState> get state => _stateController.stream; 

  // Método para adicionar o evento de incremento.
  void increment() {
    _eventController.sink.add(IncrementEvent());
  }

  // Identifica o evento e atualiza o estado do contador.
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
      _stateController.add(CounterState(_counter));
    }
  }

  // Fecha os controladores ao descartar a página para liberar recursos.
  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}