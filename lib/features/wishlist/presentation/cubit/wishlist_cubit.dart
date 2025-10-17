import 'package:bookia/features/wishlist/data/model/wish_list_response/datum.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  List<WishListProduct> books = [];

  getWishList() async {
    emit(WishlistLoadingState());

    var res = await WishlistRepo().getWishList();

    if (res != null) {
      books = res.data?.data ??[];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistFailureState());
    }
  }
}
