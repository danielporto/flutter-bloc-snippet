import 'dart:async';

import 'home_state.dart';
import 'home_event.dart';

class HomeModel {
  final StreamController<HomeState> _stateController =
      StreamController<HomeState>();
  List<String> _listItems;

  Stream<HomeState> get homeState => _stateController.stream;

  void dispatch(HomeEvent event){
    print("Event being dispatched: $event");
    if (event is FetchData){
      _getListData(hasData: event.hasData, hasError: event.hasError);
    }
  }

  Future _getListData({bool hasError: false, bool hasData: true}) async {
    _stateController.add(BusyHomeState());
    await Future.delayed(Duration(seconds: 2));

    if (hasError) {
      return _stateController
          .addError("An error occurred while fetching the data");
    }

    if (!hasData) {
      return _stateController.add(DataFetchedHomeState(data: List<String>()));
    }

    _listItems = List.generate(15, (index) => "$index title");
    _stateController.add(DataFetchedHomeState(data: _listItems));
  }
}
