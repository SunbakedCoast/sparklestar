import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/home_bloc/home.dart';
import 'package:sparklestar/SRC/REPOSITORIES/repositories.dart';
import 'package:sparklestar/WIDGETS/widgets.dart';
import 'package:sparklestar/pages.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sparkle'),
      ),
      floatingActionButton: OpenContainer(
        closedBuilder: (_, openContainer){
          return FloatingActionButton(
            elevation: 8.0,
            onPressed: openContainer,
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add,
            color: Colors.white),
          );
        },
        openColor: Theme.of(context).accentColor,
        closedElevation: 5.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)),
          closedColor: Theme.of(context).accentColor,
          openBuilder: (_, closeContainer){
            return Add();
          }
      ),
      body: BlocProvider<HomeBloc>(
        create: (context){
          final _itemRepository = RepositoryProvider.of<ItemRepository>(context);
          return HomeBloc(_itemRepository)..add(LoadAllData());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state){
            if(state is DataLoaded){
              print('home_state is : ${state.toString()}');
              final _items = state.item;
              return ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: [
                  Gridview(state: state,
                  items: _items,)
                ],
              );
            }
          }
        )
      )
    );
  }
}
