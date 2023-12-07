// ignore: file_names
import 'dart:async';

class ManagerStreamBuilder {
  List<StreamController<double>> listStreamBuilder = [];
  registerStreamBuilder(StreamController<double> streamController) {
    listStreamBuilder.add(streamController);
  }

  disposeStreams() {
    for (var stream in listStreamBuilder) {
      stream.close();
    }
    listStreamBuilder = [];
  }
}
