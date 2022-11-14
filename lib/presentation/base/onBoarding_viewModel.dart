
import 'dart:async';

import 'package:complete_advanced_project/presentation/base/base_viewModel.dart';

import '../../domain/model.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  // stream controllers
  final StreamController _streamController = StreamController<SlideViewObject>();


  // inputs
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChange(int index) {
    // TODO: implement onPageChange
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