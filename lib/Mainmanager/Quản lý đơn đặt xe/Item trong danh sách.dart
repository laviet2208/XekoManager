import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/Data/catchOrder.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý đơn giao hàng/Data/Tính khoảng cách.dart';


class Itemdanhsach extends StatefulWidget {
  final double width;
  final catchOrder order;
  final Color color;
  const Itemdanhsach({Key? key, required this.width, required this.order, required this.color}) : super(key: key);

  @override
  State<Itemdanhsach> createState() => _ItemdanhsachState();
}

class _ItemdanhsachState extends State<Itemdanhsach> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.order.owner.Area).onValue.listen((event) {
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

  @override
  Widget build(BuildContext context) {
    String status = '';
    if (widget.order.status == 'A') {
      status = 'Chờ shipper nhận đơn';
    }

    if (widget.order.status == 'B') {
      status = 'Shipper đã nhận đơn , đang đến';
    }

    if (widget.order.status == 'C') {
      status = 'Shipper đã đón khách';
    }

    if (widget.order.status == 'D') {
      status = 'Shipper đã đưa khách tới nơi';
    }

    if (widget.order.status == 'E') {
      status = 'Bị hủy bởi khách khi shipper chưa đến';
    }

    if (widget.order.status == 'F') {
      status = 'Bị hủy bởi shipper';
    }

    if (widget.order.status == 'F') {
      status = 'Bị hủy bởi user khi shipper đã nhận';
    }

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
            width: widget.width/6-1,
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
                            text: 'Mã đơn: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.id, // Phần còn lại viết bình thường
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

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khoảng cách chim bay: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: CaculateDistance.calculateDistance(widget.order.locationSet.Latitude, widget.order.locationSet.Longitude, widget.order.locationGet.Latitude, widget.order.locationGet.Longitude).toStringAsFixed(2).toString() + ' Km',
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

                  Container(height: 10,),

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
                            text: area.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
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
                            text: 'Tài khoản: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.owner.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.red,
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
                            text: 'Số điện thoại: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.owner.phoneNum, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.red,
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
                            text: 'Trạng thái : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: status, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.red,
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
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
                            text: 'Điểm đón khách: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationSet.firstText + ' , ' + widget.order.locationSet.secondaryText, // Phần còn lại viết bình thường
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
                            text: 'Điểm trả khách: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationGet.firstText + ' , ' + widget.order.locationGet.secondaryText, // Phần còn lại viết bình thường
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
            width: widget.width/6-1,
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
                            text: 'Phương tiện : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.order.type == 1) ? 'Xe máy' : 'Ô tô',
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
                            text: 'Giá trị đơn gốc : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.order.cost + widget.order.voucher.totalmoney).toString() + ' VNĐ',
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
                            text: 'Giá trị đơn thực tế : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.order.cost).toString() + ' VNĐ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.blueAccent,
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
                            text: 'Sự kiện voucher : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.order.voucher.id != '') ? (widget.order.voucher.tenchuongtrinh) : ('Không áp voucher'),
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
            width: widget.width/6-1,
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
                            text: 'Phí đề pa : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.order.costFee.departCost).toString() + ' VNĐ',
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
                            text: 'Số km đề pa : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.costFee.departKM.toString() + ' Km',
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
                            text: 'Chiết khấu : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.costFee.discount.toString() + '% ~ ' + dataCheckManager.getStringNumber(widget.order.costFee.discount/100 * widget.order.cost).toString() + ' VNĐ',
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
                            text: 'Phí mỗi km : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.order.costFee.perKMcost).toString() + ' VNĐ',
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
            width: widget.width/6-1,
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
                            text: 'Giờ khởi tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.startTime.hour.toString() + " giờ " + widget.order.startTime.minute.toString() + " phút " + widget.order.startTime.second.toString(), // Phần còn lại viết bình thường
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
                            text: 'Ngày khởi tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: "Ngày " + widget.order.startTime.day.toString() + "/" + widget.order.startTime.month.toString() + "/" + widget.order.startTime.year.toString(), // Phần còn lại viết bình thường
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
        ],
      ),
    );
  }
}
