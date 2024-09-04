
import 'package:ecommerce_app/Provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiProvider>(context,listen: false).CategoryApi();
    Provider.of<ApiProvider>(context,listen: false).ProductApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextFormField(
            decoration: InputDecoration(
              hintText: 'Find a product...',
              prefixIcon: const Icon(CupertinoIcons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 230,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
            ),
            Container(
              height: 60,
              width: width,
              child: Consumer<ApiProvider>(
                builder: (context,apiPro,child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: apiPro.categoriesDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    apiPro.categoriesDataList[index].name.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Featured Product'),
              TextButton(onPressed: () {}, child: const Text('See More'))
            ]),
            (isLoad == true)
                ? const CircularProgressIndicator()
                : Consumer<ApiProvider>(
                  builder: (context,productPro,child) {
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisExtent: height*0.40,
                              mainAxisSpacing: 16
                            ),
                        itemCount:productPro.productDataList.length,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10, bottom: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productPro.productDataList[index].image ??
                                                    '')),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: height * .18,
                                      width: MediaQuery.sizeOf(context).width,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  productPro.productDataList[index].title ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '\$ ${productPro.productDataList[index].price}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'rating ${productPro.productDataList[index].rating?.rate}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                ),
          ]),
        ));
  }
}
