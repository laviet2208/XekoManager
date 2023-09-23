import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../dataClass/Product.dart';
import '../../utils/utils.dart';

class ThemMonAn {
  static Future<void> pushData(Product food) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Food').child(food.id).set(food.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static void showDialogthemmonan (double width, double height, BuildContext context, accountShop shop, TextEditingController t1, TextEditingController t2, TextEditingController t3, TextEditingController t4) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thêm món ăn'),
            content: Container(
              width: width,
              height: height,
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

              child: ListView(
                children: <Widget>[
                  Container(
                    height: 10,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tên món ăn *',
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
                              controller: t1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập tên món ăn',
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
                      'Mô tả món ăn *',
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
                              controller: t2,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập tên món ăn',
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
                      'Giá tiền món ăn *',
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
                              controller: t3,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập giá món ăn',
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
                      'Nhập liên kết ảnh đại diện món ăn *',
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
                              controller: t4,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập ảnh đại diện',
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
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Product fo = Product(id: dataCheckManager.generateRandomString(18), name: t1.text.toString(), content: t2.text.toString(), owner: shop, cost: double.parse(t3.text.toString()), imageList: t4.text.toString(),);
                  await pushData(fo);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Thêm món ăn',
                  style: TextStyle(color: Colors.black),
                ),
              ),

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
        }
        );
  }
}
