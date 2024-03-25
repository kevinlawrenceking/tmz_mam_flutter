import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/user_collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class UserCollectionsBloc extends Bloc<BlocEvent, BlocState> {
  final IUserCollectionDataSource userCollectionDataSource;

  UserCollectionsBloc({
    required this.userCollectionDataSource,
  }) : super(InitialState()) {
    on<LoadCollectionsEvent>(_loadCollectionsEvent);
    on<RemoveCollectionEvent>(_removeCollectionEvent);
  }

  Future<void> _loadCollectionsEvent(
    LoadCollectionsEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(CollectionsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await userCollectionDataSource.getCollectionList();

    result.fold(
      (failure) => emit(LoadCollectionsFailureState(failure)),
      (collections) => emit(
        CollectionsLoadedState(
          collections: collections,
        ),
      ),
    );
  }

  Future<void> _removeCollectionEvent(
    RemoveCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await userCollectionDataSource.removeCollection(
      collectionID: event.collectionID,
    );

    await result.fold(
      (failure) {},
      (_) async {
        final result = await userCollectionDataSource.getCollectionList();

        result.fold(
          (failure) => emit(LoadCollectionsFailureState(failure)),
          (collections) => emit(
            CollectionsLoadedState(
              collections: collections,
            ),
          ),
        );
      },
    );
  }
}
