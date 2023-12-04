import 'package:flutter/material.dart';

import 'Color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc(); // Добавляем блок в стейт

  @override
  void dispose() {
    // Что бы избежать утечки памяти
    _bloc.dispose(); // закрываем все потоки блока
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloC Stream'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder( // Оборачиваем в Стрим билдер
          stream: _bloc.outputStateStream, // Указываем выходной поток с новыми данными (геттер)
          initialData: Colors.red, // цвет по дефолту
          builder: (context, snapshot) { // данные получаем через снапшот (имутабельный, асинк.снапшот)
            return AnimatedContainer(
              height: 100,
              width: 100,
              color: snapshot.data, // передаем через снапшот дату
              duration: Duration(milliseconds: 500),
            );
          }
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
            _bloc.inputEventSink.add(ColorEvent.event_red); // добавляем событие
          },
          backgroundColor: Colors.red,),
        SizedBox(
          width: 20
        ),
          FloatingActionButton(onPressed: (){
            _bloc.inputEventSink.add(ColorEvent.event_green); // добавляем событие
          },
            backgroundColor: Colors.green,),

        ],
      ),
    );
  }
}
