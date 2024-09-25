import 'package:ecommerce_app/Presentation/SplashScreen/Auth/login_screen.dart';
import 'package:ecommerce_app/Presentation/SplashScreen/Screens/categories_screen.dart';
import 'package:ecommerce_app/Presentation/common/product_card.dart';
import 'package:ecommerce_app/Provider/api_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    Provider.of<ApiProvider>(context, listen: false).CategoryApi();
    Provider.of<ApiProvider>(context, listen: false).ProductApi();
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
          actions: [
            IconButton(
                onPressed: () async {
                  final signOut = FirebaseAuth.instance;
                  await signOut.signOut().then(
                        (_) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (_) => false,
                        ),
                      );
                },
                icon: const Icon(Icons.login_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: height * 0.20,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage('assets/offersimage.jpg'),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: 60,
              width: width,
              child: Consumer<ApiProvider>(builder: (context, value, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.categoriesDataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesScreen(
                                iD: value.categoriesDataList[index].id),
                          ));
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
                                  value.categoriesDataList[index].name
                                      .toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                );
              }),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Featured Product'),
              TextButton(onPressed: () {}, child: const Text('See More'))
            ]),
            Consumer<ApiProvider>(builder: (context, productPro, child) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisExtent: height * 0.359,
                      mainAxisSpacing: 8),
                  itemCount: productPro.productDataList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: productPro.productDataList[index],
                    );
                  });
            })
          ]),
        ));
  }
}
