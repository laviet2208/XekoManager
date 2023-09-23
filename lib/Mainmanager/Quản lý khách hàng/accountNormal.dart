
import '../../dataClass/Time.dart';
import '../Quản lý voucher/Voucher.dart';
import 'accountLocation.dart';

class accountNormal {
  String phoneNum;
  String id;
  String name;
  int type;
  int status;
  String Area;
  double totalMoney;
  Time createTime;
  accountLocation locationHis;
  List<Voucher> voucherList = [];
  String avatarID;

  accountNormal({required this.id, required this.avatarID, required this.createTime, required this.status, required this.name, required this.phoneNum, required this.type, required this.locationHis, required this.voucherList, required this.totalMoney, required this.Area});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'locationHis': locationHis.toJson(),
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'type' : type,
    'voucherList' : voucherList.map((Voucher) => Voucher.toJson()).toList(),
    'totalMoney' : totalMoney,
    'Area' : Area
  };

  factory accountNormal.fromJson(Map<dynamic, dynamic> json) {
    List<accountLocation> locationHis = [];
    List<Voucher> voucherList = [];

    if (json["voucherList"] != null) {
      for (final result in json["voucherList"]) {
        voucherList.add(Voucher.fromJson(result));
      }
    }

    return accountNormal(
        id: json['id'].toString(),
        avatarID: json['avatarID'].toString(),
        createTime: Time.fromJson(json['createTime']),
        status: int.parse(json['status'].toString()),
        name: json['name'].toString(),
        phoneNum: json['phoneNum'].toString(),
        type: int.parse(json['type'].toString()),
        locationHis: accountLocation.fromJson(json['locationHis']),
        voucherList: voucherList,
        totalMoney: double.parse(json['totalMoney'].toString()),
        Area: json['Area'].toString(),
    );
  }

}