import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bills/component/colors.dart';
import 'package:my_bills/controllers/data_controllers.dart';
import 'package:my_bills/pages/payment_page.dart';
import 'package:my_bills/widget/buttons.dart';
import 'package:my_bills/widget/large_button.dart';
import 'package:my_bills/widget/text_size.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataController _controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    print(_controller.list);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        height: h,
        child: Stack(
          children: [
            _headSection(),
            Obx(() {
              if (_controller.loading == false) {
                return Center(
                  child: Container(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                );
              } else {
                return _listBills();
              }
            }),
            _payButton(),
          ],
        ),
      ),
    );
  }

  _headSection() {
    return Container(
      height: 310,
      child: Stack(
        children: [
          _mainBackground(),
          //_curveImageContainer(),
          _buttonContainer(),
          _textContainer(),
        ],
      ),
    );
  }

  _buttonContainer() {
    return Positioned(
        right: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 240,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            color: Color(0xFFeef1f4).withOpacity(0.7),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 300,
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 25),
                              width: 60,
                              height: 250,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(29)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppButtons(
                                    icon: Icons.cancel,
                                    iconColor: AppColor.mainColor,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  AppButtons(
                                    icon: Icons.add,
                                    iconColor: AppColor.mainColor,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onTap: () {},
                                    text: "Add Bill",
                                  ),
                                  AppButtons(
                                    icon: Icons.history,
                                    iconColor: AppColor.mainColor,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onTap: () {},
                                    text: "History",
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                });
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                  // fit: BoxFit.cover,
                  image: AssetImage("images/lines.png"),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(-5, -5),
                    color: Color(0xFF11324d).withOpacity(0.2),
                  )
                ]),
          ),
        ));
  }

  _mainBackground() {
    return Positioned(
        bottom: 10,
        left: 0,
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/background.png"),
            ),
          ),
        ));
  }

  /* _curveImageContainer() {
    return Positioned(
        left: 0,
        right: -2,
        bottom: 10,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/curve.png"),
            ),
          ),
        ));
  }*/
  _listBills() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 320,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
            itemCount: _controller.list.length,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                ),
                height: 130,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        offset: Offset(1, 1),
                        color: Color(0xFFd8dbe0).withOpacity(0.2),
                        spreadRadius: 10,
                      )
                    ]),
                child: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.red,
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        _controller.list[index]["img"]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.list[index]["brand"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.mainColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Id:846594",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.idColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedText(
                              text: _controller.list[index]["more"],
                              color: AppColor.green),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.list[index]["status"] =
                                      !_controller.list[index]["status"];
                                  print(_controller.list[index]["status"]);
                                  _controller.list.refresh();
                                  print(_controller.newList.length);
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: _controller.list[index]
                                                  ["status"] ==
                                              false
                                          ? AppColor.selectBackground
                                          : AppColor.green),
                                  child: Center(
                                    child: Text(
                                      "Select",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: _controller.list[index]
                                                      ["status"] ==
                                                  false
                                              ? AppColor.selectColor
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "\$" + _controller.list[index]["due"],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.mainColor),
                              ),
                              Text(
                                "Due in 3 days",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.idColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 5,
                            height: 35,
                            decoration: BoxDecoration(
                                color: AppColor.halfOval,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  _payButton() {
    return Positioned(
      bottom: 20,
      child: AppLargeButton(
        text: "Pay all bills",
        textColor: Colors.white,
        onTap: () {
          Get.to(() => PaymentPage());
        },
      ),
    );
  }

  _textContainer() {
    return Stack(
      children: [
        Positioned(
            left: 90,
            top: 100,
            child: Text(
              "My Bills",
              style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF293952)),
            )),
      ],
    );
  }
}
