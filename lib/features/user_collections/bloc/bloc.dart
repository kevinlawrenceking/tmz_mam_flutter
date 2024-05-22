import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/data/sources/user_collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class UserCollectionsBloc extends Bloc<BlocEvent, BlocState> {
  final ICollectionDataSource collectionDataSource;
  final IUserCollectionDataSource userCollectionDataSource;

  UserCollectionsBloc({
    required this.collectionDataSource,
    required this.userCollectionDataSource,
  }) : super(InitialState()) {
    on<AddCollectionToFavoritesEvent>(_addCollectionToFavoritesEvent);
    on<CreateCollectionEvent>(_createCollectionEvent);
    on<LoadCollectionsEvent>(_loadCollectionsEvent);
    on<RemoveCollectionFromFavoritesEvent>(_removeCollectionFromFavoritesEvent);
  }

  Future<void> _addCollectionToFavoritesEvent(
    AddCollectionToFavoritesEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await userCollectionDataSource.addCollection(
      collectionID: event.collectionID,
    );

    result.fold(
      (failure) => emit(AddCollectionToFavoritesFailureState(failure)),
      (_) => emit(AddCollectionToFavoritesSuccessState()),
    );

    if (result.isLeft()) {
      return;
    }

    emit(CollectionsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final fetchResult = await userCollectionDataSource.getCollectionList();

    fetchResult.fold(
      (failure) => emit(LoadCollectionsFailureState(failure)),
      (collections) => emit(CollectionsLoadedState(collections)),
    );
  }

  Future<void> _createCollectionEvent(
    CreateCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await collectionDataSource.createCollection(
      isPrivate: event.isPrivate,
      autoClear: event.autoClear,
      name: event.name,
      description: event.description,
    );

    final collection = result.fold(
      (failure) {
        emit(CreateCollectionFailureState(failure));
        return null;
      },
      (collection) => collection,
    );

    if (collection == null) {
      return;
    }

    final addResult = await userCollectionDataSource.addCollection(
      collectionID: collection.id,
    );

    addResult.fold(
      (failure) => emit(AddCollectionToFavoritesFailureState(failure)),
      (_) => emit(CreateCollectionSuccessState()),
    );

    if (addResult.isLeft()) {
      return;
    }

    final fetchResult = await userCollectionDataSource.getCollectionList();

    fetchResult.fold(
      (failure) => emit(LoadCollectionsFailureState(failure)),
      (collections) => emit(CollectionsLoadedState(collections)),
    );
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
      (collections) => emit(CollectionsLoadedState(collections)),
    );
  }

  Future<void> _removeCollectionFromFavoritesEvent(
    RemoveCollectionFromFavoritesEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await userCollectionDataSource.removeCollection(
      collectionID: event.collectionID,
    );

    result.fold(
      (failure) => emit(RemoveCollectionFromFavoritesFailureState(failure)),
      (_) => emit(RemoveCollectionFromFavoritesSuccessState()),
    );

    if (result.isLeft()) {
      return;
    }

    emit(CollectionsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final fetchResult = await userCollectionDataSource.getCollectionList();

    fetchResult.fold(
      (failure) => emit(LoadCollectionsFailureState(failure)),
      (collections) => emit(CollectionsLoadedState(collections)),
    );
  }
}
