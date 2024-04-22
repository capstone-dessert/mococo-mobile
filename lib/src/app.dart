import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/image_data.dart';

 // 버튼 네비게이션, 인덱스 설정

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => {
        if (false){
            // if (closeOnConfirm()){
            //     SystemNavigator.pop()
            //   }
        }
        // else
        //   {context.go('/')}
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 105,leadingWidth:500,leading: Column( mainAxisAlignment: MainAxisAlignment.center, children: [Padding(padding: const EdgeInsets.only(left: 24,right:24, top:20),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Image.asset(IconPath.topLogo,width:170,),Image.asset(IconPath.add,width: 30,)],),)]  ),elevation: 0,),
        body: Container(
          // child: Image.asset(IconPath.topLogo,width: 200),
        ),
        bottomNavigationBar: BottomNavigationBar(showSelectedLabels: false,   // 선택된 아이템의 라벨을 숨깁니다.
          showUnselectedLabels: false, // 선택되지 않은 아이템의 라벨을 숨깁니다.
          items: [
            BottomNavigationBarItem(icon: Image.asset(IconPath.closetOff,width: 55,height: 55,),activeIcon: Image.asset(IconPath.closetOn,width: 55,height: 55),label: 'closet', ),
            BottomNavigationBarItem(icon: Image.asset(IconPath.codiRecommendOff,width: 55,height: 55),activeIcon: Image.asset(IconPath.codiRecommendOn,width: 55,height: 55),label: 'codiRecommend',),
            BottomNavigationBarItem(icon: Image.asset(IconPath.codiRecordOff,width: 55,height: 55),activeIcon: Image.asset(IconPath.codiRecordOn,width: 55,height: 55),label: 'codiRecord',),
          ],
        ),
      ),
    );
  }

  const App({super.key});
}
