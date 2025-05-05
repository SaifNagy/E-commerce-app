import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  String? selectedPaymentId = dummypaymentcard.first.id;

  void addNewCard(
    String cardnumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLoading());
    final newCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardnumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed(const Duration(seconds: 2), () {
      dummypaymentcard.add(newCard);
      emit(AddNewCardSuccess());
    });
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(const Duration(seconds: 1), () {
      if (dummypaymentcard.isNotEmpty) {
        final chosenpaymentmethod = dummypaymentcard.firstWhere(
          (paymentcards) => paymentcards.ischosen == true,
          orElse: () => dummypaymentcard.first,
        );
        emit(FetchedPaymentMethods(paymentMethods: dummypaymentcard));
        emit(PaymentMethodChosen(chosenpaymentmethod));
      } else {
        emit(
          FetchingPaymentMethodsError(errorMessage: 'No payment methods found'),
        );
      }
    });
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempChosenPaymentMethod = dummypaymentcard.firstWhere(
      (element) => element.id == selectedPaymentId,
    );
    emit(PaymentMethodChosen(tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());
    Future.delayed(const Duration(seconds: 1), () {
      var chosenPaymentMethod = dummypaymentcard.firstWhere(
        (paymentCard) => paymentCard.id == selectedPaymentId,
      );
      var previousPaymentMethod = dummypaymentcard.firstWhere(
        (paymentCard) => paymentCard.ischosen == true,
        orElse: () => dummypaymentcard.first,
      );
      previousPaymentMethod = previousPaymentMethod.copyWith(ischosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(ischosen: true);

      final previousindex = dummypaymentcard.indexWhere(
        (paymentcard) => paymentcard.id == previousPaymentMethod.id,
      );
      final chosenindex = dummypaymentcard.indexWhere(
        (paymentcard) => paymentcard.id == chosenPaymentMethod.id,
      );
      dummypaymentcard[previousindex] = previousPaymentMethod;
      dummypaymentcard[chosenindex] = chosenPaymentMethod;

      chosenPaymentMethod = chosenPaymentMethod.copyWith(ischosen: true);
      emit(ConfirmPaymentSuccess());
    });
  }
}
