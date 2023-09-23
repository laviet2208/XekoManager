import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../dataClass/bikerRequest.dart';
import 'ITEMdontaixe.dart';

class Danhsachyeucau extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachyeucau({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachyeucau> createState() => _DanhsachyeucauState();
}

class _DanhsachyeucauState extends State<Danhsachyeucau> {
  List<bikeRequest> requestList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("bikeRequest").onValue.listen((event) {
      requestList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        bikeRequest food= bikeRequest.fromJson(value);
        requestList.add(food);
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
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 250,
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
              height: 60,
              decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 240, 242, 245)
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Container(
                      width: widget.width/6,
                      height: 20,
                      child: AutoSizeText(
                        'Tên tài xế đăng ký',
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10 + widget.width/6,
                    child: Container(
                      width: 1,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 10 + widget.width/6 + 12,
                    child: Container(
                      width: widget.width/5,
                      height: 20,
                      child: AutoSizeText(
                        'Số điện thoại liên hệ',
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10 + widget.width/6 + widget.width/5 + 12,
                    child: Container(
                      width: 1,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 10 + widget.width/6 + widget.width/5 + 22,
                    child: Container(
                      width: widget.width/5,
                      height: 20,
                      child: AutoSizeText(
                        'Số căn cước công dân',
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10 + widget.width/6 + widget.width/5 + 32 + widget.width/5,
                    child: Container(
                      width: 1,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 52 + widget.width/6 + widget.width/5 + widget.width/5,
                    child: Container(
                      width: widget.width/5,
                      height: 20,
                      child: AutoSizeText(
                        'Địa chỉ đăng ký',
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 52 + widget.width/6 + 3 * widget.width/5 + 10,
                    child: Container(
                      width: 1,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 52 + widget.width/6 + 3 * widget.width/5 + 20,
                    child: Container(
                      width: widget.width/6,
                      height: 20,
                      child: AutoSizeText(
                        'Thao tác',
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
            top: 135,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 170,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: requestList.length,
                itemBuilder: (context, index) {
                  return ITEMdontaixe(width: widget.width - 20, height: 120, request: requestList[index],
                    accept: () {

                    },
                  );
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
