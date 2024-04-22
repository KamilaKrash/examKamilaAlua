part of 'qr_bloc.dart';

@immutable
abstract class QrScanEvent {
  const QrScanEvent();
}

class ScanEvent extends QrScanEvent {
  const ScanEvent({
    required this.qrcode,
  });
  final String qrcode;
}