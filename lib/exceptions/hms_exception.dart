import 'dart:collection';

class HMSException {
  int code;
  String description;
  String name;
  String message;
  String action;


  HMSException(
      {required this.code,
      required this.message,
      required this.name,
      required this.action,
      required this.description,
      });
}
