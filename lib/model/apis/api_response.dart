
import '../../utils/enums.dart';

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message) : status = Status.initial;

  ApiResponse.loading(this.message) : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  ApiResponse.notInternet(this.message) : status = Status.noInternet;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
