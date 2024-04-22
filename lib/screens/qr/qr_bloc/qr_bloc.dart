import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'qr_event.dart';

part 'qr_state.dart';

class QrBloc extends Bloc<QrScanEvent, QrState> {
  QrBloc() : super(QrStateInitial()) {
    on<ScanEvent> ((event, emit) async {
      emit(QrStateScanned(qrcode: event.qrcode));
    });
  }
}
