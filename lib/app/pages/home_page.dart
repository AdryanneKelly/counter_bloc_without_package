import 'package:flutter/material.dart';

import '../bloc/counter_bloc.dart';
import '../bloc/counter_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterBloc _counterBloc = CounterBloc(); // Instancia o BLoC.

  @override
  void dispose() {
    _counterBloc.dispose(); // Libera recursos do BLoC ao descartar a página.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador BLoC - Sem Package', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      body: Center(
        child: StreamBuilder<CounterState>(
          stream: _counterBloc.state, // Escuta as mudanças no estado do contador.
          initialData: CounterInitial(0), // Valor inicial do contador.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data is CounterValue) {
                // Verifica se o estado é CounterValue
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pressione o botão para incrementar o contador.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${(snapshot.data as CounterValue).counterValue}', // Exibe o valor atual do contador.
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else if (snapshot.data is CounterInitial) {
                // Verifica se o estado é CounterInitial
                return const Text(
                  'Contador inicializado.\nPressione o botão para começar!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                );
              }
            }
            return const CircularProgressIndicator(); // Exibe um indicador de carregamento se não houver dados.
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counterBloc.increment, // Chama o método para incrementar o contador.
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}