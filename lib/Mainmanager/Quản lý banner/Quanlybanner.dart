import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Itembanner.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/page%20t%C3%ACm%20ki%E1%BA%BFm.dart';
import 'package:xekomanagermain/dataClass/Ads/ADStype1.dart';
import 'package:xekomanagermain/dataClass/Time.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class Quanlybanner extends StatefulWidget {
  final double width;
  final double height;
  const Quanlybanner({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Quanlybanner> createState() => _QuanlybannerState();
}

class _QuanlybannerState extends State<Quanlybanner> {
  List<ADStype1> adsList = [];
  List<accountShop> shopList = [];
  final accountShop selectShop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '');
  String query = '';
  bool loading = false;
  int lengthSearch = 0;
  List<accountShop> filteredList = [];
  final mainContentcontrol = TextEditingController();
  final secondaryControl = TextEditingController();
  final mainImagecontrol = TextEditingController();

  Future<void> pushData(ADStype1 adStype1) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype1').child(adStype1.id).set(adStype1.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype1").onValue.listen((event) {
      adsList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ADStype1 food= ADStype1.fromJson(value);
        adsList.add(food);
      });
      setState(() {

      });
    });
  }

  void getRestaurantData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        shopList.add(food);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 240,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    '+ Thêm mới banner cửa hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'arial',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm Banner mới'),
                        content: Container(
                          width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                          height: widget.height * (2/3), // Đặt kích thước chiều cao theo ý muốn
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
                                  'Tên sự kiện *',
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
                                      child: Form(
                                        child: TextFormField(
                                          controller: mainContentcontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Dòng chữ in đậm to nhất',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
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
                                  'Dòng mô tả sự kiện *',
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
                                      child: Form(
                                        child: TextFormField(
                                          controller: secondaryControl,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Dòng chữ bé hơn nằm dưới dòng mô tả chỉnh',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
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
                                  'Liên kết ảnh đại diện *',
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
                                      child: Form(
                                        child: TextFormField(
                                          controller: mainImagecontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Nhập vào liên kết ảnh đại diện của sự kiện',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
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
                                  'Chọn nhà hàng *',
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
                                  height: 150,
                                  child: searchPage(list: shopList, selectShop: selectShop,),
                                ),

                              ),


                              
                              Container(
                                height: 40,
                              ),

                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: loading ? CircularProgressIndicator() : Text('Lưu'),
                            onPressed: loading ? null : () async {
                              setState(() {
                                loading = true;
                              });
                              if (mainContentcontrol.text.isNotEmpty && mainImagecontrol.text.isNotEmpty && secondaryControl.text.isNotEmpty) {
                                if (selectShop.id != '') {
                                  ADStype1 ads = ADStype1(
                                      mainContent: mainContentcontrol.text.toString(),
                                      secondaryText: secondaryControl.text.toString(),
                                      mainImage: mainImagecontrol.text.toString(),
                                      shop: selectShop,
                                      id: dataCheckManager.generateRandomString(12)
                                  );
                                  await pushData(ads);
                                  selectShop.id = '';
                                  mainImagecontrol.clear();
                                  secondaryControl.clear();
                                  mainImagecontrol.clear();
                                }
                              } else {
                                toastMessage('Điền đủ thông tin trước');
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 70,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: 100,
                decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 240, 242, 245)
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 40,
                      left: 10,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'ID của banner',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/6,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/6 + 12,
                      child: Container(
                        width: widget.width/5,
                        height: 20,
                        child: AutoSizeText(
                          'Tên sự kiện',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/6 + widget.width/5 + 12,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 10 + widget.width/6 + widget.width/5 + 22,
                      child: Container(
                        width: widget.width/5,
                        height: 20,
                        child: AutoSizeText(
                          'Liên kết ảnh đại diện',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 10 + widget.width/6 + widget.width/5 + 32 + widget.width/5,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 52 + widget.width/6 + widget.width/5 + widget.width/5,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'Tên shop liên kết',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      left: 52 + widget.width/3 + 2 * widget.width/5 + 10,
                      child: Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 52 + widget.width/3 + 2 * widget.width/5 + 20,
                      child: Container(
                        width: widget.width/6,
                        height: 20,
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 175,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 190,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                  itemCount: adsList.length,
                  itemBuilder: (context, index) {
                    return ITEMbanner(width: widget.width - 20, height: 120, adStype1: adsList[index],
                      updateEvent: () {
                        mainContentcontrol.text = adsList[index].mainContent;
                        secondaryControl.text = adsList[index].secondaryText;
                        mainImagecontrol.text = adsList[index].mainImage;
                        selectShop.id = adsList[index].id;
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Thêm Banner mới'),
                              content: Container(
                                width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                                height: widget.height * (2/3), // Đặt kích thước chiều cao theo ý muốn
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
                                        'Tên sự kiện *',
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
                                            child: Form(
                                              child: TextFormField(
                                                controller: mainContentcontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Dòng chữ in đậm to nhất',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
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
                                        'Dòng mô tả sự kiện *',
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
                                            child: Form(
                                              child: TextFormField(
                                                controller: secondaryControl,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Dòng chữ bé hơn nằm dưới dòng mô tả chỉnh',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
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
                                        'Liên kết ảnh đại diện *',
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
                                            child: Form(
                                              child: TextFormField(
                                                controller: mainImagecontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nhập vào liên kết ảnh đại diện của sự kiện',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                ),
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
                                        'Chọn nhà hàng *',
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
                                        height: 150,
                                        child: searchPage(list: shopList, selectShop: selectShop,),
                                      ),

                                    ),



                                    Container(
                                      height: 40,
                                    ),

                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                  onPressed: loading ? null : () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (mainContentcontrol.text.isNotEmpty && mainImagecontrol.text.isNotEmpty && secondaryControl.text.isNotEmpty) {
                                      if (selectShop.id != '') {
                                        ADStype1 ads = ADStype1(
                                            mainContent: mainContentcontrol.text.toString(),
                                            secondaryText: secondaryControl.text.toString(),
                                            mainImage: mainImagecontrol.text.toString(),
                                            shop: selectShop,
                                            id: adsList[index].id
                                        );
                                        await pushData(ads);
                                        selectShop.id = '';
                                        mainImagecontrol.clear();
                                        secondaryControl.clear();
                                        mainImagecontrol.clear();
                                      }
                                    } else {
                                      toastMessage('Điền đủ thông tin trước');
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
