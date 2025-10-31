import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/home/data/model/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/data/model/slider_respones/slider.dart';
import 'package:bookia/features/home/data/model/slider_respones/slider_respones.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> products = [];
  List<SliderModel> sliders = [];

  getInitData() async {
    emit(HomeLoadingState());

    var results = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.getBestSeller(),
    ]);

    var sliderRequest = results[0] as SliderRespones?;
    var bestsellerReq = results[0] as BestSellerResponse?;

    if (sliderRequest != null || bestsellerReq != null) {
      products = bestsellerReq?.data?.products ?? [];
      sliders = sliderRequest?.data?.sliders ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }

  getBestSeller() async {
    emit(HomeLoadingState());
    var res = await HomeRepo.getBestSeller();

    if (res != null) {
      products = res.data!.products!;
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }

  getSlider() async {
    emit(HomeLoadingState());
    var res = await HomeRepo.getSliders();

    if (res != null) {
      sliders = res.data?.sliders ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }

  addRemoveToWishList({required int productId}) async {
    emit(HomeLoadingState());
    if (checkIfInWishList(productId)) {
      var res = await WishlistRepo.removeFromWishList(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: "Removed from wishlist"));
      } else {
        emit(HomeErrorState());
      }
    } else {
      var res = await WishlistRepo.addToWishList(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: "Added to wishlist"));
      } else {
        emit(HomeErrorState());
      }
    }
  }

  addToCart({required int productId}) async {
    emit(HomeLoadingState());

    var res = await CartRepo.addToCart(productId: productId);
    if (res != null) {
      emit(HomeSuccessState(message: "Added to cart"));
    } else {
      emit(HomeErrorState());
    }
  }

  bool checkIfInWishList(int productId) {
    var cachedWishList = SharedPref.getWishList();

    return cachedWishList?.contains(productId) ?? false;
  }
}
