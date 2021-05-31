import 'package:cake_wallet/src/screens/unspent_coins/widgets/unspent_coins_list_item.dart';
import 'package:cake_wallet/src/widgets/alert_with_one_action.dart';
import 'package:cake_wallet/utils/show_pop_up.dart';
import 'package:cake_wallet/view_model/unspent_coins/unspent_coins_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cake_wallet/src/screens/base_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cake_wallet/generated/i18n.dart';

class UnspentCoinsListPage extends BasePage {
  UnspentCoinsListPage({this.unspentCoinsListViewModel});

  @override
  String get title => 'Unspent coins';

  @override
  Widget trailing(BuildContext context) {
    final questionImage = Image.asset('assets/images/question_mark.png',
        color: Theme.of(context).primaryTextTheme.title.color);

    return SizedBox(
      height: 20.0,
      width: 20.0,
      child: ButtonTheme(
        minWidth: double.minPositive,
        child: FlatButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            onPressed: () => showPopUp<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertWithOneAction(
                      alertTitle: '',
                      alertContent: 'Information about unspent coins',
                      buttonText: S.of(context).ok,
                      buttonAction: () => Navigator.of(context).pop());
                }),
            child: questionImage),
      ),
    );
  }

  final UnspentCoinsListViewModel unspentCoinsListViewModel;

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Observer(
        builder: (_) => ListView.separated(
          itemCount: unspentCoinsListViewModel.items.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: 15),
          itemBuilder: (_, int index) {
            final item = unspentCoinsListViewModel.items[index];

            return GestureDetector(
                onTap: () {print('Item taped');},
                child: UnspentCoinsListItem(
                  address: item.address,
                  amount: item.amount,
                  isSending: item.isSending,
                  onCheckBoxTap: (value) {},
                ));
          }
        )
      )
    );
  }
}