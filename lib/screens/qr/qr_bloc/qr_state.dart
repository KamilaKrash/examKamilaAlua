part of 'qr_bloc.dart';

@immutable
abstract class QrState {
  const QrState();
}

class QrStateInitial extends QrState {}

class QrStateScanned extends QrState {
  final String qrcode;

  const QrStateScanned({
    required this.qrcode
  });

}
