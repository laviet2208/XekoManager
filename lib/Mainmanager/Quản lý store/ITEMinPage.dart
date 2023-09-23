import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import 'Danh mục sản phẩm/Hiển thị danh mục.dart';
import 'Danh mục sản phẩm/Thêm danh mục.dart';
import 'Thêm sản phẩm.dart';

class ITEMstore extends StatefulWidget {
  final double width;
  final double height;
  final accountShop shop;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMstore({Key? key, required this.width, required this.height, required this.shop, required this.updateEvent, required this.color}) : super(key: key);

  @override
  State<ITEMstore> createState() => _ITEMstoreState();
}

class _ITEMstoreState extends State<ITEMstore> {
  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + widget.shop.id + '/status').set(status);
      toastMessage('khóa/mở thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushIsTop(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + widget.shop.id + '/isTop').set(status);
      toastMessage('gắn/bỏ thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }



  @override
  Widget build(BuildContext context) {
    String istop = '';
    String status = '';
    Color statusColor = Colors.green;
    if (widget.shop.status == 1) {
      status = 'Đang kích hoạt';
      statusColor = Colors.green;
    } else {
      status = 'Đang bị khóa';
      statusColor = Colors.red;
    }

    if (widget.shop.isTop == 1) {
      istop = 'Chưa là top';
    } else {
      istop = 'Đang là top';
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(widget.shop.name, 23),
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 70,
            left: 10,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                widget.shop.phoneNum,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 25 + widget.width/6 + 12,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                widget.shop.createTime.hour.toString() + ":" + widget.shop.createTime.minute.toString() + ":" + widget.shop.createTime.second.toString() + " " + widget.shop.createTime.day.toString() + "/" + widget.shop.createTime.month.toString() + "/" + widget.shop.createTime.year.toString(),
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: 10 + widget.width/6 + widget.width/5 + 22 + 10,
            child: Container(
              width: widget.width/5,
              height: 25,
              child: AutoSizeText(
                'Mở cửa : ' + widget.shop.openTime.hour.toString() + " giờ, " + widget.shop.openTime.minute.toString() + " phút",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 70,
            left: 10 + widget.width/6 + widget.width/5 + 22 + 10,
            child: Container(
              width: widget.width/5,
              height: 25,
              child: AutoSizeText(
                'Đóng cửa : ' + widget.shop.closeTime.hour.toString() + " giờ, " + widget.shop.closeTime.minute.toString() + " phút",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.redAccent,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: 80 + widget.width/6 + widget.width/5 + widget.width/5 + 10,
            child: Container(
              width: widget.width/10,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: statusColor
                  )
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: AutoSizeText(
                  status,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: statusColor,
                      fontSize: 100
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 80 + widget.width/6 + widget.width/5 + widget.width/5 + 10,
            child: Container(
              width: widget.width/10,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: Colors.deepOrangeAccent
                  )
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: AutoSizeText(
                  istop,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.deepOrangeAccent,
                      fontSize: 100
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: 52 + widget.width/3 + 2 * widget.width/5 + 30,
            child: GestureDetector(
              child: Container(
                width: widget.width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: Colors.redAccent
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'Cập nhật',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.redAccent
                  ),
                ),
              ),
              onTap: widget.updateEvent,
            ),
          ),

          Positioned(
            top: 50,
            left: 52 + widget.width/3 + 2 * widget.width/5 + 30,
            child: GestureDetector(
              child: Container(
                width: widget.width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'Khóa/mở tài khoản',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                if (widget.shop.status == 1) {
                  await pushData(2);
                } else {
                  await pushData(1);
                }
              },
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: Container(
                width: widget.width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'Xóa tài khoản',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Xác nhận xóa'),
                      content: Text('Bạn có chắc chắn xóa tài khoản không.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Hủy',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await deleteProduct(widget.shop.id);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Đồng ý',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );

              },
            ),
          ),

          Positioned(
            top: 50,
            right: 10,
            child: GestureDetector(
              child: Container(
                width: widget.width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'DS sản phẩm',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thông tin cửa hàng'),
                      content: Container(
                        width: widget.width,
                        height: widget.height * 5,
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
                              top: 5,
                              left: 10,
                              child: GestureDetector(
                                child: Container(
                                  width: 190,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                                    child: AutoSizeText(
                                      '+ Thêm danh mục sản phẩm',
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
                                  Themdanhmucsanpham.showdialog(widget.width/3*2, widget.height, context, TextEditingController(), widget.shop);
                                },
                              ),
                            ),

                            Positioned(
                              top: 55,
                              left: 10,
                              child: Container(
                                width: widget.width - 20,
                                height: widget.height * 5 - 65,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: widget.width - 20,
                                        height: widget.height/3*2,
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
                                                padding: EdgeInsets.only(top: (widget.height/3*2)/3,bottom: (widget.height/3*2)/3),
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
                                                padding: EdgeInsets.only(top: (widget.height/3*2)/3,bottom: (widget.height/3*2)/3),
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
                                                padding: EdgeInsets.only(top: (widget.height/3*2)/3,bottom: (widget.height/3*2)/3),
                                                child: AutoSizeText(
                                                  'Sô lượng sản phẩm',
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
                                                padding: EdgeInsets.only(top: (widget.height/3*2)/3,bottom: (widget.height/3*2)/3),
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
                                      top: widget.height/3*2 + 2,
                                      left: 0,
                                      child: Container(
                                        width: widget.width - 20,
                                        height: widget.height * 5 - widget.height/3*2,
                                        child: Hienthidanhmucsanpham(width: widget.width - 20, height: widget.height * 5 - (widget.height/3*2), idShop: widget.shop.id,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Thoát',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );

              },
            ),
          ),

          Positioned(
            top: 90,
            right: 10,
            child: GestureDetector(
              child: Container(
                width: widget.width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'Thêm sản phẩm',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                ThemSanPham.showDialogthemmonan(widget.width/2, widget.height * 3, context,widget.shop,TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController());
              },
            ),
          ),
        ],
      ),
    );
  }
}

