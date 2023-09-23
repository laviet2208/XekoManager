import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/FinalClass.dart';

import '../../Mainmanager/Quản lý khách hàng/ITEMdskhachhang.dart';
import '../../Mainmanager/Quản lý khách hàng/accountNormal.dart';


class Danhsachkhachhang extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachkhachhang({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachkhachhang> createState() => _DanhsachkhachhangState();
}

class _DanhsachkhachhangState extends State<Danhsachkhachhang> {
  List<accountNormal> accountList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").onValue.listen((event) {
      accountList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountNormal food= accountNormal.fromJson(value);
        if (food.Area == currentAccount.provinceCode) {
          accountList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    'Xuất danh sách Excel',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'arial',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {

                },
              ),
            ),

            Positioned(
              top: 70,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: 100,
                decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 240, 242, 245)
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 40,
                      left: 10,
                      child: Container(
                        width: widget.width/7,
                        height: 20,
                        child: AutoSizeText(
                          'Tên trong App',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/7,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/7 + 12,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'Số điện thoại',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/7 + 12 + widget.width/6 + 10,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/7 + 12 + widget.width/6 + 20,
                      child: Container(
                        width: widget.width/5,
                        height: 20,
                        child: AutoSizeText(
                          'Trạng thái tài khoản',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/7 + 12 + widget.width/6 + 30 + widget.width/5,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/7 + 12 + widget.width/6 + 40 + widget.width/5,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'Khu vực',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/7 + 12 + widget.width/3 + 50 + widget.width/5,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/7 + 12 + widget.width/3 + 50 + widget.width/5 + 10,
                      child: Container(
                        width: widget.width/8.5,
                        height: 20,
                        child: AutoSizeText(
                          'Ngày tạo',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 20 + widget.width/7 + widget.width/8.5 + 12 + widget.width/3 + 50 + widget.width/5 + 10,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left:  20 + 2 * widget.width/7 + 12 + widget.width/3 + 50 + widget.width/5 + 20,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'Hành động',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 175,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 190,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                    itemCount: accountList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsachkhachhang(width: widget.width - 20, height: 120, account: accountList[index],
                        onTapUpdate: () {

                        },);
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
