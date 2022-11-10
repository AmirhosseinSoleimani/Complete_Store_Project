import 'package:complete_advanced_project/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_project/presentation/resources/color_manager.dart';
import 'package:complete_advanced_project/presentation/resources/string_manager.dart';
import 'package:complete_advanced_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
    SliderObject(
        AppString.onBoardingSubTitle1,
        AppString.onBoardingTitle1,
        ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      AppString.onBoardingSubTitle2,
      AppString.onBoardingTitle2,
      ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      AppString.onBoardingSubTitle3,
      AppString.onBoardingTitle3,
      ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      AppString.onBoardingSubTitle4,
      AppString.onBoardingTitle4,
      ImageAssets.onBoardingLogo4,
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
          },
          itemBuilder: (context,index){
            // return OnBoardingPage
          })
    );
  }
}

class SliderObject{
  String title;
  String subTitle;
  String image;
  SliderObject(this.title,this.subTitle,this.image);
}
