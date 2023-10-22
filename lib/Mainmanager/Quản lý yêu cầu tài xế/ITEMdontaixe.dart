import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/bikerRequest.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';

class ITEMdontaixe extends StatefulWidget {
  final double width;
  final double height;
  final bikeRequest request;
  final VoidCallback accept;
  final Color color;
  const ITEMdontaixe({Key? key, required this.width, required this.height, required this.request, required this.accept, required this.color}) : super(key: key);

  @override
  State<ITEMdontaixe> createState() => _ITEMdontaixeState();
}

class _ITEMdontaixeState extends State<ITEMdontaixe> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.request.owner.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }

  Future<void> deleteRequest(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('bikeRequest/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(int type) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + widget.request.owner.id + '/type').set(type);
      toastMessage('Phê duyệt thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 190,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: widget.width/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên tài khoản : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.owner.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số điện thoại : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.phoneNumber,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khu vực hiện tại : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Thời gian tạo tài khoản : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.owner.createTime.hour.toString() + ':' + widget.request.owner.createTime.minute.toString() + "  " + widget.request.owner.createTime.day.toString() + "/" + widget.request.owner.createTime.month.toString() + "/" + widget.request.owner.createTime.year.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
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

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên trong đơn : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số điện thoại trong đơn : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.phoneNumber, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số CMND : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.cmnd, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Địa chỉ điền trong đơn: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.request.address, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Loại phương tiện : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.request.type == 1) ? 'Xe máy' : 'Ô tô', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal, // Để viết bình thường
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

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  Container(
                    height: 10,
                  ),

                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 2,
                              color: Colors.blueAccent
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Chấp nhận',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent
                        ),
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận đồng ý'),
                            content: Text('Bạn có chắc chắn đồng ý yêu cầu này không.'),
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
                                  await pushData(2);
                                  await deleteRequest(widget.request.id);
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

                  Container(
                    height: 10,
                  ),

                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.redAccent,
                              width: 2
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Từ chối',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận từ chối'),
                            content: Text('Bạn có chắc chắn từ chối yêu cầu này không.'),
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
                                  await deleteRequest(widget.request.id);
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

                  Container(
                    height: 10,
                  ),

                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 2,
                              color: Colors.black
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xem TK',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog (
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xem thông tin tài khoản gửi đơn'),
                            content: Container(
                              width: widget.width * (1/3), // Đặt kích thước chiều rộng theo ý muốn
                              height: widget.height * 3, // Đặt kích thước chiều cao theo ý muốn
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2), // màu của shadow
                                    spreadRadius: 5, // bán kính của shadow
                                    blurRadius: 7, // độ mờ của shadow
                                    offset: Offset(0, 3), // vị trí của shadow
                                  ),
                                ],
                              ),

                              child: ListView(
                                children: [
                                  Container(
                                    height: 10,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Tên tài khoản *',
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
                                          child: Text(
                                            widget.request.owner.name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    height: 20,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Số điện thoại đăng ký *',
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
                                          child: Text(
                                            widget.request.owner.phoneNum,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    height: 20,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Thời gian tạo tài khoản *',
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
                                          child: Text(
                                            widget.request.owner.createTime.hour.toString() + ':' + widget.request.owner.createTime.minute.toString() + ':' + widget.request.owner.createTime.second.toString() + ' ' + widget.request.owner.createTime.day.toString() + '/' + widget.request.owner.createTime.month.toString() + '/' + widget.request.owner.createTime.year.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    height: 20,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'ID tài khoản *',
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
                                          child: Text(
                                            widget.request.owner.id,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    height: 40,
                                  ),

                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

