import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Data/itemsendOrder.dart';

class ViewLogItemSend extends StatefulWidget {
  final double screenWidth;
  final itemsendOrder thiscatch;
  const ViewLogItemSend({Key? key, required this.screenWidth, required this.thiscatch}) : super(key: key);

  @override
  State<ViewLogItemSend> createState() => _ViewLogItemSendState();
}

class _ViewLogItemSendState extends State<ViewLogItemSend> {
  String finalStatus = 'Hoàn thành';

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.thiscatch.status == "D") {
      finalStatus = "Hoàn thành";
    }

    if (widget.thiscatch.status == "G") {
      finalStatus = 'Bị hủy bởi shipper';
    }

    if (widget.thiscatch.status == "E" ||widget.thiscatch.status == "F") {
      finalStatus = 'Bị hủy bởi người đặt';
    }

    if (widget.thiscatch.status == "H") {
      finalStatus = 'Người nhận không lấy hàng';
    }

    if (widget.thiscatch.status == "H1") {
      finalStatus = 'Bị hủy bởi admin tổng';
    }

    if (widget.thiscatch.status == "H2") {
      finalStatus = 'Bị hủy bởi admin khu vực';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(height: 10,),

        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: AutoSizeText(
                'Xem Log đơn',
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),

        Container(height: 10,),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.thiscatch.status == 'A') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  height: 30,
                  width: widget.screenWidth - 40 - 30 - 30,
                  child: AutoSizeText(
                    'Đang đợi tài xế nhận đơn',
                    style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: (widget.thiscatch.status == 'A') ?  FontWeight.bold : FontWeight.normal
                    ),
                  ),
                ),
              ),

              Container(
                width: 10,
              ),
            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.thiscatch.status == 'B') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  height: 30,
                  width: widget.screenWidth - 40 - 30 - 30,
                  child: AutoSizeText(
                    'Tài xế đang đến lấy hàng',
                    style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: (widget.thiscatch.status == 'B') ?  FontWeight.bold : FontWeight.normal
                    ),
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.thiscatch.status == 'C') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  height: 30,
                  width: widget.screenWidth - 40 - 30 - 30,
                  child: AutoSizeText(
                    'Tài xế đã nhận hàng từ bạn',
                    style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: (widget.thiscatch.status == 'C') ?  FontWeight.bold : FontWeight.normal
                    ),
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.thiscatch.status == 'E' || widget.thiscatch.status == 'F' || widget.thiscatch.status == 'G' || widget.thiscatch.status == 'H' || widget.thiscatch.status == 'D') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  height: 30,
                  width: widget.screenWidth - 40 - 30 - 30,
                  child: AutoSizeText(
                    finalStatus,
                    style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: (widget.thiscatch.status == 'E' || widget.thiscatch.status == 'F' || widget.thiscatch.status == 'G' || widget.thiscatch.status == 'H' || widget.thiscatch.status == 'I' || widget.thiscatch.status == 'J' || widget.thiscatch.status == 'D1') ?  FontWeight.bold : FontWeight.normal
                    ),
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(height: 20,),
      ],
    );
  }
}
