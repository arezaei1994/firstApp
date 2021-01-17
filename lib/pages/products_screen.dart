import 'package:flutter/material.dart';
import 'package:whatsapp/components/product_cart.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/services/product_services.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen>
    with AutomaticKeepAliveClientMixin<ProductsScreen> {
  List<Product> _products = [];
  int _currentPage = 1;
  bool _viewStream = true;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getProducts();
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        if (!_isLoading) {
          _getProducts(page: _currentPage + 1);
        }
      }
    });
  }

  _getProducts({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await ProductService.getProducts(page);

    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response["current_page"];
      _isLoading = false;
    });
  }

  Widget loadingView() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget listIsEmpty() {
    return new Center(
      child: new Text('محصولی برای نمایش وجود ندارد'),
    );
  }

  Future<Null> _handleRefresh() async {
    await _getProducts(refresh: true);
    return null;
  }

  Widget streamListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: new ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ProductCard(product: _products[index]);
                    }),
                onRefresh: _handleRefresh);
  }

  Widget moduleListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ProductCard(product: _products[index]);
                    }),
                onRefresh: _handleRefresh);
  }

  Widget headList() {
    return new SliverAppBar(
      primary: false,
      pinned: false,
      floating: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = true;
              });
            },
            child: new Icon(Icons.view_stream,
                color: _viewStream ? Colors.grey[900] : Colors.grey[500]),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = false;
              });
            },
            child: new Icon(Icons.view_module,
                color: _viewStream ? Colors.grey[500] : Colors.grey[900]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new NestedScrollView(
        controller: _listScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _products.length != 0 ? <Widget>[headList()] : [];
        },
        body: _viewStream ? streamListView() : moduleListView());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
