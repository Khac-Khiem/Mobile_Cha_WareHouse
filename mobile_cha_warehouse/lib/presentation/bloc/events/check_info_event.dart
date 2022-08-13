import 'package:equatable/equatable.dart';

abstract class CheckInfoEvent extends Equatable {}

class CheckInfoEventRequested extends CheckInfoEvent {
  String basketID;
  DateTime timeStamp; //Tạo timeStamp để lần nào click cũng khác nhau
  CheckInfoEventRequested({required this.timeStamp, required this.basketID});
  @override
  List<Object> get props =>
      [timeStamp, basketID]; //Với mỗi basket ID thì sẽ refresh lại
}

