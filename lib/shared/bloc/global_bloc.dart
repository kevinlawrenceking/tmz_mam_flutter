import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'global_bloc_event.dart';
part 'global_bloc_state.dart';

class GlobalBloc extends Bloc<GlobalBlocEvent, GlobalBlocState> {
  GlobalBloc() : super(InitialState()) {
    on<DownloadSelectedAssetsEvent>(_downloadSelectedAssetsEvent);
  }

  Future<void> _downloadSelectedAssetsEvent(
    DownloadSelectedAssetsEvent event,
    Emitter<GlobalBlocState> emit,
  ) async {
    emit(DownloadSelectedAssetsState());
    emit(ResetState());
  }
}
