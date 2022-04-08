import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fkpmobile/services/qrcodeServices.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  final QrcodeService qrcodeService;
  QrcodeBloc({required this.qrcodeService}) : super(QrcodeInitial()) {
    on<QrcodeEvent>((event, emit) {
      emit(QrcodeInitial());
    });
  }
}
