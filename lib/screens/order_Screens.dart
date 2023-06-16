import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/orderItem.dart' as ord;
import '../widgets/app_drawer.dart';
class OrderScreen extends StatefulWidget {
  // const OrderScreen({super.key});
    static const routeName="/order";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  var _isInit =true;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    if(_isInit){

    setState(() {
      _isLoading=true;
    });
    await Future.delayed(Duration.zero).then((_) {
      Provider.of<Orders>(context,listen: false).fetchAndSetOrder();
    },);
    setState(() {
      _isLoading=false;
    });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      //
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => ord.OrderItem(
          order: orderData.orders[index],
        ),
      ),
      //
      drawer: AppDrawer(),
    );
  }
}
