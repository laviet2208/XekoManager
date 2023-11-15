import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';

class Xemdanhsachmonan extends StatefulWidget {
  final double width;
  final double height;
  final accountShop shop;
  const Xemdanhsachmonan({Key? key, required this.width, required this.height, required this.shop}) : super(key: key);

  @override
  State<Xemdanhsachmonan> createState() => _XemdanhsachmonanState();
}

class _XemdanhsachmonanState extends State<Xemdanhsachmonan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: (widget.width - 20)/10,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Hình ảnh',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/5,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tên món ăn',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/8,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Giá tiền(VNĐ)',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: widget.width - ((widget.width - 20)/8) - ((widget.width - 20)/5) - ((widget.width - 20)/10) - 3,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
