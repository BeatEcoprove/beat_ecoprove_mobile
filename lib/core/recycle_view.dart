import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class RecycleView extends StatefulWidget {
  final Future<List<Widget>> Function(int, int) callback;
  final int numberMaxItemsPage;
  final String search;

  const RecycleView({
    super.key,
    required this.callback,
    this.numberMaxItemsPage = 5,
    required this.search,
  });

  @override
  State<RecycleView> createState() => _RecycleViewState();
}

// Receber 20 (página + 1) items de cada vez
// Se chegar ao fim remover página atual - 1
// Buscar página atual + 1

class _RecycleViewState extends State<RecycleView> {
  List<Widget> items = [];
  static const int defaultPage = 1;
  int currentPage = defaultPage;
  bool isLoading = false;
  static const int lazyMultiplier = 2;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      items.clear();
      currentPage = defaultPage;
    });
    _loadMoreItems();
  }

  Future<void> _loadMoreItems() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // if (items.length > widget.numberMaxItemsPage) {
      //   setState(() {
      //     items.removeRange(0, widget.numberMaxItemsPage);
      //   });
      // }

      // Fetch wherever number of pages that is in the lazyMultiplier variable
      var collected = await widget.callback(
          currentPage, widget.numberMaxItemsPage * lazyMultiplier);

      setState(() {
        currentPage++;
        items.addAll(collected);
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      _loadMoreItems();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78 -26,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: isLoading == true
              ? items
              : items.isEmpty
                  ? [
                      const Text(
                        "Não existem registos!",
                        textAlign: TextAlign.center,
                        style: AppText.smallSubHeader,
                      )
                    ]
                  : items,
        ),
      ),
    );
  }
}
