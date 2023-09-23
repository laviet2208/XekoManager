import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/Ads/ADStype1.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class ITEMbanner extends StatelessWidget {
  final double width;
  final double height;
  final ADStype1 adStype1;
  final VoidCallback updateEvent;
  const ITEMbanner({Key? key, required this.width, required this.height, required this.adStype1, required this.updateEvent}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype1/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey,
              width: 1
          )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 50,
            left: 15,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                adStype1.id,
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
            left: 15 + width/6 + 12,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(adStype1.mainContent, 30),
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Positioned(
            top: 70,
            left: 15 + width/6 + 12,
            child: Container(
              width: width/6,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(adStype1.secondaryText, 30),
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
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
                dataCheckManager.limitString(adStype1.mainImage, 28),
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
            left: 55 + width/6 + width/5 + width/5 + 10,
            child: Container(
              width: width/5,
              height: 25,
              child: AutoSizeText(
                dataCheckManager.limitString(adStype1.shop.name, 22),
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
            top: 40,
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
            top: 40,
            right: 10,
            child: GestureDetector(
              child: Container(
                width: width/10,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.blueAccent,
                        width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  'Xóa Banner',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Xác nhận xóa'),
                      content: Text('Bạn có chắc chắn xóa banner không.'),
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
                            await deleteProduct(adStype1.id);
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
        ],
      ),
    );
  }
}
