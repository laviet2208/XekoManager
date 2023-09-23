import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/FinalClass.dart';
import 'package:xekomanagermain/dataClass/Time.dart';
import 'package:xekomanagermain/dataClass/dataCheckManager.dart';
import 'package:xekomanagermain/utils/utils.dart';

import '../../Mainmanager/Quản lý voucher/ITEMdanhsach.dart';
import '../../Mainmanager/Quản lý voucher/Voucher.dart';

class Danhsachvoucher extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachvoucher({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachvoucher> createState() => _DanhsachvoucherState();
}

class _DanhsachvoucherState extends State<Danhsachvoucher> {
  final tenchuongtrinhcontrol = TextEditingController();
  final macodecontrol = TextEditingController();
  final ngaybatdaucontrol = TextEditingController();
  final ngayketthuccontrol = TextEditingController();
  final sotiengiamcontrol = TextEditingController();
  final toithieugiamcontrol = TextEditingController();
  final toidacontrol = TextEditingController();
  bool loading = false;

  final List<Voucher> voucherList = [];


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

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Voucher voucher= Voucher.fromJson(value);
        if (voucher.LocationId == currentAccount.provinceCode) {
          voucherList.add(voucher);
        }
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
                        title: Text('Thêm mã khuyến mãi'),
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
                                  'Tên chương trình *',
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
                                          controller: tenchuongtrinhcontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tên chương trình',
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
                                  'Mã code *',
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
                                          controller: macodecontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Mã code',
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
                                  'Ngày bắt đầu *',
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
                                          controller: ngaybatdaucontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Ngày bắt đầu(Nhập đúng định dạng : ngày/tháng/năm)',
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
                                  'Ngày kết thúc *',
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
                                          controller: ngayketthuccontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Ngày kết thúc(Nhập đúng định dạng : ngày/tháng/năm)',
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
                                  'Số tiền giảm *',
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
                                          controller: sotiengiamcontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Số tiền giảm(VNĐ - chỉ nhập mình số)',
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
                                  'Áp dụng cho đơn từ *',
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
                                          controller: toithieugiamcontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Áp dụng cho đơn từ(VNĐ - chỉ nhập mình số)',
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
                                  'Số lượng tối đa *',
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
                                          controller: toidacontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tối đa',
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

                              if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty
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
                                      LocationId: currentAccount.provinceCode
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
              left: 140,
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
                    'Xuất danh sách voucher',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'arial',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {

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
                          'Thời gian',
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
                          'Số tiền giảm (VNĐ)',
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
                          'Đã sử dụng',
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
                    itemCount: voucherList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsach(width: widget.width - 20, height: 150, voucher: voucherList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                        onTapUpdate: () {
                        tenchuongtrinhcontrol.text = voucherList[index].tenchuongtrinh;
                        macodecontrol.text = voucherList[index].id;
                        ngayketthuccontrol.text = voucherList[index].endTime.day.toString() + "/" + voucherList[index].endTime.month.toString() + "/" + voucherList[index].endTime.year.toString();
                        ngaybatdaucontrol.text = voucherList[index].startTime.day.toString() + "/" + voucherList[index].startTime.month.toString() + "/" + voucherList[index].startTime.year.toString();
                        sotiengiamcontrol.text = voucherList[index].totalmoney.toString();
                        toithieugiamcontrol.text = voucherList[index].mincost.toString();
                        toidacontrol.text = voucherList[index].maxCount.toString();
                        showDialog (
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thêm mã khuyến mãi'),
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
                                          'Tên chương trình *',
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
                                                  controller: tenchuongtrinhcontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Tên chương trình',
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
                                          'Mã code *',
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
                                                  enabled: false,
                                                  controller: macodecontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Mã code',
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
                                          'Ngày bắt đầu *',
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
                                                  controller: ngaybatdaucontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Ngày bắt đầu(Nhập đúng định dạng : ngày/tháng/năm)',
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
                                          'Ngày kết thúc *',
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
                                                  controller: ngayketthuccontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Ngày kết thúc(Nhập đúng định dạng : ngày/tháng/năm)',
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
                                          'Số tiền giảm *',
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
                                                  controller: sotiengiamcontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Số tiền giảm(VNĐ - chỉ nhập mình số)',
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
                                          'Áp dụng cho đơn từ *',
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
                                                  controller: toithieugiamcontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Áp dụng cho đơn từ(VNĐ - chỉ nhập mình số)',
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
                                          'Số lượng tối đa *',
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
                                                  controller: toidacontrol,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'arial',
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Tối đa',
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
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),
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

                                      if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty
                                          && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty) {
                                        if (dataCheckManager.isPositiveDouble(toithieugiamcontrol.text.toString()) && dataCheckManager.isPositiveDouble(sotiengiamcontrol.text.toString())
                                            && dataCheckManager.isPositiveInteger(toidacontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngaybatdaucontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngayketthuccontrol.text.toString())) {
                                          Voucher voucher = Voucher(
                                              id: macodecontrol.text.toString(),
                                              totalmoney: double.parse(sotiengiamcontrol.text.toString()),
                                              mincost: double.parse(toithieugiamcontrol.text.toString()),
                                              startTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngaybatdaucontrol.text.toString()), month: dataCheckManager.extractMonth(ngaybatdaucontrol.text.toString()), year: dataCheckManager.extractYear(ngaybatdaucontrol.text.toString())),
                                              endTime: Time(second: 0, minute: 0, hour: 0, day: dataCheckManager.extractDay(ngayketthuccontrol.text.toString()), month: dataCheckManager.extractMonth(ngayketthuccontrol.text.toString()), year: dataCheckManager.extractYear(ngayketthuccontrol.text.toString())),
                                              useCount: voucherList[index].useCount,
                                              maxCount: int.parse(toidacontrol.text.toString()),
                                              tenchuongtrinh: tenchuongtrinhcontrol.text.toString(),
                                              LocationId: currentAccount.provinceCode
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
                        },);
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
