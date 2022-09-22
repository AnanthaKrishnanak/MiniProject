import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/models/address_model.dart';
import 'package:skin_app/models/blog_model.dart';
import 'package:skin_app/models/cart_model.dart';
import 'package:skin_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> loadedData = [];
  List<Product> faceWash = [];
  List<Product> womenData = [];
  List<Product> menData = [];
  List<Product> moisturizerData = [];
  List<Product> facewashData = [];
  List<Product> userOrderList = [];
  bool dataloadednotifier = true;
  int index = 0;
  int cat = 0;

  void clearall() {
    loadedData.clear();
    faceWash.clear();
    womenData.clear();
    menData.clear();
    moisturizerData.clear();
    facewashData.clear();
    userOrderList.clear();
    result.clear();
    cartItems.clear();
  }

  List<Cart> wishlisteditems = [];
  int totalamount = 0;
  void calcTotalM(int val) {
    totalamount += val;
    notifyListeners();
  }

  void remTotalM(int val) {
    totalamount = totalamount - val;
    notifyListeners();
  }

  Future<void> loadwishlistitems() async {
    wishlisteditems.clear();
    totalamount = 0;
    final sharedprf = await SharedPreferences.getInstance();
    final check = sharedprf.getString('userId');
    const url = 'https://wish-f2654-default-rtdb.firebaseio.com/.json';

    try {
      final response = await http.get(Uri.parse(url));
      final d = json.decode(response.body) as Map<String, dynamic>;
      d.forEach((key, value) {
        if (value['userid'] == check) {
          for (var i in loadedData) {
            if (i.id == value['proid']) {
              calcTotalM(int.parse(i.price));
              cartItems.add(Cart(
                  dataid: key,
                  title: i.title,
                  name: i.name,
                  expiry: i.expiry,
                  category: i.category,
                  description: i.description,
                  price: i.price,
                  imageUrl: i.imageUrl,
                  id: i.id,
                  apply: i.apply,
                  size: i.size,
                  skin: i.skin,
                  type: i.type));
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }

    notifyListeners();
  }

  //User
  String userd = 'userId';

  String userId = '';
  String userName = '';
  String uid = '';

  //Analysis data
  List<int> usergender = [];
  List<int> userProblems = [];
  List<Product> pimple = [];
  List<Product> wrigles = [];
  List<Product> dryw = [];
  List<Product> drym = [];
  List<Product> oilw = [];
  List<Product> oilm = [];
  List<Product> allw = [];
  List<Product> allm = [];

  void addpimple() {
    for (var e in loadedData) {
      if (e.skin == 'pimples') {
        pimple.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void addwringles() {
    for (var e in loadedData) {
      if (e.skin == 'wringles') {
        wrigles.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void dryskinm() async {
    for (var e in loadedData) {
      if (e.skin == 'dry' && e.category == 'men' && e.type != 'moisturizer') {
        drym.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void dryskinw() {
    for (var e in loadedData) {
      if (e.skin == 'dry' && e.category == 'women' || e.category == 'women ') {
        dryw.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void oilskinm() {
    for (var e in loadedData) {
      if (e.skin == 'oily' && e.category == 'men') {
        oilm.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void oilskinw() {
    for (var e in loadedData) {
      if (e.skin == 'oily' && e.category == 'women') {
        drym.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void allmen() {
    for (var e in loadedData) {
      if (e.category == 'men') {
        allm.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void allwomen() {
    for (var e in loadedData) {
      if (e.category == 'women') {
        allw.add(Product(
            title: e.title,
            name: e.name,
            expiry: e.expiry,
            category: e.category,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl,
            id: e.id,
            apply: e.apply,
            size: e.size,
            skin: e.skin,
            type: e.type));
      }
    }
  }

  void getgender(int gender) {
    usergender.add(gender);
    notifyListeners();
  }

  void getproblems(int probs) {
    userProblems.clear();
    userProblems.add(probs);
    notifyListeners();
  }

  void updateUserId(val) {
    userId = val;
    notifyListeners();
  }

  List<Product> result = [];

  void readness(int i) {
    if (i == 0) {
      addresult(loadedData[4]);
    } else if (i == 1) {
      addresult(loadedData[4]);
    } else if (i == 2) {
      addresult(loadedData[4]);
    } else if (i == 3) {
      addresult(loadedData[4]);
    } else if (i == 4) {
      addresult(loadedData[4]);
    }
    notifyListeners();
  }

  void gelornot(int i) {
    if (i == 0) {
      addresult(loadedData[9]);
    } else {
      addresult(loadedData[11]);
    }
    notifyListeners();
  }

  void p() {
    addresult(loadedData[12]);
  }

  void addresult(i) {
    result.add(Product(
        title: i.title,
        name: i.name,
        expiry: i.expiry,
        category: i.category,
        description: i.description,
        price: i.price,
        imageUrl: i.imageUrl,
        id: i.id,
        apply: i.apply,
        size: i.size,
        skin: i.skin,
        type: i.type));
    notifyListeners();
  }

  //end

  //cart
  var notempty = true;

  void chechcartisemptyornot() {
    if (cartItems.isEmpty) {
      notempty = false;
    }
    notifyListeners();
  }

  List<Cart> cartItems = [];
  void clearcart() {
    cartItems.clear();
  }

  Future<void> loadcartitems() async {
    clearcart();
    final sharedprf = await SharedPreferences.getInstance();
    final check = sharedprf.getString(userd);
    const url = 'https://cart-94f94-default-rtdb.firebaseio.com/.json';
    cartItems.clear();

    try {
      final response = await http.get(Uri.parse(url));
      final d = json.decode(response.body) as Map<String, dynamic>;
      d.forEach((key, value) {
        if (value['userid'] == check) {
          for (var i in loadedData) {
            if (i.id == value['proid']) {
              cartItems.add(Cart(
                  dataid: key,
                  title: i.title,
                  name: i.name,
                  expiry: i.expiry,
                  category: i.category,
                  description: i.description,
                  price: i.price,
                  imageUrl: i.imageUrl,
                  id: i.id,
                  apply: i.apply,
                  size: i.size,
                  skin: i.skin,
                  type: i.type));
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
    chechcartisemptyornot();
    notifyListeners();
  }

  void loadData(Product data) {
    loadedData.add(data);

    notifyListeners();
  }

  void faceWashList() {
    for (var element in loadedData) {
      if (element.type == 'face wash' || element.type == 'face wash ') {
        faceWash.add(element);
        facewashData.add(element);
      }
    }
  }

  void isFavoriteUpdate(bool val, index) async {
    loadedData[index].isFavorite = val;
    notifyListeners();
  }

  void dataloaded(bool val) {
    dataloadednotifier = val;
    notifyListeners();
  }

  //Shop displaying

  void women() {
    for (var element in loadedData) {
      if (element.category == 'women') {
        womenData.add(element);
      }
    }
  }

  void men() {
    for (var element in loadedData) {
      if (element.category == 'men') {
        menData.add(element);
      }
    }
  }

  void moisturizer() {
    for (var element in loadedData) {
      if (element.type == 'moisturizer') {
        moisturizerData.add(element);
      }
    }
  }

  void findIndex(String pid) {
    int i = 0;
    for (var data in loadedData) {
      i += 1;
      if (data.id == pid) {
        index = i;
      }
    }
  }

  void clearIndex() {
    index = 0;
  }

  void findCat(int val) {
    cat = val;
  }

  void clearCat() {
    cat = 0;
  }

  //ADDRESS

  var usernotfound = 0;
  var userexist = 0;
  var kid = '';
  var adrs = AddressModel(
      name: '',
      mobile: '',
      pincode: '',
      building: '',
      area: '',
      landmark: '',
      city: '');
  var found = 0;

  void addAddress(AddressModel ad) {
    adrs = AddressModel(
        name: ad.name,
        mobile: ad.mobile,
        pincode: ad.pincode,
        building: ad.building,
        area: ad.area,
        landmark: ad.landmark,
        city: ad.city);

    notifyListeners();
  }

  var kkid = '';
  Future getadr() async {
    final sharedprf = await SharedPreferences.getInstance();
    final us = sharedprf.getString(userd);
    const url = 'https://addres-9c93f-default-rtdb.firebaseio.com/.json';
    final data = await http.get(Uri.parse(url));
    final extractedData = json.decode(data.body) as Map<String, dynamic>;

    extractedData.forEach((key, value) {
      if (value['user'] == us) {
        found = 1;
        kkid = key;
      }
    });
    if (found == 1) {
      extractedData.forEach((key, value) {
        if (key == kkid) {
          adrs = AddressModel(
              name: value['name'],
              mobile: value['mobile'],
              pincode: value['pincode'],
              building: value['building'],
              area: value['area'],
              landmark: value['landmark'],
              city: value['city']);

          notifyListeners();
        }
      });
    }
  }

  Future<void> addAddresstodb() async {
    final sharedprf = await SharedPreferences.getInstance();
    final us = sharedprf.getString(userd);
    const url = 'https://addres-9c93f-default-rtdb.firebaseio.com/.json';
    final data = await http.get(Uri.parse(url));
    final extractedData = json.decode(data.body) as Map<String, dynamic>;

    extractedData.forEach((key, value) {
      if (value['user'] == us) {
        userexist = 1;
        kid = key;
      }
    });
    if (userexist == 1) {
      http
          .delete(Uri.parse(
              'https://addres-9c93f-default-rtdb.firebaseio.com/$kid.json'))
          .then((_) {
        try {
          if (adrs.name != '' &&
              adrs.pincode != '' &&
              adrs.area != '' &&
              adrs.mobile != '' &&
              adrs.building != '' &&
              adrs.city != '' &&
              adrs.landmark != '') {
            http.post(Uri.parse(url),
                body: json.encode({
                  'user': us,
                  'name': adrs.name,
                  'mobile': adrs.mobile,
                  'pincode': adrs.pincode,
                  'building': adrs.building,
                  'area': adrs.area,
                  'landmark': adrs.landmark,
                  'city': adrs.city
                }));
          }
        } catch (e) {
          rethrow;
        }
      });
    } else {
      try {
        if (adrs.name != '' &&
            adrs.pincode != '' &&
            adrs.area != '' &&
            adrs.mobile != '' &&
            adrs.building != '' &&
            adrs.city != '' &&
            adrs.landmark != '') {
          http.post(Uri.parse(url),
              body: json.encode({
                'user': us,
                'name': adrs.name,
                'mobile': adrs.mobile,
                'pincode': adrs.pincode,
                'building': adrs.building,
                'area': adrs.area,
                'landmark': adrs.landmark,
                'city': adrs.city
              }));
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  //user
  Future<void> getUserInfo() async {
    const url = 'https://user-data-f47b3-default-rtdb.firebaseio.com/.json';

    try {
      final response = await http.get(Uri.parse(url));
      final user = (json.decode(response.body)) as Map<String, dynamic>;
      user.forEach((id, data) {
        if (uid == data['userid']) {
          userId = data['userid'];
          userName = data['user'];
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  void setuid(String val) async {
    uid = val;
  }

  List<String> orderpath = [];

  //order
  Future<void> getOrders() async {
    userOrderList.clear();
    orderpath.clear();
    final sharedPref = await SharedPreferences.getInstance();
    final String? value = sharedPref.getString(userd);

    const url = 'https://orders-3900b-default-rtdb.firebaseio.com/.json';

    try {
      final response = await http.get(Uri.parse(url));
      final user = json.decode(response.body) as Map<String, dynamic>;
      user.forEach((id, data) {
        if (value == data['user']) {
          for (var element in loadedData) {
            if (element.id == data['pid']) {
              userOrderList.add(element);
              orderpath.add(id);
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
    notifyListeners();
    return;
  }

  //address
  ValueNotifier<bool> addressadded = ValueNotifier(true);

  void changeAddres(bool v) {
    addressadded.value = v;
    notifyListeners();
  }

  //results

  List<String> resultexplanations = [
    '''

Dry Skin with Acne Concerns Your skin type would be considered dry. You likely have very few visible pores and blackheads, but your skin can feel tight, itchy or even rough. Dry skin types generally suffer from a compromised lipid barrier, which can lead to tightness, flaking, and sensitivity. Gentle exfoliators like AHAs or PHAs can help reduce flakiness while ingredients like glycerin, honey and hyaluronic acid can help.'''
  ];

//bolg

  List<Blog> blogs = [
    Blog(
        imgurl2:
            'https://cdn.shopify.com/s/files/1/0272/4714/9155/products/MOISTURIZIN-ALOE-VERA-FACE-GEL-100ML_1024x1024.jpg?v=1631178946',
        imgurl: 'assets/b1.jpg',
        heading: '8 Skincare Myths — Debunked',
        subtitle:
            'Are you using body wash on your face? Stop it now and read this!',
        sh1: 'Myth #1: Using body wash on your face is OK. ',
        c1: '''No! 

Our feet and hands have much thicker skin than our face — that’s why body washes are formulated with hydrating ingredients that penetrate deeper in order to be effective. These formulations are usually too thick and moisturizing for our thinner, more delicate (and handsome) faces.  

"The face of the skin is unique," said Dr. Steve. "It has more oil-producing areas. It's got sensitive areas, eyelids and the lip area. It definitely gets the most of the environmental impact like wind and cold. So products that are formulated specifically for the face, that moisturize and cleanse, don't clog your pores, which is not a big issue for the skin on your body.” 

Will it kill you? No. But what doesn’t kill you just might dry you out and make your face look like barn grass.

Try our face wash with salicylic acid, it's designed specifically for your handsome mug. ''',
        sh2: 'Myth #2: A base tan is a good idea',
        c2: '''It tanning bad for you?

Yes — always! 

Face it: Tan skin is damaged skin. “Your skin has produced more melanin to protect from further UV damage, but damaging your skin is not a solution to offer protection,” said Dr. Steve. “That's not the right strategy.”

Even one sunburn increases your risk of skin cancer, so avoid tanning beds and use a daily moisturizer with SPF to keep your face protected every day. 

Here’s more science from Dr. Steve talking about SPF and tanning. 

You can find a super SPF with a moisturizer here.''',
        sh3: 'Myth #3: SPF is only necessary in the summer',
        c3: '''No, no! 

Did you know: 

Up to 80% of the sun's rays can penetrate clouds. Just because it’s a cold, cloudy day doesn’t mean you won’t be exposed to the strong UVA rays that cause aging. 
UV radiation exposure increases 4-5% with every 1,000 feet above sea level. Skiers and snowboarders, take note: according to the Skin Cancer Foundation, the higher your elevation, the greater your exposure to harmful UV rays. Plus, snow reflects and intensifies sunlight. 
 

Oh, and by the way, wearing sunscreen can slow the aging process by 24% — according to a 2013 study published in the Annals of Internal Medicine. 

Try some SPF30 and your face will show you gratitude. ''',
        sh4: 'Myth #4: If you want to know how you’ll age, look at your father',
        c4: '''Nyet! 

Genetics account for skin color and type, but only about 10% of skin aging is genetics. The rest is your call — sun exposure, smoking, dehydration, and excess alcohol consumption can age your skin prematurely. 

You can start with applying SPF and moisturizer every day — like the morning cream. 

And then add the anti-aging kingpin, retinol, from our night cream.''',
        sh5: 'Myth #5: Dark-Skinned People Can’t Get Skin Cancer',
        c5: '''Not true! 

According to Dr. Steve, people of color are “less susceptible” to UV damage because they have greater amounts of melanin, a protective skin pigment that gives people more color in their eyes and skin tone. 

Still, people with non-Caucasian skin tones can suffer from excessive UV damage, which can lead to skin cancer. In fact, Dr. Steve notes that Asians, African Americans and Latinos are at a higher risk for basal cell carcinoma, the most common type of skin cancer. 

A broad-spectrum sunscreen that prevents UVA/UVB rays is a daily essential for people of all skin types and tones.

 ''',
        sh6: 'Myth #6: A Higher SPF is Always Better',
        c6: '''Well, no, but kinda sorta. 

Here’s the deal: When SPFs are higher it can make a difference, but only because in the real world, guys don’t put on the proper amount of cream when they're applying it. 

“Most people apply about a half as much sunscreen as they should,” said Dr. Steve. “And that reduces the SPF’s effectiveness to a square root of the SPF.”

Math alert: In other words, if you’re using an SPF 30 but only spreading half of the recommended amount (the size of a quarter) on your face, the true SPF that you’re getting is the square root of 30, which is 5.5. 

If you use the correct amount of our Broad-Spectrum Face Sunscreen SPF30, there’s not much difference between that and SPF 50.''',
        sh7: 'Myth #7: Sun Exposure Is the Only Way to Get Vitami',
        c7: '''Wrong!

Let’s begin with how important vitamin D is for bodily functions. It supports: 

healthy bones and teeth.
immune, brain, and nervous system health.
insulin levels and diabetes management.
lung function and cardiovascular health.
expression of genes involved in cancer development
 

In short, vitamin D is like a superhero of vitamins that fights disease, reduces depression, and boosts weight loss. 

Sun and vitamin D work together. Your skin manufactures vitamin D when it’s exposed to UV rays —  they interact with a protein called 7-DHC in the skin, converting it into vitamin D3. 

Many people think that using sunscreen leads to vitamin D deficiency, and that the best way to obtain enough of the vitamin is through unprotected sun exposure.

Thing is, you don’t need the sun’s UV rays to get your daily dose of vitamin D. You can find it in egg yolks, salmon, tuna and mushrooms.

“Or you can take a supplement that does the same thing as UV exposure, and you don't have any skin cancer risk,” said Dr. Steve. 

 ''',
        sh8: 'Myth #8: Daily Exfoliation Is Good for Your Skin',
        c8: '''Is it bad to exfoliate every day? The removal of dead skin cells on the outermost dermal layer is good for your skin, whether it’s from a physical scrub or liquid exfoliant.

But using a washcloth too vigorously and too often wipes away skin cells and natural oils, exposing underlying new skin prematurely, which can cause redness and irritation. 

That’s why we suggest a gentle liquid exfoliant, like the 2% salicylic acid in our face wash. 

Here's an entire blog post about salicylic acid.  

 

Interested in kicking your handsome up a notch? Try the quick diagnostic and let's see how we can help. ''',
        sh9: '',
        c9: '',
        sh10: '',
        c10: '',
        sh11: '',
        c11: '',
        sh12: '',
        c12: ''),
    Blog(
        imgurl2:
            'https://cdn.shopify.com/s/files/1/0027/3527/6076/files/Light_Skinned_Guys_Image1_600x600.jpg?v=1646924638',
        imgurl: 'assets/blog-img.jpg',
        heading: 'Light Skinned Guys – Beware the Sun!',
        subtitle: 'But you\'re a wizard at making vitamin D.',
        sh1:
            'What\'s the deal with lighter skinned guys? Why is their skin like that?',
        c1:
            '''Dr. Steve: What gives you skin pigmentation is something called melanocytes — it’s a cell in the neural crest that migrates at the very beginning of your brainstem formation to all parts of your body, mostly the skin. Melanocytes express a molecule called melanin, which ultimately determines your skin tone and skin color. 

 

Melanin is the same chemically, whether you're black, white, whatever. But there are different types of melanin. Certain darker skin individuals have melanin that clump together better, that form a darker pigment within each melanin molecule. Ultimately how we express that melanin is what determines skin type and the driver of that expression is related to where your ancestors lived.

 

So, if you're born in South Sudan, the kind of melanin you have is one that's highly favored towards protecting you from ultraviolet radiation. And if you were born in Northern Ireland or Scandinavia, you have a different type of melanin that's more designed towards helping you convert vitamin D more efficiently, because there's less UV overall. 

 

Light skin needs only one-sixth as much sun as dark skin to make the same amount of Vitamin D. ''',
        sh2:
            'Do you have any idea what that mechanism is behind the conversion of sunlight to Vitamin D? ',
        c2:
            '''Dr. Steve: It really comes down to melanocytes — fair skinned guys have different types of melanocytes than dark-skinned guys. So if you lived in a place that didn't get that much UV you want to be very efficient at making vitamin D through sunlight because you don't get that much UV. But if you live in South Sudan, UV is a big problem for a light skinned person. There's so much UV out there that you're going to be just fine at converting the Vitamin D that you need, because there's so much UV, but then you’re at greater risk of skin damage and skin cancer.''',
        sh3: 'Do fair skinned people have less effective melanosomes?',
        c3:
            'Dr. Steve: They have melanosomes that absorb UV radiation less efficiently than darker skin types. ',
        sh4:
            'Are fair skinned people usually the first to show signs of aging? ',
        c4:
            '''Dr. Steve: Yes. So if you took a caucasian person type-one skin and you took a darker person, a type-six skin, and you put them in the same exact environment, the same exact behaviors, and the same amount of sun, the lighter skinned person will look older as they age.

That's why the anti-aging mechanism in moisturizer (hyaluronic acid) and night cream (retinol) as well as eye cream (kojic acid) can really make a difference. 

Get them all — shop our complete skincare trial set. ''',
        sh5:
            'Do light skinned guys age faster because their skin is thinner, or is it because of less melanin?',
        c5: '''Dr. Steve: It's neither. Both skin types have the same amount of melanin, but the person with darker skin has melanocytes that are more effective at absorbing UV radiation before it gets absorbed by your skin cells, which means the UV rays don’t reach in the upper layers of the skin where you get something called solar elastosis. In darker skinned guys, the UV has less of a chance to break down the collagen and create wrinkles and aging sunspots. That’s not the case for guys with lighter skin. For them, UV can run wild if they don't apply SPF.

''',
        sh6: 'Why do light skinned guys have freckles?',
        c6: '''Freckles are concentrated flecks of melanin. When UV hits the skin, melanin protects the skin from that damage by darkening it. In some people, melanocytes are spread out evenly, as dictated by a gene, MC1R, and sun exposure produces a smooth wash of melanin (a tan.)

 

In light skinned guys, particularly guys with red hair, the MC1R gene is "broken," and the melanocytes are bunched up, leading to constellations of melanin, a.k.a. freckles. 

 ''',
        sh7: '',
        c7: '',
        sh8: '',
        c8: '',
        sh9: '',
        c9: '',
        sh10: '',
        c10: '',
        sh11: '',
        c11: '',
        sh12: '',
        c12: ''),
    Blog(
        imgurl: 'assets/olily.jpg',
        imgurl2:
            'https://cdn.shopify.com/s/files/1/0027/3527/6076/files/Azaleic_Acid_Image_1_600x600.jpg?v=1657096541',
        heading: '''Azelaic Acid — What Does it Do?''',
        subtitle: 'Why this super ingredient belongs in your medicine cabinet',
        sh1: 'What is azelaic acid? ',
        c1: 'Azelaic acid is a naturally occurring compound found in grains like barley, wheat and rye. As an ingredient for skincare, it was synthesized for mild to moderate rosacea and approved in 2002. “People like it because it’s associated with natural ingredients,” said Geologie founding dermatologist Dr. Steve.',
        sh2: 'What does azelaic acid do?',
        c2: '''Azelaic acid is a super ingredient because it's effective in four key ways: 


It’s a skin lightener. Azelaic acid is a tyrosinase inhibitor, meaning it can prevent hyperpigmentation because it interferes with melanin production. “Azelaic acid can give you a little bit of brightness in darker spots,” said Dr. Steve, “especially if you’ve got post inflammatory hyperpigmentation (PIH) due to acne.” 
S

It’s anti-inflammatory. “Azelaic acid has anti-inflammatory properties — in the same niacinamide category, but probably a little bit more potent,” said Dr. Steve. “That's why it’s really good for fighting acne: it fights the inflammatory aspect but also fights the dark spots that can occur after. It's also what we use for redness with things like rosacea. We dermatologists also think azelaic acid works as an antioxidant, not perfectly modeled yet and studies, but we think it has those properties.”


It’s an exfoliant: “Azelaic acid does have an exfoliant characteristic just like a beta hydroxy acid like salicylic acid or an alpha hydroxy acid,” said Dr. Steve. “It’ll help flush scaly skin to get it smoother.”


It's well tolerated. Azelaic acid doesn't cause dryness and irritation like retinoids do. “It can cause a little redness, like any acid can cause some issues, but that’s all. It's also one of the few ingredients that is actually safe in pregnancy, and one of the few products we offer pregnant women. ''',
        sh3: 'What are Azelaic acid’s side effects? ',
        c3: '''
If you’ve got sensitive-skin, the anti-inflammatory properties of the azelaic acid can lead to stinging, burning and hyperpigmentation. “It’s not typical, but it can happen,” said Dr. Steve, who noted that hyperpigmentation can occur when applying azelaic acid to thinner skin areas near the lips or eyes. “Dermatologists used to prescribe the 20% version, but now, with the Clear System over-the-counter at 5% azelaic acid, you’ll see very little side effects.”


Still, if you are super sensitive and everything stings, burns and irritates your skin, do a patch test on the back of your arm before committing to azelaic acid. If there's no reaction, apply it to your neck and your face last.''',
        sh4: '',
        c4: '',
        sh5: '',
        c5: '',
        sh6: '',
        c6: '',
        sh7: '',
        c7: '',
        sh8: '',
        c8: '',
        sh9: '',
        c9: '',
        sh10: '',
        c10: '',
        sh11: '',
        c11: '',
        sh12: '',
        c12: ''),
    Blog(
        imgurl2:
            'https://cdn.shopify.com/s/files/1/0027/3527/6076/files/Greasy_Nose_Image1_739b2f86-40d0-4296-9c49-b5a71fcb6dfc_600x600.jpg?v=1657222457',
        imgurl: 'assets/blog-w.jpg',
        heading: 'Oily Nose, Explained + How to Get Rid of It',
        subtitle: 'Did you know that your nose oil can start a fire?',
        sh1: 'Q: Why is my nose oily, while the rest of my face is dry?',
        c1: '''
Dr. Steve’s Answer: The nose is unique because of the following reasons:

Sebaceous glands: Men have more of these oil-producing glands than women do. And in the T-zone – forehead, nose, cheeks and chin – they’re larger in size than anywhere else on your body, which means the "T" signifies Trouble.
Pore size: If you have oily skin, your nose may produce considerably more oil because your pores are naturally larger than other pores on the face.
Combination skin: For many men with an oily nose, it’s frustrating because the rest of their face might be dry. Combination skin Here's a blog article that explains in great detail why guys are so prone to oily skin.''',
        sh2: 'Q: Why is my nose oily when I wake up?',
        c2:
            'Dr. Steve: When you’re asleep your skin loses water. This prompts the sebaceous glands to work with sweat glands to make the sweat more lipid, film-like, and not so easily lost during perspiration. That’s why you see a thick oil buildup in the morning.',
        sh3: 'Q: How do I get rid of an oily nose?',
        c3: '''
Dr. Steve: Fortunately there are many things you can do to control an oily nose.


Salicylic acid: The acid part of the molecule does the heavy lifting, dissolving some of the intracellular “glue” that holds skin cells together. This acid breaks down skin debris and oil that clogs the pores. Find a great salicylic acid face wash, it’s a game-changer for an oily nose.
Retinol: Retinol modulates and reduces the amount of natural oil that your body produces. By reducing the oil, the resulting dryness will help control acne. A strong retinol night cream can fix that oily nose.
Niacinamide: Like retinol, this ingredient helps regulate the amount of oil the sebaceous glands produce to keep your skin from getting too oily. It’s also an anti-inflammatory, which helps with acne, among other things. The eye cream has niacinamide, which works in tandem with the night cream.''',
        sh4: 'Q: How do I get rid of oily pores on my nose?',
        c4:
            '''Dr. Steve Answer: First thing, the size of your pores is a genetic thing, and it’s not really possible to shrink pore size. They can be dilated and constricted for a very brief period of time with alcohols and topicals that dry the skin, but as a durable effect pores cannot be made smaller.

When I say this to my patients, they say “Then can I get tighter pores?” A lot of times what tighter pores means is actually just cleaning out your pores. When you have dark junk in the pores, the pores are quite visible. What can’t be made smaller can however be made less noticeable, and you do this by cleaning them out.

Use retinol to control the oil and salicylic acid to exfoliate — they’ll literally clean out the pores. They’ll soon become less visible, because the coloration of the pores will more closely match the coloration of the skin.

You can find both products in the Essential Acne set.''',
        sh5: 'Q: Can retinol reduce your nose’s pore size?',
        c5: '''
Dr. Steve: No. Retinol definitely affects oil production, that's why there's a dryness when you initially use retinoids. It definitely affects keratinization — the issue around acne formation. They break up comedones, which makes pores more obvious to see, but they don't affect the actual pore size. That’s what God gave you.

''',
        sh6:
            'Q: When I squeeze my nose pores, white stuff comes out. What’s the deal?',
        c6: '''Dr. Steve: That’s sebum. People with large pores on their nose who produce excess sebum will often squeeze it out. I don’t recommend it because you can do damage to the skin if you do it overzealously. It’s the same reason why you should not pop your zits.''',
        sh7: 'Q: Is it true that your nose oil can start a fire?',
        c7: '''
Dr. Steve:  It’s true. Sebum consists of triglycerides, free fatty acids, wax esters, and squalene. All of these are flammable-wax esters — what wax candles are made of.

''',
        sh8: '',
        c8: '',
        sh9: '',
        c9: '',
        sh10: '',
        c10: '',
        sh11: '',
        c11: '',
        sh12: '',
        c12: '')
  ];
}
