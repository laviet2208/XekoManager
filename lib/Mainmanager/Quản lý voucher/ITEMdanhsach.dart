import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import 'Voucher.dart';

class ITEMdanhsach extends StatefulWidget {
  final double width;
  final double height;
  final Voucher voucher;
  final VoidCallback onTapUpdate;
  final Color color;
  const ITEMdanhsach({Key? key, required this.width, required this.height, required this.voucher, required this.onTapUpdate, required this.color}) : super(key: key);

  @override
  State<ITEMdanhsach> createState() => _ITEMdanhsachState();
}

class _ITEMdanhsachState extends State<ITEMdanhsach> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.voucher.LocationId).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }


  @override
  Widget build(BuildContext context) {
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
                widget.voucher.tenchuongtrinh,
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
                widget.voucher.id,
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
            top: 110,
            left: 10,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                area.name,
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
            left: 10 + widget.width/6 + 12,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                "Bắt đầu : " + widget.voucher.startTime.day.toString() + "/" + widget.voucher.startTime.month.toString() + "/" + widget.voucher.startTime.year.toString(),
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
            top: 70,
            left: 10 + widget.width/6 + 12,
            child: Container(
              width: widget.width/6,
              height: 25,
              child: AutoSizeText(
                "Kết thúc : " + widget.voucher.endTime.day.toString() + "/" + widget.voucher.endTime.month.toString() + "/" + widget.voucher.endTime.year.toString(),
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
                'Giảm : ' + dataCheckManager.getStringNumber(widget.voucher.totalmoney) + 'VNĐ',
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
            top: 70,
            left: 10 + widget.width/6 + widget.width/5 + 22 + 10,
            child: Container(
              width: widget.width/5,
              height: 25,
              child: AutoSizeText(
                'Đơn từ : ' + dataCheckManager.getStringNumber(widget.voucher.mincost) + 'VNĐ',
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
            left: 52 + widget.width/6 + widget.width/5 + widget.width/5 + 10,
            child: Container(
              width: widget.width/5,
              height: 25,
              child: AutoSizeText(
                widget.voucher.useCount.toString() + "/" + widget.voucher.maxCount.toString(),
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
              onTap: widget.onTapUpdate,
            ),
          ),

          Positioned(
            top: 70,
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
                  'Xóa',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                ),
              ),
              onTap: () async {
                await deleteProduct(widget.voucher.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
