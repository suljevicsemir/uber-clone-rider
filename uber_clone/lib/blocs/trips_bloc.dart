import 'dart:async';



class TripsBloc {

  bool clicked = false;

  final StreamController<int> _tripsController = StreamController<int>();

  Sink<int> get tripsSink => _tripsController.sink;
  Stream<int> get tripsController => _tripsController.stream;


  final _eventController = StreamController<int>();
  Sink<int> get eventSink => _eventController.sink;
  Stream<int> get eventStream => _eventController.stream;


  TripsBloc() {
    eventStream.listen((event) {

    });
  }









  void disposeStreams() {
    _tripsController.close();
    _eventController.close();
  }
}