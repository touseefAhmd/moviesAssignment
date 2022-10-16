import 'package:assignment_123/res/colors.dart';
import 'package:assignment_123/res/components/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeatMapping extends StatefulWidget {
  const SeatMapping({Key? key}) : super(key: key);

  @override
  State<SeatMapping> createState() => _SeatMappingState();
}

class _SeatMappingState extends State<SeatMapping> {
  var countSeatSelectLeft = 3 * 10;
  var countSeatSelectCenter = 4 * 10;
  var countSeatSelectRight = 3 * 10;
  var listSeatSelectLeft = [];
  var listSeatSelectCenter = [];
  var listSeatSelectRight = [];
  initSeatValue(List data, count, side) {
    var objectData;
    for (int i = 0; i < count; i++) {
      objectData = {
        'id': 'side' + '${i + 1}',
        'isBooked': false,
        'isAvailable': true,
        'isSelected': false,
        'isVisible': true,
      };
      data.add(objectData);
    }
    print(data);
  }
  seVisibilitySeat(){
    setState(() {
      listSeatSelectLeft[0]['isVisible']=false;
      listSeatSelectLeft[1]['isVisible']=false;
      listSeatSelectLeft[3]['isVisible']=false;
      listSeatSelectRight[1]['isVisible']=false;
      listSeatSelectRight[2]['isVisible']=false;
      listSeatSelectRight[5]['isVisible']=false;
    });
  }
bookSelected(){
    listSeatSelectLeft.forEach((seat) {
      if(seat['isSelected']){
        setState(() {
          seat['isBooked']=true;
        });
      }
    });
    listSeatSelectCenter.forEach((seat) {
      if(seat['isSelected']){
        setState(() {
          seat['isBooked']=true;
        });
      }
    });
    listSeatSelectRight.forEach((seat) {
      if(seat['isSelected']){
        setState(() {
          seat['isBooked']=true;
        });
      }
    });

}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSeatValue(listSeatSelectLeft, countSeatSelectLeft, 'l');
    initSeatValue(listSeatSelectCenter, countSeatSelectCenter, 'c');
    initSeatValue(listSeatSelectRight, countSeatSelectRight, 'r');
    seVisibilitySeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleColor,
      appBar: AppBar(
        backgroundColor:AppColors.purpleColor,
        centerTitle: true,
        toolbarHeight: 75,
        title:Text('Reserve Your Seat'),
        // shape: RoundedRectangleBorder(
        //     borderRadius:  BorderRadius.only(
        //         bottomRight: Radius.circular(70),
        //         bottomLeft: Radius.circular(70))
        //
        // ),

      ),
      body: Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Center(
              child: Container(
                 child: Text('Seat Selection'),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
             child: Row(
               children: [
                 Expanded(child: Container(
                   child: Row(
                     children: [
                       Container(
                         width: 20,
                         height: 20,
                         decoration: BoxDecoration(color: AppColors.grayColor,borderRadius: BorderRadius.circular(4)),
                       ),
                       SizedBox(width: 4,),
                       Text('Booked')
                     ],
                   ),

                 )),
                 Expanded(child: Container(
                   child: Row(
                     children: [
                       Container(
                         width: 20,
                         height: 20,
                         decoration: BoxDecoration(color: AppColors.whiteColor,borderRadius: BorderRadius.circular(4)),
                       ),
                       SizedBox(width: 4,),
                       Text('Selected')
                     ],
                   ),

                 )),
                 Expanded(child: Container(
                   child: Row(
                     children: [
                       Container(
                         width: 20,
                         height: 20,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),border: Border.all(
                           color:AppColors.grayColor
                         )),
                       ),
                       SizedBox(width: 4,),
                       Text('Available')
                     ],
                   ),

                 ))
               ],
             ),
            ),
            SizedBox(height: 50,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widgetSeat(listSeatSelectLeft,false),
                  SizedBox(width: 20,),
                  Expanded(child:  widgetSeat(listSeatSelectCenter,true)),
                  SizedBox(width: 20,),
                  widgetSeat(listSeatSelectRight,false)
                ],
              ),),
            SizedBox(height: 10,),
            RoundButton(
                title: 'Book Now', callBack: (){bookSelected();},color: AppColors.whiteColor,)
          ],
        ),
      ),
    );
  }
  Widget widgetSeat(List dataSeat,isCenter){
    return Container(
        width: 87,
        child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isCenter?4:3,
          childAspectRatio: isCenter?0.9:1
        ),
        itemCount: listSeatSelectLeft.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return Visibility(
            visible: dataSeat[index]['isVisible'],
            child: GestureDetector(
              onTap: (){
                setState(() {
                  dataSeat[index]['isSelected']=!dataSeat[index]['isSelected'];
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: dataSeat[index]['isBooked']?AppColors.grayColor:
                  dataSeat[index]['isSelected']?
                  AppColors.whiteColor:
                      Colors.transparent,
                  border: Border.all(color: AppColors.grayColor),
                  borderRadius: BorderRadius.circular(4)
                ),
              ),
            ),
          );
    }));
  }
}