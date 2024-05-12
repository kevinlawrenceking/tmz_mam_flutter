import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_metadata_field.dart';
import 'package:tmz_damz/data/models/picklist_agency.dart';
import 'package:tmz_damz/data/models/picklist_celebrity.dart';
import 'package:tmz_damz/data/models/picklist_keyword.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/picklist_agency.dart';
import 'package:tmz_damz/data/sources/picklist_celebrity.dart';
import 'package:tmz_damz/data/sources/picklist_keyword.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class BulkUpdateBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetDataSource assetDataSource;
  final IPicklistAgencyDataSource picklistAgencyDataSource;
  final IPicklistCelebrityDataSource picklistCelebrityDataSource;
  final IPicklistKeywordDataSource picklistKeywordDataSource;

  BulkUpdateBloc({
    required this.assetDataSource,
    required this.picklistAgencyDataSource,
    required this.picklistCelebrityDataSource,
    required this.picklistKeywordDataSource,
  }) : super(InitialState()) {
    on<RetrieveAgencyPicklistEvent>(_retrieveAgencyPicklistEvent);
    on<RetrieveCelebrityPicklistEvent>(_retrieveCelebrityPicklistEvent);
    on<RetrieveKeywordPicklistEvent>(_retrieveKeywordPicklistEvent);
    on<SaveMetadataEvent>(_saveMetadataEvent);
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

    for (var i = 0; i < event.assetIDs.length; i++) {
      final assetID = event.assetIDs[i];

      final result = await assetDataSource.updateAssetMetadataField(
        assetID: assetID,
        values: event.values,
      );

      result.fold(
        (failure) => emit(UpdateMetadataFailureState(failure)),
        (_) {},
      );

      if (result.isLeft()) {
        return;
      }

      emit(
        UpdateMetadataProgressState(
          progress: ((i + 1) / event.assetIDs.length).clamp(0.0, 1.0),
        ),
      );
    }

    emit(UpdateMetadataCompleteState());
  }
}
