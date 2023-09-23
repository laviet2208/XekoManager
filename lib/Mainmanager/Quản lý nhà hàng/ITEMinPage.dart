import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import 'Danh mục đồ ăn/Hiển thị danh mục.dart';
import 'Danh mục đồ ăn/Thêm danh mục.dart';
import 'Thêm món ăn.dart';

class ITEMshop extends StatelessWidget {
  final double width;
  final double height;
  final accountShop shop;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMshop({Key? key, required this.width, required this.height, required this.shop, required this.updateEvent, required this.color}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant/' + shop.id + '/status').set(status);
      toastMessage('khóa/mở thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushIsTop(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant/' + shop.id + '/isTop').set(status);
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
    if (shop.status == 1) {
      status = 'Đang kích hoạt';
      statusColor = Colors.green;
    } else {
      status = 'Đang bị khóa';
      statusColor = Colors.red;
    }

    if (shop.isTop == 1) {
      istop = 'Chưa là top';
    } else {
      istop = 'Đang là top';
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
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
              width: width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(shop.name, 23),
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
              width: width/6,
              height: 25,
              child: AutoSizeText(
                shop.phoneNum,
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
            left: 25 + width/6 + 12,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                shop.createTime.hour.toString() + ":" + shop.createTime.minute.toString() + ":" + shop.createTime.second.toString() + " " + shop.createTime.day.toString() + "/" + shop.createTime.month.toString() + "/" + shop.createTime.year.toString(),
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
            left: 10 + width/6 + width/5 + 22 + 10,
            child: Container(
              width: width/5,
              height: 25,
              child: AutoSizeText(
                'Mở cửa : ' + shop.openTime.hour.toString() + " giờ, " + shop.openTime.minute.toString() + " phút",
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
            left: 10 + width/6 + width/5 + 22 + 10,
            child: Container(
              width: width/5,
              height: 25,
              child: AutoSizeText(
                'Đóng cửa : ' + shop.closeTime.hour.toString() + " giờ, " + shop.closeTime.minute.toString() + " phút",
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
            left: 80 + width/6 + width/5 + width/5 + 10,
            child: Container(
              width: width/10,
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
            left: 80 + width/6 + width/5 + width/5 + 10,
            child: Container(
              width: width/10,
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
            left: 52 + width/3 + 2 * width/5 + 30,
            child: GestureDetector(
              child: Container(
                width: width/10,
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
              onTap: updateEvent,
            ),
          ),

          Positioned(
            top: 50,
            left: 52 + width/3 + 2 * width/5 + 30,
            child: GestureDetector(
              child: Container(
                width: width/10,
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
                if (shop.status == 1) {
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
                width: width/10,
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
                            await deleteProduct(shop.id);
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
                width: width/10,
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
                  'DS đồ ăn',
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
                      title: Text('Thông tin nhà hàng'),
                      content: Container(
                        width: width,
                        height: height * 5,
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
                                  Themdanhmucdoan.showdialog(width/3*2, height, context, TextEditingController(), shop);
                                },
                              ),
                            ),

                            Positioned(
                              top: 55,
                              left: 10,
                              child: Container(
                                width: width - 20,
                                height: height * 5 - 65,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: width - 20,
                                        height: height/3*2,
                                        decoration: BoxDecoration(
                                            color:  Color.fromARGB(255, 240, 242, 245)
                                        ),
                                        child: ListView(
                                            scrollDirection: Axis.horizontal,

                                          children: [
                                            Container(
                                              width: (width - 20)/4 - 1,
                                              alignment: Alignment.center,
                                              child : Padding(
                                                padding: EdgeInsets.only(top: (height/3*2)/3,bottom: (height/3*2)/3),
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
                                              width: (width - 20)/4 - 1,
                                              alignment: Alignment.center,
                                              child : Padding(
                                                padding: EdgeInsets.only(top: (height/3*2)/3,bottom: (height/3*2)/3),
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
                                              width: (width - 20)/4 - 1,
                                              alignment: Alignment.center,
                                              child : Padding(
                                                padding: EdgeInsets.only(top: (height/3*2)/3,bottom: (height/3*2)/3),
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
                                              width: (width - 20)/4 - 1,
                                              alignment: Alignment.center,
                                              child : Padding(
                                                padding: EdgeInsets.only(top: (height/3*2)/3,bottom: (height/3*2)/3),
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
                                      top: height/3*2 + 2,
                                      left: 0,
                                      child: Container(
                                        width: width - 20,
                                        height: height * 5 - height/3*2,
                                        child: Hienthidanhmucdoan(width: width - 20, height: height * 5 - (height/3*2), idShop: shop.id,),
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
                width: width/10,
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
                  'Thêm món ăn',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                ThemMonAn.showDialogthemmonan(width/2, height * 3, context,shop,TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController());
              },
            ),
          ),
        ],
      ),
    );
  }
}
