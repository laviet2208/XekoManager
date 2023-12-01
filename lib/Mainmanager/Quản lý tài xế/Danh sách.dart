import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/utils/utils.dart';

import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../Quản lý khách hàng/accountNormal.dart';
import 'Item danh sách.dart';

class danhsachtaixe extends StatefulWidget {
  final double width;
  final double height;
  const danhsachtaixe({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<danhsachtaixe> createState() => _danhsachtaixeState();
}

class _danhsachtaixeState extends State<danhsachtaixe> {
  List<accountNormal> accountList = [];
  List<accountNormal> chosenList = [];
  List<Area> areaList = [];
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final TextEditingController name = TextEditingController();
  final TextEditingController money = TextEditingController();

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('CCCD').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").onValue.listen((event) {
      accountList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountNormal food= accountNormal.fromJson(value);
        if (food.type == 2) {
          accountList.add(food);
          chosenList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
      });
    });
  }

  Future<void> pushData(accountNormal account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser').child(account.id).set(account.toJson());
      toastMessage('Thay đổi thông tin thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = accountList
          .where((account) =>
      account.phoneNum.toLowerCase().contains(value.toLowerCase()) || account.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          chosenList.add(accountList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          if (accountList.elementAt(i).Area == chosenArea.id) {
            chosenList.add(accountList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

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
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
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
                    hintText: 'Tìm kiếm theo tên và số điện thoại',
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
              top: 70,
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Tài khoản',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Vị trí được chọn',
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
                      width: (widget.width - 20)/6 - 1,
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thuộc khu vực',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Ngày khởi tạo',
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
                      width: (widget.width - 20)/6 - 1,
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
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 400,
                height: 40,
                child: DropdownButton<Area>(
                  items: areaList1.map((e) => DropdownMenuItem<Area>(
                    value: e,
                    child: Text('Khu vực : ' + e.name),
                  )).toList(),
                  onChanged: (value) { dropdownCallback(value); },
                  value: chosenArea,
                  iconEnabledColor: Colors.redAccent,
                  isExpanded: true,
                  iconDisabledColor: Colors.grey,
                ),
              ),
            ),

            Positioned(
              top: 125,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 135,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                    itemCount: chosenList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsachtaixe(width: widget.width, height: 120, account: chosenList[index],
                        onTapUpdate: () async {
                          name.text = chosenList[index].name.toString();
                          money.text = chosenList[index].totalMoney.toString();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cập nhật thông tin tài xế'),
                                  content: Container(
                                    width: 500, // Đặt kích thước chiều rộng theo ý muốn
                                    height: 600, // Đặt kích thước chiều cao theo ý muốn
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
                                            'Tên trong app',
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
                                                    controller: name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'roboto',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Tên trong app',
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
                                            'Số dư(VNĐ)',
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
                                                    controller: money,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'roboto',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Số dư tài khoản',
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
                                            'Chọn khu vực',
                                            style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 20,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: 180,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 0,
                                                  left: 30,
                                                  child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey
                                                      ),
                                                    ),
                                                    child: FutureBuilder(
                                                      future: _getImageURL(chosenList[index].id + '_LT.png'),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        }

                                                        if (snapshot.hasError) {
                                                          return Container(
                                                            alignment: Alignment.center,
                                                            child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                                                          );                                                        }

                                                        if (!snapshot.hasData) {
                                                          return Text('Image not found');
                                                        }

                                                        return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                                                      },
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  bottom: 0,
                                                  left: 30,
                                                  child: Container(
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Mặt sau Giấy phép',
                                                      style: TextStyle(
                                                          fontFamily: 'roboto',
                                                          fontSize: 14,
                                                          color: Colors.redAccent
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  bottom: 0,
                                                  right: 30,
                                                  child: Container(
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Mặt trước Giấy phép',
                                                      style: TextStyle(
                                                          fontFamily: 'roboto',
                                                          fontSize: 14,
                                                          color: Colors.redAccent
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  top: 0,
                                                  right: 30,
                                                  child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey
                                                      ),
                                                    ),
                                                    child: FutureBuilder(
                                                      future: _getImageURL(chosenList[index].id + '_LS.png'),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        }

                                                        if (snapshot.hasError) {
                                                          return Container(
                                                            alignment: Alignment.center,
                                                            child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                                                          );                                                        }

                                                        if (!snapshot.hasData) {
                                                          return Text('Image not found');
                                                        }

                                                        return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 20,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: 180,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 0,
                                                  left: 175,
                                                  child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey
                                                      ),
                                                    ),
                                                    child: FutureBuilder(
                                                      future: _getImageURL(chosenList[index].id + '_Ava.png'),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        }

                                                        if (snapshot.hasError) {
                                                          return Container(
                                                            alignment: Alignment.center,
                                                            child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                                                          );
                                                        }

                                                        if (!snapshot.hasData) {
                                                          return Text('Image not found');
                                                        }

                                                        return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                                                      },
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  bottom: 0,
                                                  left: 175,
                                                  child: Container(
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Ảnh chân dung',
                                                      style: TextStyle(
                                                          fontFamily: 'roboto',
                                                          fontSize: 14,
                                                          color: Colors.redAccent
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 20,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: 150,
                                            child: searchPageArea(list: areaList, area: area,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        area.id = '';
                                        name.clear();
                                        money.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child:Text('Lưu'),
                                      onPressed: () async {
                                        if (name.text.isNotEmpty && area.id != '' && money.text.isNotEmpty) {
                                          chosenList[index].name = name.text.toString();
                                          chosenList[index].Area = area.id;
                                          await pushData(chosenList[index]);
                                          area.id = '';
                                          name.clear();
                                          money.clear();
                                          Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Điền đủ các mục rồi tiếp tục');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }
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
