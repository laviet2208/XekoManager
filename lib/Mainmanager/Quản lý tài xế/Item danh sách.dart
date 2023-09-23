import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/FinalClass.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../dataClass/Lịch sử giao dịch.dart';
import '../../dataClass/Time.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khách hàng/accountNormal.dart';

class ITEMdanhsachtaixe extends StatefulWidget {
  final double width;
  final double height;
  final accountNormal account;
  final VoidCallback onTapUpdate;
  const ITEMdanhsachtaixe({Key? key, required this.width, required this.height, required this.account, required this.onTapUpdate}) : super(key: key);

  @override
  State<ITEMdanhsachtaixe> createState() => _ITEMdanhsachkhachhangState();
}

class _ITEMdanhsachkhachhangState extends State<ITEMdanhsachtaixe> {
  final moneyControl = TextEditingController();
  final noidungcontrol = TextEditingController();
  bool loading = false;
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.account.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  Future<void> pushData2(accountNormal account, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + account.id).child('totalMoney').set(money);
      setState(() {
        loading = false;
      });
      toastMessage('Nạp tiền thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushhistoryData(historyTransaction history) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(history.id).set(history.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm lịch sử thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }


  Future<void> pushData(int data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + widget.account.id + '/status').set(data);
      toastMessage('Thay đổi trạng thái thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }


  @override
  Widget build(BuildContext context) {
    String status = '';
    Color statuscolor = Colors.green;
    if (widget.account.status == 1) {
      status = 'Đang kích hoạt';
    } else {
      status = 'Đang khóa';
      statuscolor = Colors.red;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey,
              width: 1
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  widget.account.name,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 100
                  ),
                )
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  widget.account.phoneNum,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 100
                  ),
                )
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  status,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
                      color: statuscolor,
                      fontSize: 100
                  ),
                )
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  area.name,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 100
                  ),
                )
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  widget.account.createTime.day.toString() + " / " + widget.account.createTime.month.toString() + " / " + widget.account.createTime.year.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 100
                  ),
                )
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
              width: (widget.width - 20)/6 - 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      child: Container(
                        width: ((widget.width - 20)/6 - 30)/2,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: statuscolor ,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Khóa/Mở tài khoản',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: statuscolor
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (widget.account.status == 1) {
                          await pushData(2);
                        } else {
                          await pushData(1);
                        }
                      },
                    ),
                  ),

                  Positioned(
                    top: 60,
                    right: 10,
                    child: GestureDetector(
                      child: Container(
                        width: ((widget.width - 20)/6 - 30)/2,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.blueAccent,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Nạp tiền',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.blueAccent
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Nạp tiền khu vực'),
                              content: Container(
                                width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                                height: 170, // Đặt kích thước chiều cao theo ý muốn
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                                      spreadRadius: 5, // bán kính của shadow
                                      blurRadius: 7, // độ mờ của shadow
                                      offset: Offset(0, 3), // vị trí của shadow
                                    ),
                                  ],
                                ),

                                child: ListView(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Số tiền cần nạp *',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )
                                          ),

                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Form(
                                              child: TextFormField(
                                                controller: moneyControl,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Số tiền cần nạp',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Nội dung nạp tiền *',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )
                                          ),

                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Form(
                                              child: TextFormField(
                                                controller: noidungcontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nội dung nạp tiền',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    moneyControl.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                  onPressed: loading ? null : () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                      if (dataCheckManager.containsOnlyDigits(moneyControl.text.toString())) {
                                        if (int.parse(moneyControl.text.toString()) > 0) {
                                          double newmoney = widget.account.totalMoney + double.parse(moneyControl.text.toString());
                                          historyTransaction history = historyTransaction(
                                              id: dataCheckManager.generateRandomString(25),
                                              senderId: currentAccount.username,
                                              receiverId: widget.account.id,
                                              transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                              type: 1,
                                              content: noidungcontrol.text.toString(),
                                              money: double.parse(moneyControl.text.toString())
                                          );
                                          await pushData2(widget.account, newmoney);
                                          await pushhistoryData(history);
                                          moneyControl.clear();
                                          Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Phải nhập số lớn hơn 0');
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      } else {
                                        toastMessage('Phải nhập đúng định dạng');
                                        setState(() {
                                          loading = false;
                                        });
                                      }

                                    } else {
                                      toastMessage('Phải nhập đủ thông tin');
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}

