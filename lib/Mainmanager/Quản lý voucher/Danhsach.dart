import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/Page%20t%C3%ACm%20nh%C3%A0%20h%C3%A0ng.dart';
import 'package:xekomanagermain/dataClass/Time.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';
import 'package:xekomanagermain/utils/utils.dart';

import '../../dataClass/accountShop.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'DropList chọn loại.dart';
import 'ITEMdanhsach.dart';
import 'Voucher.dart';

class Danhsachvoucher extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachvoucher({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachvoucher> createState() => _DanhsachvoucherState();
}

class _DanhsachvoucherState extends State<Danhsachvoucher> {
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '');
  final tenchuongtrinhcontrol = TextEditingController();
  final macodecontrol = TextEditingController();
  final ngaybatdaucontrol = TextEditingController();
  final ngayketthuccontrol = TextEditingController();
  final sotiengiamcontrol = TextEditingController();
  final toithieugiamcontrol = TextEditingController();
  final toidacontrol = TextEditingController();
  List<Area> areaList = [];
  List<accountShop> shopList = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);
  bool loading = false;
  final List<Voucher> voucherList = [];
  List<Voucher> chosenList = [];
  int index = 1;

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Voucher food= Voucher.fromJson(value);
        voucherList.add(food);
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(Voucher voucher) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage').child(voucher.id).set(voucher.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('đăng voucher thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

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

  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop area= accountShop.fromJson(value);
        shopList.add(area);
      });
      setState(() {

      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ngaybatdaucontrol.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
      });
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ngayketthuccontrol.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
      });
    }
  }

  Container getAddContainer(int type) {
    return Container(
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
              'Tên chương trình *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: tenchuongtrinhcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tên chương trình',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Mã code *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: macodecontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mã code',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Ngày bắt đầu *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: ngaybatdaucontrol,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhấn chọn ngày bắt đầu',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'roboto',
                    ),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
          ),


          Container(
            height: 20,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Ngày kết thúc *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: ngayketthuccontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhấn chọn ngày kết thúc',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
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
              'Áp dụng cho đơn từ *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: toithieugiamcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Áp dụng cho đơn từ(VNĐ - chỉ nhập mình số)',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Số lượng tối đa *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: toidacontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tối đa',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Đối tượng áp dụng *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
              child: Droplisttype(width: widget.width * (1.5/3), shop: shop)
          ),

          Container(
            height: 20,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Số tiền/phần trăm giảm *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: sotiengiamcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: (shop.status == 0) ? 'Giảm theo tiền cứng(VNĐ - chỉ nhập mình số)' : 'Giảm theo phần trăm(số % không có phần thập phân và bé hơn 100)',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              (type == 1) ? 'Chọn khu vực' : 'Chọn nhà hàng',
              style: TextStyle(
                  fontFamily: 'roboto',
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
              child: (type == 1) ? searchPageArea(list: areaList, area: area,) : searchResArea(list: shopList, shop: shop),
            ),

          ),

          Container(
            height: 40,
          ),
        ],
      ),
    );
  }

  Container getEditContainer(int type) {
    return Container(
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
              'Tên chương trình *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: tenchuongtrinhcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tên chương trình',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Mã code *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: macodecontrol,
                      enabled: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mã code',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Ngày bắt đầu *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: ngaybatdaucontrol,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhấn chọn ngày bắt đầu',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'roboto',
                    ),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
          ),

          Container(
            height: 20,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Ngày kết thúc *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: ngayketthuccontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhấn chọn ngày kết thúc',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
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
              'Áp dụng cho đơn từ *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: toithieugiamcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Áp dụng cho đơn từ(VNĐ - chỉ nhập mình số)',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Số lượng tối đa *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: toidacontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tối đa',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              'Đối tượng áp dụng *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
              child: Droplisttype(width: widget.width * (1.5/3), shop: shop)
          ),

          Container(
            height: 20,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Số tiền/phần trăm giảm *',
              style: TextStyle(
                  fontFamily: 'roboto',
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
                      controller: sotiengiamcontrol,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'roboto',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: (shop.status == 0) ? 'Giảm theo tiền cứng(VNĐ - chỉ nhập mình số)' : 'Giảm theo phần trăm(số % không có phần thập phân và bé hơn 100)',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'roboto',
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
              (type == 1) ? 'Chọn khu vực' : 'Chọn nhà hàng',
              style: TextStyle(
                  fontFamily: 'roboto',
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
              child: (type == 1) ? searchPageArea(list: areaList, area: area,) : searchResArea(list: shopList, shop: shop),
            ),

          ),

          Container(
            height: 40,
          ),
        ],
      ),
    );
  }

  void chosenData(int init) {
    if (init == 1) {
      chosenList.clear();
      for (Voucher vou in voucherList) {
        if (vou.Otype == '1') {
          chosenList.add(vou);
        }
      }
    }

    if (init == 2) {
      chosenList.clear();
      for (Voucher vou in voucherList) {
        if (vou.Otype != '1') {
          chosenList.add(vou);
        }
      }
    }
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = voucherList
          .where((account) =>
      account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.tenchuongtrinh.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.totalmoney.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.mincost.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.maxCount.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.useCount.toString().toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
    getData2();
    chosenData(1);
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
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    '+ Thêm mới voucher khách',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  area.id = '';
                  shop.id = '';
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm mã khuyến mãi khách hàng'),
                        content: getAddContainer(1),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Hủy'),
                            onPressed: () {
                              tenchuongtrinhcontrol.clear();
                              macodecontrol.clear();
                              ngaybatdaucontrol.clear();
                              ngayketthuccontrol.clear();
                              toithieugiamcontrol.clear();
                              sotiengiamcontrol.clear();
                              toidacontrol.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: loading ? CircularProgressIndicator() : Text('Lưu'),
                            onPressed: loading ? null : () async {
                              setState(() {
                                loading = true;
                              });

                              if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty && area.id != ''
                                  && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty) {
                                if (dataCheckManager.isPositiveDouble(toithieugiamcontrol.text.toString()) && dataCheckManager.isPositiveDouble(sotiengiamcontrol.text.toString())
                                    && dataCheckManager.isPositiveInteger(toidacontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngaybatdaucontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngayketthuccontrol.text.toString())) {
                                  Voucher voucher = Voucher(
                                      id: macodecontrol.text.toString(),
                                      totalmoney: double.parse(sotiengiamcontrol.text.toString()),
                                      mincost: double.parse(toithieugiamcontrol.text.toString()),
                                      startTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngaybatdaucontrol.text.toString()), month: dataCheckManager.extractMonth(ngaybatdaucontrol.text.toString()), year: dataCheckManager.extractYear(ngaybatdaucontrol.text.toString())),
                                      endTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngayketthuccontrol.text.toString()), month: dataCheckManager.extractMonth(ngayketthuccontrol.text.toString()), year: dataCheckManager.extractYear(ngayketthuccontrol.text.toString())),
                                      useCount: 0,
                                      maxCount: int.parse(toidacontrol.text.toString()),
                                      tenchuongtrinh: tenchuongtrinhcontrol.text.toString(),
                                      LocationId: area.id,
                                      type: shop.status,
                                      Otype: '1'
                                  );
                                  await pushData(voucher);
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });

                                  tenchuongtrinhcontrol.clear();
                                  macodecontrol.clear();
                                  ngaybatdaucontrol.clear();
                                  ngayketthuccontrol.clear();
                                  toithieugiamcontrol.clear();
                                  toidacontrol.clear();
                                  sotiengiamcontrol.clear();

                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Phải nhập đúng định dạng');
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });
                                }
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
              top: 10,
              left: 240,
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
                    '+ Thêm mới voucher nhà hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  area.id = '';
                  shop.id = '';
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm mã khuyến mãi riêng cho nhà hàng'),
                        content: getAddContainer(2),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Hủy'),
                            onPressed: () {
                              tenchuongtrinhcontrol.clear();
                              macodecontrol.clear();
                              ngaybatdaucontrol.clear();
                              ngayketthuccontrol.clear();
                              toithieugiamcontrol.clear();
                              sotiengiamcontrol.clear();
                              toidacontrol.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: loading ? CircularProgressIndicator() : Text('Lưu'),
                            onPressed: loading ? null : () async {
                              setState(() {
                                loading = true;
                              });

                              if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty && shop.id != ''
                                  && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty) {
                                if (dataCheckManager.isPositiveDouble(toithieugiamcontrol.text.toString()) && dataCheckManager.isPositiveDouble(sotiengiamcontrol.text.toString())
                                    && dataCheckManager.isPositiveInteger(toidacontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngaybatdaucontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngayketthuccontrol.text.toString())) {
                                  Voucher voucher = Voucher(
                                      id: macodecontrol.text.toString(),
                                      totalmoney: double.parse(sotiengiamcontrol.text.toString()),
                                      mincost: double.parse(toithieugiamcontrol.text.toString()),
                                      startTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngaybatdaucontrol.text.toString()), month: dataCheckManager.extractMonth(ngaybatdaucontrol.text.toString()), year: dataCheckManager.extractYear(ngaybatdaucontrol.text.toString())),
                                      endTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngayketthuccontrol.text.toString()), month: dataCheckManager.extractMonth(ngayketthuccontrol.text.toString()), year: dataCheckManager.extractYear(ngayketthuccontrol.text.toString())),
                                      useCount: 0,
                                      maxCount: int.parse(toidacontrol.text.toString()),
                                      tenchuongtrinh: tenchuongtrinhcontrol.text.toString(),
                                      LocationId: shop.Area,
                                      type: shop.status,
                                      Otype: shop.id
                                  );
                                  await pushData(voucher);
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });

                                  tenchuongtrinhcontrol.clear();
                                  macodecontrol.clear();
                                  ngaybatdaucontrol.clear();
                                  ngayketthuccontrol.clear();
                                  toithieugiamcontrol.clear();
                                  toidacontrol.clear();
                                  sotiengiamcontrol.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Phải nhập đúng định dạng');
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });
                                }
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
              top: 50,
              left: 600,
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
                    hintText: 'Tìm kiếm voucher',
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

            Positioned(
              top: 60,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (index == 1) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.blue
                      )
                  ),
                  child: Text(
                    '+ Voucher khách hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: (index == 1) ? Colors.white : Colors.blue,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 1;
                    chosenData(1);
                  });
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 230,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (index == 2) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: Colors.blue
                      )
                  ),
                  child: Text(
                    '+ Voucher nhà hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: (index == 2) ? Colors.white : Colors.blue,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  index = 2;
                  chosenData(2);
                  setState(() {

                  });
                },
              ),
            ),

            Positioned(
              top: 130,
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
                            'Tên sự kiện',
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
                            'Thời gian',
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
                            'Giá trị voucher',
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
                            'Lượt sử dụng',
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
              top: 190,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 205,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
                alignment: Alignment.center,
                child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                    itemCount: chosenList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsach(width: widget.width - 20, height: 120, voucher: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                        onTapUpdate: () {
                          tenchuongtrinhcontrol.text = chosenList[index].tenchuongtrinh;
                          macodecontrol.text = chosenList[index].id;
                          ngayketthuccontrol.text = chosenList[index].endTime.day.toString() + "/" + chosenList[index].endTime.month.toString() + "/" + chosenList[index].endTime.year.toString();
                          ngaybatdaucontrol.text = chosenList[index].startTime.day.toString() + "/" + chosenList[index].startTime.month.toString() + "/" + chosenList[index].startTime.year.toString();
                          sotiengiamcontrol.text = chosenList[index].totalmoney.toString();
                          toithieugiamcontrol.text = chosenList[index].mincost.toString();
                          toidacontrol.text = chosenList[index].maxCount.toString();
                          showDialog (
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Chỉnh sửa khuyến mãi'),
                                content: getEditContainer(index),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      tenchuongtrinhcontrol.clear();
                                      macodecontrol.clear();
                                      ngaybatdaucontrol.clear();
                                      ngayketthuccontrol.clear();
                                      toithieugiamcontrol.clear();
                                      sotiengiamcontrol.clear();
                                      toidacontrol.clear();
                                      shop.id != '';
                                      area.id != '';
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                    onPressed: loading ? null : () async {
                                      shop.id != '';
                                      area.id != '';
                                      setState(() {
                                        loading = true;
                                      });

                                      if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty && (area.id != '' || shop.id != '')
                                          && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty) {
                                        if (dataCheckManager.isPositiveDouble(toithieugiamcontrol.text.toString()) && dataCheckManager.isPositiveDouble(sotiengiamcontrol.text.toString())
                                            && dataCheckManager.isPositiveInteger(toidacontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngaybatdaucontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngayketthuccontrol.text.toString())) {
                                          Voucher voucher = Voucher(
                                              id: macodecontrol.text.toString(),
                                              totalmoney: double.parse(sotiengiamcontrol.text.toString()),
                                              mincost: double.parse(toithieugiamcontrol.text.toString()),
                                              startTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngaybatdaucontrol.text.toString()), month: dataCheckManager.extractMonth(ngaybatdaucontrol.text.toString()), year: dataCheckManager.extractYear(ngaybatdaucontrol.text.toString())),
                                              endTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngayketthuccontrol.text.toString()), month: dataCheckManager.extractMonth(ngayketthuccontrol.text.toString()), year: dataCheckManager.extractYear(ngayketthuccontrol.text.toString())),
                                              useCount: chosenList[index].useCount,
                                              maxCount: int.parse(toidacontrol.text.toString()),
                                              tenchuongtrinh: tenchuongtrinhcontrol.text.toString(),
                                              LocationId: (chosenList[index].Otype == '1') ? area.id : shop.Area,
                                              type: shop.status,
                                              Otype: (chosenList[index].Otype == '1') ? '1' : shop.id
                                          );
                                          await pushData(voucher);
                                          setState(() {
                                            loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                          });

                                          tenchuongtrinhcontrol.clear();
                                          macodecontrol.clear();
                                          ngaybatdaucontrol.clear();
                                          ngayketthuccontrol.clear();
                                          toithieugiamcontrol.clear();
                                          toidacontrol.clear();
                                          sotiengiamcontrol.clear();
                                          shop.id != '';
                                          area.id != '';
                                          Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Phải nhập đúng định dạng');
                                          setState(() {
                                            loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                          });
                                        }
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
                      );
                    }
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
