// ignore_for_file: avoid_print

import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_drop_down.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_icon_button.dart';
import 'themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_widgets.dart';
import 'controllers/form_field_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/advanced_search_window_model.dart';
import 'save_your_search_widget.dart';
import 'package:motion_toast/motion_toast.dart';

class AdvancedSearchWindowWidget extends StatefulWidget {
  const AdvancedSearchWindowWidget({super.key});

  @override
  State<AdvancedSearchWindowWidget> createState() =>
      _AdvancedSearchWindowWidgetState();
}

class _AdvancedSearchWindowWidgetState
    extends State<AdvancedSearchWindowWidget> {
  late AdvancedSearchWindowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdvancedSearchWindowModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 20.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.searchBarModel,
                            updateCallback: () => setState(() {}),
                            child: const SearchBarWidget(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 20.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderRadius: 15.0,
                          borderWidth: 2.0,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          icon: Icon(
                            Icons.star,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          .75, // Adjust based on your needs
                      // Consider making this dynamic as well
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 20.0, 20.0, 0.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20.0, 0.0, 40.0, 0.0),
                                          child: Text(
                                            'Asset Type: ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            borderRadius: 10.0,
                                            borderWidth: 2.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              Icons.image,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent2,
                                          borderRadius: 10.0,
                                          borderWidth: 1.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent2,
                                          icon: FaIcon(
                                            FontAwesomeIcons.folderOpen,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20.0, 0.0, 39.0, 0.0),
                                          child: Text(
                                            'Collections: ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 20.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController1,
                                              focusNode:
                                                  _model.textFieldFocusNode1,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Select item ...',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall,
                                              validator: _model
                                                  .textController1Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20.0, 0.0, 41.0, 0.0),
                                          child: Text(
                                            'Categories: ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 20.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController2,
                                              focusNode:
                                                  _model.textFieldFocusNode2,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Select item ...',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .textController2Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20.0, 0.0, 58.0, 0.0),
                                            child: Text(
                                              'Created: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked1CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked1CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked1CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked1 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 60.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked2CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked2CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked2CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked2 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked3CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked3CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked3CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked3 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final datePicked4CupertinoTheme =
                                                        CupertinoTheme.of(
                                                            context);
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                            datePicked4CupertinoTheme
                                                                .copyWith(
                                                          textTheme:
                                                              datePicked4CupertinoTheme
                                                                  .textTheme
                                                                  .copyWith(
                                                            dateTimePickerTextStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                    ),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          minimumDate:
                                                              DateTime(1900),
                                                          initialDateTime:
                                                              getCurrentTimestamp,
                                                          maximumDate:
                                                              DateTime(2050),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                                  safeSetState(
                                                                      () {
                                                            _model.datePicked4 =
                                                                newDateTime;
                                                          }),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20.0, 20.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 58.0, 10.0),
                                            child: Text(
                                              'Created: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    borderRadius: 15.0,
                                                    borderWidth: 2.0,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    icon: Icon(
                                                      Icons.calendar_month,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                    onPressed: () async {
                                                      await showModalBottomSheet<
                                                              bool>(
                                                          context: context,
                                                          builder: (context) {
                                                            final datePicked5CupertinoTheme =
                                                                CupertinoTheme
                                                                    .of(context);
                                                            return Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  3,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              child:
                                                                  CupertinoTheme(
                                                                data: datePicked5CupertinoTheme
                                                                    .copyWith(
                                                                  textTheme: datePicked5CupertinoTheme
                                                                      .textTheme
                                                                      .copyWith(
                                                                    dateTimePickerTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                                child:
                                                                    CupertinoDatePicker(
                                                                  mode:
                                                                      CupertinoDatePickerMode
                                                                          .date,
                                                                  minimumDate:
                                                                      DateTime(
                                                                          1900),
                                                                  initialDateTime:
                                                                      getCurrentTimestamp,
                                                                  maximumDate:
                                                                      DateTime(
                                                                          2050),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                  use24hFormat:
                                                                      false,
                                                                  onDateTimeChanged:
                                                                      (newDateTime) =>
                                                                          safeSetState(
                                                                              () {
                                                                    _model.datePicked5 =
                                                                        newDateTime;
                                                                  }),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Text(
                                                    'mm/dd/yyyy',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await showModalBottomSheet<
                                                            bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          final datePicked6CupertinoTheme =
                                                              CupertinoTheme.of(
                                                                  context);
                                                          return Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                3,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            child:
                                                                CupertinoTheme(
                                                              data:
                                                                  datePicked6CupertinoTheme
                                                                      .copyWith(
                                                                textTheme:
                                                                    datePicked6CupertinoTheme
                                                                        .textTheme
                                                                        .copyWith(
                                                                  dateTimePickerTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                              child:
                                                                  CupertinoDatePicker(
                                                                mode:
                                                                    CupertinoDatePickerMode
                                                                        .date,
                                                                minimumDate:
                                                                    DateTime(
                                                                        1900),
                                                                initialDateTime:
                                                                    getCurrentTimestamp,
                                                                maximumDate:
                                                                    DateTime(
                                                                        2050),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                use24hFormat:
                                                                    false,
                                                                onDateTimeChanged:
                                                                    (newDateTime) =>
                                                                        safeSetState(
                                                                            () {
                                                                  _model.datePicked6 =
                                                                      newDateTime;
                                                                }),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  borderRadius: 15.0,
                                                  borderWidth: 2.0,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  icon: Icon(
                                                    Icons.calendar_month,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                  onPressed: () async {
                                                    await showModalBottomSheet<
                                                            bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          final datePicked7CupertinoTheme =
                                                              CupertinoTheme.of(
                                                                  context);
                                                          return Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                3,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            child:
                                                                CupertinoTheme(
                                                              data:
                                                                  datePicked7CupertinoTheme
                                                                      .copyWith(
                                                                textTheme:
                                                                    datePicked7CupertinoTheme
                                                                        .textTheme
                                                                        .copyWith(
                                                                  dateTimePickerTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                              child:
                                                                  CupertinoDatePicker(
                                                                mode:
                                                                    CupertinoDatePickerMode
                                                                        .date,
                                                                minimumDate:
                                                                    DateTime(
                                                                        1900),
                                                                initialDateTime:
                                                                    getCurrentTimestamp,
                                                                maximumDate:
                                                                    DateTime(
                                                                        2050),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                use24hFormat:
                                                                    false,
                                                                onDateTimeChanged:
                                                                    (newDateTime) =>
                                                                        safeSetState(
                                                                            () {
                                                                  _model.datePicked7 =
                                                                      newDateTime;
                                                                }),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: Text(
                                                  'mm/dd/yyyy',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet<
                                                          bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        final datePicked8CupertinoTheme =
                                                            CupertinoTheme.of(
                                                                context);
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          child: CupertinoTheme(
                                                            data:
                                                                datePicked8CupertinoTheme
                                                                    .copyWith(
                                                              textTheme:
                                                                  datePicked8CupertinoTheme
                                                                      .textTheme
                                                                      .copyWith(
                                                                dateTimePickerTextStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                        ),
                                                              ),
                                                            ),
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .date,
                                                              minimumDate:
                                                                  DateTime(
                                                                      1900),
                                                              initialDateTime:
                                                                  getCurrentTimestamp,
                                                              maximumDate:
                                                                  DateTime(
                                                                      2050),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              use24hFormat:
                                                                  false,
                                                              onDateTimeChanged:
                                                                  (newDateTime) =>
                                                                      safeSetState(
                                                                          () {
                                                                _model.datePicked8 =
                                                                    newDateTime;
                                                              }),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20.0, 0.0, 55.0, 0.0),
                                            child: Text(
                                              'Updated: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked9CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked9CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked9CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked9 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 60.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked10CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked10CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked10CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked10 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked11CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked11CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked11CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked11 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final datePicked12CupertinoTheme =
                                                        CupertinoTheme.of(
                                                            context);
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                            datePicked12CupertinoTheme
                                                                .copyWith(
                                                          textTheme:
                                                              datePicked12CupertinoTheme
                                                                  .textTheme
                                                                  .copyWith(
                                                            dateTimePickerTextStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                    ),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          minimumDate:
                                                              DateTime(1900),
                                                          initialDateTime:
                                                              getCurrentTimestamp,
                                                          maximumDate:
                                                              DateTime(2050),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                                  safeSetState(
                                                                      () {
                                                            _model.datePicked12 =
                                                                newDateTime;
                                                          }),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20.0, 0.0, 55.0, 0.0),
                                            child: Text(
                                              'Updated: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked13CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked13CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked13CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked13 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 60.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked14CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked14CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked14CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked14 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 15.0,
                                              borderWidth: 2.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet<
                                                        bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      final datePicked15CupertinoTheme =
                                                          CupertinoTheme.of(
                                                              context);
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        child: CupertinoTheme(
                                                          data:
                                                              datePicked15CupertinoTheme
                                                                  .copyWith(
                                                            textTheme:
                                                                datePicked15CupertinoTheme
                                                                    .textTheme
                                                                    .copyWith(
                                                              dateTimePickerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                      ),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                            minimumDate:
                                                                DateTime(1900),
                                                            initialDateTime:
                                                                getCurrentTimestamp,
                                                            maximumDate:
                                                                DateTime(2050),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (newDateTime) =>
                                                                    safeSetState(
                                                                        () {
                                                              _model.datePicked15 =
                                                                  newDateTime;
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Text(
                                              'mm/dd/yyyy',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    final datePicked16CupertinoTheme =
                                                        CupertinoTheme.of(
                                                            context);
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                            datePicked16CupertinoTheme
                                                                .copyWith(
                                                          textTheme:
                                                              datePicked16CupertinoTheme
                                                                  .textTheme
                                                                  .copyWith(
                                                            dateTimePickerTextStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                    ),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          minimumDate:
                                                              DateTime(1900),
                                                          initialDateTime:
                                                              getCurrentTimestamp,
                                                          maximumDate:
                                                              DateTime(2050),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                                  safeSetState(
                                                                      () {
                                                            _model.datePicked16 =
                                                                newDateTime;
                                                          }),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 25.0, 0.0),
                                            child: Text(
                                              'Search the following if',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 10.0, 0.0),
                                              child:
                                                  FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .dropDownValueController1 ??=
                                                    FormFieldController<String>(
                                                  _model.dropDownValue1 ??=
                                                      'Any',
                                                ),
                                                options: const ['Any', 'All'],
                                                onChanged: (val) => setState(
                                                    () => _model
                                                        .dropDownValue1 = val),
                                                width: 100.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                elevation: 2.0,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderWidth: 2.0,
                                                borderRadius: 8.0,
                                                margin:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0, 4.0, 16.0, 4.0),
                                                hidesUnderline: true,
                                                isOverButton: true,
                                                isSearchable: false,
                                                isMultiSelect: false,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 25.0, 0.0),
                                            child: Text(
                                              'conditions are a match:',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20.0, 20.0, 20.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 25.0, 0.0),
                                            child: Text(
                                              'Search the following if',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 20.0, 0.0),
                                            child: FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController2 ??=
                                                  FormFieldController<String>(
                                                _model.dropDownValue2 ??= 'Any',
                                              ),
                                              options: const ['Any', 'All'],
                                              onChanged: (val) => setState(() =>
                                                  _model.dropDownValue2 = val),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 4.0, 16.0, 4.0),
                                              hidesUnderline: true,
                                              isOverButton: true,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 25.0, 0.0),
                                            child: Text(
                                              'conditions are a match:',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController3 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const ['Option 1'],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue3 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.12,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Metadata',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController4 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const [
                                              'Equals',
                                              'Not Equals',
                                              'In',
                                              'Not In',
                                              'Like',
                                              'Not Like',
                                              'Is Blank',
                                              'Is Not Blank'
                                            ],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue4 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.10,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Modifier',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController5 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const ['Option 1'],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue5 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.12,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Select Item',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            borderRadius: 15.0,
                                            borderWidth: 2.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            icon: Icon(
                                              Icons.close,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ].divide(const SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController6 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const ['Option 1'],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue6 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.10,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Please select...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController7 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const ['Option 1'],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue7 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.10,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Please select...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController8 ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: const ['Option 1'],
                                            onChanged: (val) => setState(() =>
                                                _model.dropDownValue8 = val),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.10,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText: 'Please select...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 4.0, 16.0, 4.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            borderRadius: 15.0,
                                            borderWidth: 2.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            icon: Icon(
                                              Icons.close,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              -1.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () {
                                              print('Button pressed ...');
                                            },
                                            text: 'Add Condition',
                                            icon: Icon(
                                              Icons.add,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            options: FFButtonOptions(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          30.0, 10.0, 30.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // You can adjust the dialog style and behavior here
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child:
                                        const SaveYourSearchWidget(), // Your custom widget inside the dialog
                                  );
                                },
                              );
                            },
                            text: 'Save Search',
                            icon: const Icon(
                              Icons.star,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 30.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 15.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      // Show motion toast
                                      MotionToast.info(
                                        title: const Text("Reset"),
                                        description: const Text(
                                            "Your form has been reset."),
                                        animationType: AnimationType.fromTop,
                                        position: MotionToastPosition.top,
                                        width:
                                            300, // Customizing the width of the toast
                                      ).show(context);
                                    },
                                    text: 'Reset',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              30.0, 0.0, 30.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Search',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            30.0, 0.0, 30.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    tabletLandscape: false,
                    desktop: false,
                  ))
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          30.0, 10.0, 30.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Save Search',
                            icon: const Icon(
                              Icons.star,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 30.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 15.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'Reset',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              30.0, 0.0, 30.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Search',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            30.0, 0.0, 30.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
