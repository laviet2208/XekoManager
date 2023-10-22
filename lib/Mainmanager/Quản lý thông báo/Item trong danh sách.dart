import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Notification.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';

class Itemdanhsachtb extends StatefulWidget {
  final double width;
  final notification notice;
  final Color color;
  const Itemdanhsachtb({Key? key, required this.width, required this.notice, required this.color}) : super(key: key);

  @override
  State<Itemdanhsachtb> createState() => _ItemdanhsachState();
}

class _ItemdanhsachState extends State<Itemdanhsachtb> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  String type = '';
  String status = 'Dừng thông báo';
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.notice.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  Future<void> deleteNoti() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi xóa');
      throw error;
    }
  }

  Future<void> pushData(int type) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id + '/status').set(type);
      toastMessage('Đẩy/thu hồi thành công');
      if (widget.notice.status == 1) {
        status = 'Đẩy thông báo';
      }
      if (widget.notice.status == 2) {
        status = 'Dừng thông báo';
      }
      setState(() {

      });
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy');
      throw error;
    }
  }

  Future<void> pushData1() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id + '/send').set(Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year).toJson());
      toastMessage('Chuyển thời gian thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy');
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
    if (widget.notice.object == 0) {
      type = 'Khách hàng bình thường';
    }
    if (widget.notice.object == 1) {
      type = 'Nhân viên shipper';
    }
    if (widget.notice.object == 2) {
      type = 'Nhà hàng , siêu thị';
    }

    if (widget.notice.status == 1) {
      status = 'Đẩy thông báo';
    }
    if (widget.notice.status == 2) {
      status = 'Dừng thông báo';
    }

    return Container(
      width: widget.width,
      height: 120,
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
            width: widget.width/4-1,
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
                            text: 'Tiêu đề : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.Title, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Nội dung : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.Sub,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),

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

          Container(
            width: widget.width/4-1,
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
                            text: 'Khu vực : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đối tượng : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: type,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),

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

          Container(
            width: widget.width/4-1,
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
                            text: 'Ngày khởi tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.create.hour.toString() + " giờ " + widget.notice.create.minute.toString() + ", " + "Ngày " + widget.notice.create.day.toString() + "/" + widget.notice.create.month.toString() + "/" + widget.notice.create.year.toString(), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Gửi lần cuối lúc : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.send.hour.toString() + " giờ " + widget.notice.send.minute.toString() + ", " + "Ngày " + widget.notice.send.day.toString() + "/" + widget.notice.send.month.toString() + "/" + widget.notice.send.year.toString(), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),

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

          Container(
            width: widget.width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  Container(height: 15,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),

                      ),
                      alignment: Alignment.center,
                      child: Text(
                        status,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (widget.notice.status == 1) {
                        await pushData(2);
                        await pushData1();
                      } else {
                        await pushData(1);
                      }
                    },
                  ),

                  Container(height: 7,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.black
                        )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xóa thông báo',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await deleteNoti();
                    },
                  ),

                  Container(height: 20,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
