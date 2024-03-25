import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

part 'event.dart';
part 'state.dart';

class AssetDetailsBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetDataSource assetDataSource;

  AssetDetailsBloc({
    required this.assetDataSource,
  }) : super(InitialState()) {
    on<LoadAssetDetailsEvent>(_loadAssetDetailsEvent);
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
}
