import 'dart:async';
import 'package:complete_advanced_project/presentation/base/base_viewModel.dart';
import '../../domain/model.dart';
import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  // stream controllers
  final StreamController _streamController = StreamController<SlideViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to our view
    _postDataToView();
  }

  @override
  void goNext() {
    _getNextIndex();
    _postDataToView();
  }

  @override
  void goPrevious() {
    _getPreviewIndex();
    _postDataToView();
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  _getPreviewIndex(){
    int index = _currentIndex--;
    if(index == -1){
      _currentIndex = _list.length - 1;
    }
  }

  _getNextIndex(){
    int index = _currentIndex++;
    if(index >= _list.length){
      _currentIndex = 0;
    }
  }

  // private functions
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

  _postDataToView(){
    inputSliderViewObject.add(
      SlideViewObject(
        _list[_currentIndex],
        _list.length,
        _currentIndex,
      ),
    );
  }
}

// inputs mean the orders that out view model will receive from our view
abstract class OnBoardingViewModelInputs{
  void goNext(); // when user clicks on right arrow or swipe left.
  void goPrevious(); // when user clicks on left arrow or swipe right.
  void onPageChange(int index);

  Sink get inputSliderViewObject; // this is the way to add data to the stream
}

// outputs mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs{
  Stream<SlideViewObject> get outputSliderViewObject;

}

class SlideViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject,this.numOfSlides,this.currentIndex);
}