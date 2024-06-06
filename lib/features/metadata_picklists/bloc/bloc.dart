import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/picklist_agency.dart';
import 'package:tmz_damz/data/models/picklist_celebrity.dart';
import 'package:tmz_damz/data/models/picklist_keyword.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/data/sources/picklist_agency.dart';
import 'package:tmz_damz/data/sources/picklist_celebrity.dart';
import 'package:tmz_damz/data/sources/picklist_keyword.dart';
import 'package:tmz_damz/data/sources/user.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class MetadataBloc extends Bloc<MetadataBlocEvent, MetadataBlocState> {
  final IPicklistAgencyDataSource picklistAgencyDataSource;
  final IPicklistCelebrityDataSource picklistCelebrityDataSource;
  final IPicklistKeywordDataSource picklistKeywordDataSource;
  final IUserDataSource userDataSource;

  MetadataBloc({
    required this.picklistAgencyDataSource,
    required this.picklistCelebrityDataSource,
    required this.picklistKeywordDataSource,
    required this.userDataSource,
  }) : super(InitialState()) {
    on<RetrieveAgencyPicklistEvent>(_retrieveAgencyPicklistEvent);
    on<RetrieveCelebrityPicklistEvent>(_retrieveCelebrityPicklistEvent);
    on<RetrieveKeywordPicklistEvent>(_retrieveKeywordPicklistEvent);
    on<RetrieveUserPicklistEvent>(_retrieveUserPicklistEvent);
  }

  Future<void> _retrieveAgencyPicklistEvent(
    RetrieveAgencyPicklistEvent event,
    Emitter<MetadataBlocState> emit,
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
    Emitter<MetadataBlocState> emit,
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
    Emitter<MetadataBlocState> emit,
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

  Future<void> _retrieveUserPicklistEvent(
    RetrieveUserPicklistEvent event,
    Emitter<MetadataBlocState> emit,
  ) async {
    if (event.searchTerm.length < 2) {
      emit(
        UserPicklistState(
          picklist: const [],
        ),
      );
      return;
    }

    final result = await userDataSource.getUserList(
      searchTerm: event.searchTerm,
      offset: 0,
      limit: 100,
    );

    return result.fold(
      (_) => emit(
        UserPicklistState(
          picklist: const [],
        ),
      ),
      (results) => emit(
        UserPicklistState(
          picklist: results.users,
        ),
      ),
    );
  }
}
