
import '../../dataClass/Product.dart';
import '../../dataClass/Time.dart';
import '../Quản lý cấu hình/Cost.dart';
import '../Quản lý khách hàng/accountLocation.dart';
import '../Quản lý khách hàng/accountNormal.dart';
import '../Quản lý voucher/Voucher.dart';


class foodOrder {
  String id;
  accountLocation locationSet;
  accountLocation locationGet;
  double cost;
  double shipcost;
  Time startTime;
  Time receiveTime;
  Time endTime;
  Time cancelTime;
  accountNormal owner;
  accountNormal shipper;
  String status;
  Voucher voucher;
  Cost costFee;
  Cost costBiker;
  List<Product> productList;

  foodOrder({
    required this.id,
    required this.locationSet,
    required this.locationGet,
    required this.cost,
    required this.owner,
    required this.shipper,
    required this.status,
    required this.endTime,
    required this.startTime,
    required this.productList,
    required this.cancelTime,
    required this.receiveTime,
    required this.shipcost,
    required this.voucher,
    required this.costFee,
    required this.costBiker
  });

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'locationSet' : locationSet.toJson(),
    'locationGet' : locationGet.toJson(),
    'cost' : cost,
    'shipcost' : shipcost,
    'startTime' : startTime.toJson(),
    'receiveTime' : receiveTime.toJson(),
    'endTime' : endTime.toJson(),
    'cancelTime' : cancelTime.toJson(),
    'owner' : owner.toJson(),
    'status' : status,
    'productList': productList.map((e) => e.toJson()).toList(),
    'shipper' : shipper.toJson(),
    'voucher' : voucher.toJson(),
    'costFee' : costFee.toJson(),
    'costBiker' : costBiker.toJson()
  };

  factory foodOrder.fromJson(Map<dynamic, dynamic> json) {
    List<Product> product = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        product.add(Product.fromJson(result));
      }
    }

    accountNormal shipper;

    if (json['shipper'] != null) {
      shipper = accountNormal.fromJson(json['shipper']);
    } else {
      shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), voucherList: [], totalMoney: 0, Area: '');
    }

    return foodOrder(
      id: json['id'].toString(),
      locationSet: accountLocation.fromJson(json['locationSet']),
      locationGet: accountLocation.fromJson(json['locationGet']),
      cost: double.parse(json['cost'].toString()),
      owner: accountNormal.fromJson(json['owner']),
      status: json['status'].toString(),
      endTime: Time.fromJson(json['endTime']),
      startTime: Time.fromJson(json['startTime']),
      productList: product,
      cancelTime: Time.fromJson(json['cancelTime']),
      receiveTime: Time.fromJson(json['receiveTime']),
      shipcost: double.parse(json['shipcost'].toString()),
      shipper: shipper,
      voucher: Voucher.fromJson(json['voucher']),
      costFee: Cost.fromJson(json['costFee']),
      costBiker: Cost.fromJson(json['costBiker']),
    );
  }
}