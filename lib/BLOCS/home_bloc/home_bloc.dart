

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/home_bloc/home.dart';
import 'package:sparklestar/SRC/REPOSITORIES/repositories.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ItemRepository _itemRepository;
  StreamSubscription _streamSubscription;

  HomeBloc(ItemRepository itemRepository)
  : assert(itemRepository != null),
  _itemRepository = itemRepository,
  super(HomeInitial());
  
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is LoadAllData){
      yield* _mapLoadAllDatatoState();
    } 
    if(event is DataUpdated){
      yield* _mapDataUpdatedtoState(event);
    }
  }

  Stream<HomeState> _mapLoadAllDatatoState() async* {
    yield HomeLoading();
    try {
      _streamSubscription?.cancel();
      _streamSubscription = _itemRepository.loadItem().asStream().listen((items) { 
        print('items list: $items');
        add(DataUpdated(items));
      });
    } catch (error){
      yield FetchError(error: 'Unknown error occured');
    }
  } 

  Stream<HomeState> _mapDataUpdatedtoState(DataUpdated event) async* {
    yield DataLoaded(event.item);
  }
  
}