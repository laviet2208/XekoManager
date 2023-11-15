import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/DropList%20th%E1%BB%83%20lo%E1%BA%A1i.dart';
import 'package:xekomanagermain/dataClass/accountShop.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'ITEMinPage.dart';

class PageQuanlyshop extends StatefulWidget {
  final double width;
  final double height;
  const PageQuanlyshop({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<PageQuanlyshop> createState() => _PageQuanlyshopState();
}

class _PageQuanlyshopState extends State<PageQuanlyshop> {
  final tennhahangcontrol = TextEditingController();
  final sdtcontrol = TextEditingController();
  final avatarcontrol = TextEditingController();
  final locationcontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final startcontrol = TextEditingController();
  final endcontrol = TextEditingController();
  final List<accountShop> shopList = [];
  List<accountShop> chosenList = [];
  List<String> items = ['5 sao','Ăn vặt','Bún phở','Cơm','Khuyến mãi','Món nhậu','Nước uống','Thức ăn nhanh','Trà sữa'];
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '');
  int selectIndex = 0;
  bool loading = false;

  List<Area> areaList = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(accountShop accountShop) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(accountShop.id).set(accountShop.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm nhà hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        shopList.add(food);
        chosenList.add(food);
      });
      setState(() {

      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = shopList
          .where((account) =>
          account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.phoneNum.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
  }

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
              onTap: () {
                showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm nhà hàng mới'),
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
                                'Tên nhà hàng *',
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
                                        controller: tennhahangcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tên nhà hàng',
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
                                'Số điện thoại shop *',
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
                                        controller: sdtcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Số điện thoại cũng là tên đăng nhập',
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
                                        controller: avatarcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Nhập vào liên kết ảnh đại diện của shop',
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
                                'Vị trí của nhà hàng *',
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
                                        controller: locationcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Định dạng vị trí : "Vĩ độ,Kinh độ"',
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
                                'Mật khẩu nhà hàng *',
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
                                        controller: passcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Nhập mật khẩu của nhà hàng',
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
                                'Giờ mở cửa nhà hàng *',
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
                                        controller: startcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Nhập giờ mở cửa , định dạng : "giờ/phút/giây"',
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
                                'Giờ đóng cửa nhà hàng *',
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
                                        controller: endcontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Nhập giờ đóng cửa , định dạng : "giờ/phút/giây"',
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
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Chọn phân loại nhà hàng *',
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
                                child: Droplistnhahang(width: widget.width * (1.5/3), shop: shop)
                            ),

                            Container(
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Chọn khu vực quản lý *',
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
                                child: searchPageArea(list: areaList, area: area,),
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
                            tennhahangcontrol.clear();
                            passcontrol.clear();
                            startcontrol.clear();
                            endcontrol.clear();
                            avatarcontrol.clear();
                            sdtcontrol.clear();
                            locationcontrol.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: loading ? CircularProgressIndicator() : Text('Lưu'),
                          onPressed: loading ? null : () async {
                            setState(() {
                              loading = true;
                            });

                            if (tennhahangcontrol.text.isNotEmpty && passcontrol.text.isNotEmpty && startcontrol.text.isNotEmpty && area.id != ''
                                && endcontrol.text.isNotEmpty && avatarcontrol.text.isNotEmpty && locationcontrol.text.isNotEmpty && sdtcontrol.text.isNotEmpty) {
                                accountShop shop = accountShop(
                                    openTime: Time(second: dataCheckManager.extractYear(startcontrol.text.toString()), minute: dataCheckManager.extractMonth(startcontrol.text.toString()), hour: dataCheckManager.extractDay(startcontrol.text.toString()), day: 0, month: 0, year: 0),
                                    closeTime: Time(second: dataCheckManager.extractYear(endcontrol.text.toString()), minute: dataCheckManager.extractMonth(endcontrol.text.toString()), hour: dataCheckManager.extractDay(endcontrol.text.toString()), day: 0, month: 0, year: 0),
                                    phoneNum: sdtcontrol.text.toString(),
                                    location: locationcontrol.text.toString(),
                                    name: tennhahangcontrol.text.toString(),
                                    id: dataCheckManager.generateRandomString(20),
                                    status: 1,
                                    avatarID: avatarcontrol.text.toString(),
                                    createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                    password: passcontrol.text.toString(),
                                    isTop: 1,
                                    Type: selectIndex, ListDirectory: [],
                                    Area: area.id);
                                await pushData(shop);
                                setState(() {
                                  loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                });

                                tennhahangcontrol.clear();
                                passcontrol.clear();
                                startcontrol.clear();
                                endcontrol.clear();
                                avatarcontrol.clear();
                                sdtcontrol.clear();
                                locationcontrol.clear();

                                Navigator.of(context).pop();
                            } else {
                              toastMessage('Phải nhập đủ thông tin');
                              setState(() {
                                loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                              });
                            }
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
            top: 80,
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tên nhà hàng',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian tạo',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian hoạt động',
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
                    width: (widget.width - 20)/5 - 60,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái tài khoản',
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
                    width: (widget.width - 20)/5 - 1 + 60,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
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
                ],
              ),
            ),
          ),

          Positioned(
            top: 130,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 155,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              alignment: Alignment.center,
              child: (chosenList.length == 0) ? Text('không có nhà hàng nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ITEMshop(width: widget.width - 20, height: 120, shop: chosenList[index],
                    updateEvent: () {

                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),);
                },
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 150,
            child: Container(
              width: 500,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm nhà hàng',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
