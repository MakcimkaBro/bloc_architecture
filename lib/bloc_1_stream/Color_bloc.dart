// https://youtu.be/Qjx8amKph7s?si=ehNGgCkMlfi5zcpW

import 'dart:async';
import 'package:flutter/material.dart';

enum ColorEvent{event_red, event_green} // содержит события

class ColorBloc{ // Класс блока
  Color _color = Colors.red; // значение цвета по дефолту

  final _inputEventController = StreamController<ColorEvent>(); // стрим контролер (входа). Тип: КолорЕвент
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink; // гетер для входного потока, возвращает _инпутЕвентКонтроллер с параметром синк
  // синк - это поток, куда пользователь добавляет данные.

  final _outputStateController = StreamController<Color>(); // стрим контроллер для нового состояния (выход), тип: Колор.
  Stream<Color> get outputStateStream => _outputStateController.stream; // геттер для выходного потока, возвращает _оутпутЕвентКонтроллер с параметром стрим
  // стрим - это выходной поток.

  // Метод класса (приватный, нечего не вопрошает)
  void _mapEventToState(ColorEvent event) { // принимает параметр евент.
    if(event == ColorEvent.event_red) _color = Colors.red;
    else if(event == ColorEvent.event_green) _color = Colors.green;
    else throw Exception('Wrong Event Type'); // Отлавливаем ошибку (Неправильный тип события)

    _outputStateController.sink.add(_color); // Добавляем новое состояние (_color) в выходной поток
  }

  // Конструктор для прослушивания состояния
  ColorBloc(){
    _inputEventController.stream.listen(_mapEventToState);
  }

  // После окончания работы потоков закрываем их
  void dispose(){
    _inputEventController.close();
    _outputStateController.close();
  }
}