import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/features/asset_import/bloc/session_bloc.dart';
import 'package:tmz_damz/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

@RoutePage(name: 'AssetImportRoute')
class AssetImportView extends StatefulWidget {
  const AssetImportView({
    super.key,
  });

  @override
  State<AssetImportView> createState() => _AssetImportViewState();
}

class _AssetImportViewState extends State<AssetImportView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: BlocProvider<SessionBloc>(
        create: (context) {
          final bloc = GetIt.instance<SessionBloc>();

          bloc.add(InitializeSession());

          return bloc;
        },
        child: BlocListener<SessionBloc, SessionBlocState>(
          listener: (context, state) async {
            if (state is SessionInitializationFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.error,
                title: 'Failed to Initialize Session',
                message: state.failure.message,
              );
            } else if (state is SessionInitializedState) {
              await AutoRouter.of(context).navigate(
                AssetImportSessionRoute(
                  sessionID: state.sessionID,
                ),
              );
            }
          },
          child: MaskedScrollView(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
              right: 20.0,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      ),
    );
  }
}
