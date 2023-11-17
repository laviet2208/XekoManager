import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xekomanagermain/dataClass/Ads/ADStype1.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../dataClass/Ads/ADStype2.dart';
import '../../utils/utils.dart';

class ITEMbannerFacebook extends StatelessWidget {
  final double width;
  final double height;
  final ADStype2 adStype2;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMbannerFacebook({Key? key, required this.width, required this.height, required this.adStype2, required this.updateEvent, required this.color}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype2/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width-20,
      height: 100,
      decoration: BoxDecoration(
          color: color,
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
            width: (width - 20)/4 - 1 - 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.id,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'roboto',
                      color: Colors.black,
                      fontSize: 16
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
            width: (width - 20)/4 - 1 + 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.mainContent,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto',
                      color: Colors.purple,
                      fontSize: 16
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
            width: (width - 20)/4 + 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.facebookLink,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'roboto',
                      color: Colors.black,
                      fontSize: 16
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
            width: (width - 20)/4 - 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,top: 15),
                child: ListView(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: 'roboto',
                          ),
                        ),
                      ),
                      onTap: updateEvent,
                    ),

                    Container(height: 8,),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.redAccent
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Xóa banner',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.redAccent,
                            fontFamily: 'roboto',
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
                                    await deleteProduct(adStype2.id);
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

                    Container(height: 8,),

                    GestureDetector(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Xem ảnh sự kiện',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
                                fontSize: 13,
                                color: Colors.white
                            ),
                          )
                      ),
                      onTap: () async {
                        if (await canLaunch(adStype2.mainImage)) {
                          await launch(adStype2.mainImage);
                        } else {
                          toastMessage('Không thể mở ảnh');
                        }
                      },
                    ),

                    Container(height: 8,),

                    GestureDetector(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Xem facebook',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
                                fontSize: 13,
                                color: Colors.white
                            ),
                          )
                      ),
                      onTap: () async {
                        if (await canLaunch(adStype2.facebookLink)) {
                          await launch(adStype2.facebookLink);
                        } else {
                          toastMessage('Không thể mở ảnh');
                        }
                      },
                    ),

                    Container(height: 8,),
                  ],
                ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),
        ],
      ),
    );
  }
}
