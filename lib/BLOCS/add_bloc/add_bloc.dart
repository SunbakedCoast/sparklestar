import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/add_bloc/add.dart';
import 'package:sparklestar/SRC/REPOSITORIES/repositories.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  ItemRepository _itemRepository;

  AddBloc(ItemRepository itemRepository)
      : assert(itemRepository != null),
        _itemRepository = itemRepository,
        super(AddInitialState());

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    if(event is AddBtnPressed){
      yield* _mapAddBtnPressedtoState(event);
    }
  }

  Stream<AddState> _mapAddBtnPressedtoState(AddBtnPressed event) async* {
    yield AddBtnStateLoading();
    await _itemRepository.add(event.item);
    yield AddBtnStateDone();
  }
}
