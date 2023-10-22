import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/FinalClass.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/Danh mục.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/DropList chọn icon.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/ItemDanhmuc.dart';
import '../../Mainmanager/Quản lý nhà hàng/Danh mục đồ ăn/Danh mục đồ ăn.dart';
import '../../Mainmanager/Quản lý nhà hàng/Danh mục đồ ăn/Hiển thị danh mục.dart';
import '../../Mainmanager/Quản lý nhà hàng/Danh mục đồ ăn/Thêm danh mục.dart';
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';

class Danhsachdanhmuc extends StatefulWidget {
  final double width;
  final double height;
  final accountShop shop;
  const Danhsachdanhmuc({Key? key, required this.width, required this.height, required this.shop}) : super(key: key);

  @override
  State<Danhsachdanhmuc> createState() => _DanhsachdanhmucState();
}

class _DanhsachdanhmucState extends State<Danhsachdanhmuc> {
  final mainContent = TextEditingController();
  final subContent = TextEditingController();

  bool loading = false;

  List<FoodDirectory> list = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("FoodDirectory").onValue.listen((event) {
      list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        FoodDirectory food= FoodDirectory.fromJson(value);
        if (food.ownerID == widget.shop.id) {
          list.add(food);
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
    return Container(
      width: widget.width,
      height: widget.height,
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
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                  child: AutoSizeText(
                    '+ Thêm danh mục món ăn',
                    style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 100,
                        color: Colors.white
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              onTap: () {
                Themdanhmucdoan.showdialog(widget.width/2, 200, context, TextEditingController(), widget.shop);
              },
            ),
          ),

          Positioned(
            top: 70,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 80,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: widget.width - 20,
                      height: 80,
                      decoration: BoxDecoration(
                          color:  Color.fromARGB(255, 240, 242, 245)
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        children: [
                          Container(
                            width: (widget.width - 20)/4 - 1,
                            alignment: Alignment.center,
                            child : Padding(
                              padding: EdgeInsets.only(top: 32,bottom: 32),
                              child: AutoSizeText(
                                'ID danh mục',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    color: Colors.black,
                                    fontSize: 100
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            decoration: BoxDecoration(
                                color: Colors.black
                            ),
                          ),

                          Container(
                            width: (widget.width - 20)/4 - 1,
                            alignment: Alignment.center,
                            child : Padding(
                              padding: EdgeInsets.only(top: 32,bottom: 32),
                              child: AutoSizeText(
                                'Tên danh mục',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    color: Colors.black,
                                    fontSize: 100
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            decoration: BoxDecoration(
                                color: Colors.black
                            ),
                          ),

                          Container(
                            width: (widget.width - 20)/4 - 1,
                            alignment: Alignment.center,
                            child : Padding(
                              padding: EdgeInsets.only(top: 32,bottom: 32),
                              child: AutoSizeText(
                                'Sô lượng món ăn',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    color: Colors.black,
                                    fontSize: 100
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            decoration: BoxDecoration(
                                color: Colors.black
                            ),
                          ),

                          Container(
                            width: (widget.width - 20)/4 - 1,
                            alignment: Alignment.center,
                            child : Padding(
                              padding: EdgeInsets.only(top: 32,bottom: 32),
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
              child: Hienthidanhmucdoan(width: widget.width - 20, height: 140, idShop: widget.shop.id,),
            ),
          )
        ],
      ),
    );
  }
}
