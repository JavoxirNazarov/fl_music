import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerEvent>((event, emit) {});
  }
}
