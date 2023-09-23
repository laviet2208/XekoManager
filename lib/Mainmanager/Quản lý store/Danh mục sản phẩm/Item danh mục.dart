import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../Quản lý nhà hàng/Danh mục đồ ăn/Danh mục đồ ăn.dart';
import 'Thêm sản phẩm vào danh mục.dart';

class Itemdanhmucsanpham extends StatefulWidget {
  final double width;
  final FoodDirectory foodDirectory;
  const Itemdanhmucsanpham({Key? key, required this.width, required this.foodDirectory}) : super(key: key);

  @override
  State<Itemdanhmucsanpham> createState() => _ItemdanhmucmonanState();
}

class _ItemdanhmucmonanState extends State<Itemdanhmucsanpham> {
  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.id,
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.mainName,
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.foodList.length.toString(),
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  left: 5,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1
                        ),
                        color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3 , top: 5, bottom: 5),
                        child: AutoSizeText(
                          'Xóa danh mục',
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
                                  await deleteProduct(widget.foodDirectory.id);
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
                  top: 5,
                  right: 0,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1
                          ),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3 , top: 5, bottom: 5),
                        child: AutoSizeText(
                          'Xem danh sách',
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 5,
                  left: 5,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1
                          ),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3 , top: 5, bottom: 5),
                        child: AutoSizeText(
                          'Thêm món ăn',
                        ),
                      ),
                    ),

                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Add món ăn'),
                              content: Container(
                                height: 200,
                                width: widget.width/2,
                                child: searchPageproduct(id: widget.foodDirectory.id, idshop: widget.foodDirectory.ownerID, idproduct: widget.foodDirectory.foodList,),
                              ),
                            );
                          });
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
