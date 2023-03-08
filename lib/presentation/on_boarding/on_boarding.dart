import 'package:complete_advanced_project/presentation/base/onBoarding_viewModel.dart';
import 'package:complete_advanced_project/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_project/presentation/resources/color_manager.dart';
import 'package:complete_advanced_project/presentation/resources/string_manager.dart';
import 'package:complete_advanced_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model/model.dart';
import '../resources/routes_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageController = PageController(initialPage: 0);

  final OnBoardingViewModel _onBoardingViewModel = OnBoardingViewModel();

  _bind(){
    _onBoardingViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
        stream: _onBoardingViewModel.outputSliderViewObject,
        builder: (context,snapshot){
          return _getContentWidget(snapshot.data);
        }
    );
  }


Widget _getContentWidget(SlideViewObject? slideViewObject){
    if(slideViewObject == null){
      return Container();
    }else{
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark
          ),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: slideViewObject.numOfSlides,
            onPageChanged: (index){
              _onBoardingViewModel.onPageChange(index);
            },
            itemBuilder: (context,index){
              return OnBoardingPage(
                 slideViewObject.sliderObject
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
                  onPressed: (){
                    Navigator.pushReplacementNamed(context,Routes.loginRoute);
                  },
                  child: Text(
                    AppString.skip,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheetWidget(slideViewObject),
            ],
          ),
        ),
      );
    }
}


Widget _getBottomSheetWidget(SlideViewObject slideViewObject){
  return Container(
    color: ColorManager.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left arrow
        Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: (){
                // go to next slide
                _onBoardingViewModel.goPrevious();
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
            for(int i=0;i<slideViewObject.numOfSlides;i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i,slideViewObject.currentIndex),
              )

          ],
        ),


        // right arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: (){
              // go to next slide
              _onBoardingViewModel.goNext();
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrow),
            ),
          ),
        )
      ],
    ),
  );
}


  Widget _getProperCircle(int index,int currentIndex){
    if(index == currentIndex){
      return SvgPicture.asset(ImageAssets.hollowCirce); // selected slider
    }else{
      return SvgPicture.asset(ImageAssets.solidCircle); // unSelected slider
    }
  }

  @override
  void dispose() {
    _onBoardingViewModel.dispose();
    super.dispose();
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


