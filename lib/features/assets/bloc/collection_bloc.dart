import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

part 'collection_bloc_event.dart';
part 'collection_bloc_state.dart';

class CollectionBloc extends Bloc<CollectionBlocEvent, CollectionBlocState> {
  final ICollectionDataSource collectionDataSource;

  CollectionBloc({
    required this.collectionDataSource,
  }) : super(InitialState()) {
    on<LoadCollectionEvent>(_loadCollectionEvent);
  }

  Future<void> _loadCollectionEvent(
    LoadCollectionEvent event,
    Emitter<CollectionBlocState> emit,
  ) async {
    emit(CollectionLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await collectionDataSource.getCollection(
      collectionID: event.collectionID,
    );

    result.fold(
      (failure) => emit(LoadCollectionFailureState(failure)),
      (collection) => emit(
        CollectionLoadedState(
          model: collection,
        ),
      ),
    );
  }
}
