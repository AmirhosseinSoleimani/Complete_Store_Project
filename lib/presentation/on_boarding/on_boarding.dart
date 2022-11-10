import 'package:complete_advanced_project/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_project/presentation/resources/color_manager.dart';
import 'package:complete_advanced_project/presentation/resources/string_manager.dart';
import 'package:complete_advanced_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  final PageController _pageController = PageController(initialPage: 0);
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
        backgroundColor: ColorManager.white,
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
          return OnBoardingPage(
            _list[index]
          );
            // return OnBoardingPage
          }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: const Text(
                    AppString.skip,
                    textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget _getBottomSheetWidget(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // left arrow
      Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: (){
              // go to next slide
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrow),
            ),
          ),
      ),

      // circles indicator
      Row(
        children: [
          for(int i=0;i<_list.length;i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: _getProperCircle(i),
            )

        ],
      ),


      // right arrow
      Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: GestureDetector(
          onTap: (){
            // go to next slide
          },
          child: SizedBox(
            height: AppSize.s20,
            width: AppSize.s20,
            child: SvgPicture.asset(ImageAssets.leftArrow),
          ),
        ),
      )
    ],
  );
}

  Widget _getProperCircle(int index){
    if(index == _currentIndex){
      return SvgPicture.asset(ImageAssets.hollowCirce); // selected slider
    }else{
      return SvgPicture.asset(ImageAssets.solidCircle); // unSelected slider
    }
  }

}



class OnBoardingPage extends StatelessWidget{
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(
          _sliderObject.image
        ),
      ],
    );
  }
}

class SliderObject{
  String title;
  String subTitle;
  String image;
  SliderObject(this.title,this.subTitle,this.image);
}
