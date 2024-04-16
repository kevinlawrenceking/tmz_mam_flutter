import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/models/picklist_agency.dart';
import 'package:tmz_damz/data/models/picklist_celebrity.dart';
import 'package:tmz_damz/data/models/picklist_keyword.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/data/sources/picklist_agency.dart';
import 'package:tmz_damz/data/sources/picklist_celebrity.dart';
import 'package:tmz_damz/data/sources/picklist_keyword.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class AssetDetailsBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetDataSource assetDataSource;
  final ICollectionDataSource collectionDataSource;
  final IPicklistAgencyDataSource picklistAgencyDataSource;
  final IPicklistCelebrityDataSource picklistCelebrityDataSource;
  final IPicklistKeywordDataSource picklistKeywordDataSource;

  AssetDetailsBloc({
    required this.assetDataSource,
    required this.collectionDataSource,
    required this.picklistAgencyDataSource,
    required this.picklistCelebrityDataSource,
    required this.picklistKeywordDataSource,
  }) : super(InitialState()) {
    on<AddToCollectionEvent>(_addToCollectionEvent);
    on<LoadAssetDetailsEvent>(_loadAssetDetailsEvent);
    on<ReloadAssetDetailsEvent>(_reloadAssetDetailsEvent);
    on<RetrieveAgencyPicklistEvent>(_retrieveAgencyPicklistEvent);
    on<RetrieveCelebrityPicklistEvent>(_retrieveCelebrityPicklistEvent);
    on<RetrieveKeywordPicklistEvent>(_retrieveKeywordPicklistEvent);
    on<SaveMetadataEvent>(_saveMetadataEvent);
  }

  Future<void> _addToCollectionEvent(
    AddToCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await collectionDataSource.addAssetToCollection(
      collectionID: event.collectionID,
      assetID: event.assetID,
    );

    result.fold(
      (failure) => emit(AddToCollectionFailureState(failure)),
      (_) => emit(AddToCollectionSuccessState()),
    );
  }

  Future<void> _loadAssetDetailsEvent(
    LoadAssetDetailsEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(AssetDetailsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetDataSource.getAssetDetails(
      assetID: event.assetID,
    );

    result.fold(
      (failure) => emit(AssetDetailsFailureState(failure)),
      (details) => emit(
        AssetDetailsLoadedState(
          model: details,
        ),
      ),
    );
  }

  Future<void> _reloadAssetDetailsEvent(
    ReloadAssetDetailsEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(
      AssetDetailsReloadingState(
        model: event.model,
      ),
    );

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetDataSource.getAssetDetails(
      assetID: event.model.id,
    );

    result.fold(
      (failure) => emit(AssetDetailsFailureState(failure)),
      (details) => emit(
        AssetDetailsLoadedState(
          model: details,
        ),
      ),
    );
  }

  Future<void> _retrieveAgencyPicklistEvent(
    RetrieveAgencyPicklistEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (event.searchTerm.length < 2) {
      emit(
        AgencyPicklistState(
          picklist: const [],
        ),
      );
      return;
    }

    final result = await picklistAgencyDataSource.getAgencyList(
      searchTerm: event.searchTerm,
      offset: 0,
      limit: 100,
    );

    return result.fold(
      (_) => emit(
        AgencyPicklistState(
          picklist: const [],
        ),
      ),
      (results) => emit(
        AgencyPicklistState(
          picklist: results.agencies,
        ),
      ),
    );
  }

  Future<void> _retrieveCelebrityPicklistEvent(
    RetrieveCelebrityPicklistEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (event.searchTerm.length < 2) {
      emit(
        CelebrityPicklistState(
          picklist: const [],
        ),
      );
      return;
    }

    final result = await picklistCelebrityDataSource.getCelebrityList(
      searchTerm: event.searchTerm,
      offset: 0,
      limit: 100,
    );

    return result.fold(
      (_) => emit(
        CelebrityPicklistState(
          picklist: const [],
        ),
      ),
      (results) => emit(
        CelebrityPicklistState(
          picklist: results.celebrities,
        ),
      ),
    );
  }

  Future<void> _retrieveKeywordPicklistEvent(
    RetrieveKeywordPicklistEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (event.searchTerm.length < 2) {
      emit(
        KeywordPicklistState(
          picklist: const [],
        ),
      );
      return;
    }

    final result = await picklistKeywordDataSource.getKeywordList(
      searchTerm: event.searchTerm,
      offset: 0,
      limit: 100,
    );

    return result.fold(
      (_) => emit(
        KeywordPicklistState(
          picklist: const [],
        ),
      ),
      (results) => emit(
        KeywordPicklistState(
          picklist: results.keywords,
        ),
      ),
    );
  }

  Future<void> _saveMetadataEvent(
    SaveMetadataEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(UpdatingMetadataState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetDataSource.updateAssetMetadata(
      assetID: event.assetID,
      headline: event.headline,
      metadata: event.metadata,
    );

    return result.fold(
      (failure) => emit(UpdateMetadataFailureState(failure)),
      (result) async {
        final detailsResult = await assetDataSource.getAssetDetails(
          assetID: event.assetID,
        );

        emit(
          MetadataUpdatedState(
            headline: result.headline,
            metadata: result.metadata,
          ),
        );

        detailsResult.fold(
          (failure) => emit(AssetDetailsFailureState(failure)),
          (details) => emit(
            AssetDetailsLoadedState(
              model: details,
            ),
          ),
        );
      },
    );
  }
}
