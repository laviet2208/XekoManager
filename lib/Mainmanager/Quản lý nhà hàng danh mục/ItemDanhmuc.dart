import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import 'Danh mục.dart';
import 'Page tìm kiếm.dart';

class ITEMdanhmucshop extends StatelessWidget {
  final double width;
  final double height;
  final List<accountShop> shopList;
  final RestaurantDirectory directory;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMdanhmucshop({Key? key, required this.width, required this.height, required this.updateEvent, required this.directory, required this.shopList, required this.color}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('RestaurantDirectory/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('RestaurantDirectory/' + directory.id).set(directory.toJson());
      toastMessage('Thêm thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {

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
            top: 50,
            left: 10,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(directory.id, 23),
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
            top: 50,
            left: 25 + width/6 + 12,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(directory.mainContent, 23),
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
            left: 10 + width/6 + width/5 + 22 + 10,
            child: Container(
              width: width/5,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(directory.subContent, 23),
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
            top: 50,
            left: 80 + width/6 + width/5 + width/5 + 10,
            child: Container(
              width: width/10,
              height: 32,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: AutoSizeText(
                  directory.shopList.length.toString() + ' Nhà Hàng',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
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
                  'Thêm nhà hàng',
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
                        title: Text('Add nhà hàng mới vào danh mục'),
                        content: Container(
                          width: width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                          height: height * 2,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 150,
                                  child: searchPagedanhmuc(list: directory.shopList, list1: shopList,
                                    event: () async {
                                      await pushData();
                                      Navigator.of(context).pop();
                                    },),
                                ),

                              ),
                            ],
                          ),
                        ),
                      );
                    });
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
                  'Xóa danh mục',
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
                      content: Text('Bạn có chắc chắn xóa danh mục không.'),
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
                            await deleteProduct(directory.id);
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
                  'DS nhà hàng',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {

              },
            ),
          ),
        ],
      ),
    );
  }
}
