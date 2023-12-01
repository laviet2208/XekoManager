import 'package:flutter/material.dart';

import 'Time.dart';

class historyTransaction {
  String id;
  String senderId;
  String receiverId;
  String area;
  String content;
  double money;
  Time transactionTime;
  int type; // 1 : nạp tiền cho ship , 2 : rút tiền cho ship , 3 : nạp tiền khu vực , 4 : trừ tiền khu vực

  historyTransaction({required this.id, required this.senderId,required this.receiverId, required this.transactionTime, required this.type,required this.content, required this.money, required this.area});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'receiverId' : receiverId,
    'type' : type,
    'transactionTime' : transactionTime.toJson(),
    'content' : content,
    'money' : money,
    'area' : area
  };

  factory historyTransaction.fromJson(Map<dynamic, dynamic> json) {
    return historyTransaction(
        id: json['id'].toString(),
        senderId: json['senderId'].toString(),
        receiverId: json['receiverId'].toString(),
        type: int.parse(json['type'].toString()),
        transactionTime: Time.fromJson(json['transactionTime']),
        content: json['content'].toString(),
        money: double.parse(json['money'].toString()),
        area: json['area'].toString()
    );
  }

}