import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'accountNormal.dart';

class ITEMdanhsachkhachhang extends StatefulWidget {
  final double width;
  final double height;
  final accountNormal account;
  final VoidCallback onTapUpdate;
  const ITEMdanhsachkhachhang({Key? key, required this.width, required this.height, required this.account, required this.onTapUpdate}) : super(key: key);

  @override
  State<ITEMdanhsachkhachhang> createState() => _ITEMdanhsachkhachhangState();
}

class _ITEMdanhsachkhachhangState extends State<ITEMdanhsachkhachhang> {

Future<void> pushData(int data) async{
  try {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('normalUser/' + widget.account.id + '/status').set(data);
    toastMessage('Thay đổi trạng thái thành công');
  } catch (error) {
    print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
    throw error;
  }
}


@override
Widget build(BuildContext context) {
  String status = '';
  Color statuscolor = Colors.green;
  if (widget.account.status == 1) {
    status = 'Đang kích hoạt';
  } else {
    status = 'Đang khóa';
    statuscolor = Colors.red;
  }

  return Container(
    width: widget.width,
    height: widget.height,
    decoration: BoxDecoration(
        color: Colors.white,
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: AutoSizeText(
                widget.account.name,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 100
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: AutoSizeText(
                widget.account.phoneNum,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 100
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: AutoSizeText(
                status,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'arial',
                    color: statuscolor,
                    fontSize: 100
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: AutoSizeText(
                widget.account.createTime.day.toString() + " / " + widget.account.createTime.month.toString() + " / " + widget.account.createTime.year.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'arial',
                    color: statuscolor,
                    fontSize: 100
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: AutoSizeText(
                widget.account.createTime.day.toString() + " / " + widget.account.createTime.month.toString() + " / " + widget.account.createTime.year.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'arial',
                    color: statuscolor,
                    fontSize: 100
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
          width: (widget.width - 20)/6 - 1,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  child: Container(
                    width: ((widget.width - 20)/6 - 30)/2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: statuscolor ,
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Khóa/Mở tài khoản',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: statuscolor
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (widget.account.status == 1) {
                      await pushData(2);
                    } else {
                      await pushData(1);
                    }
                  },
                ),
              ),

              Positioned(
                top: 60,
                right: 10,
                child: GestureDetector(
                  child: Container(
                    width: ((widget.width - 20)/6 - 30)/2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.blueAccent,
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Cập nhật',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blueAccent
                      ),
                    ),
                  ),
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

