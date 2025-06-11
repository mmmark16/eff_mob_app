import 'package:dio/dio.dart';
import 'package:eff_mob_app/models/hero_model.dart';
import 'package:eff_mob_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../global.dart';
import '../widgets/hero_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    allHeroes = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    _loadHeroes();
    //getHeros();
  }
  // Функция для загрузки данных (сначала из API, потом из Hive)
  Future<void> _loadHeroes() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    try {
      // Пытаемся загрузить данные из API
      await getHeros();
    } catch (e) {
      print('Error loading data from API: $e');
      // Если не удалось загрузить данные из API, загружаем из Hive
      List<HeroModel> cachedHeroes = await getHeroesFromHive(_pageNumber);
      if (cachedHeroes.isNotEmpty) {
        setState(() {
          allHeroes = cachedHeroes;
          _loading = false;
          _error = false;
          _isLastPage = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Данные загружены из кеша')),
          );
        });
      } else {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    }
  }

  Future getHeros() async {
    var dio = Dio();
    try {
      var response = await dio.get(
        "https://rickandmortyapi.com/api/character/?page=$_pageNumber",
      );
      if (response.statusCode == 200) {
        final _json = response.data;
        allPageHero = List<HeroModel>.from(
          _json['results'].map((model) => HeroModel.fromJson(model)),
        );

        setState(() {
          _isLastPage = allPageHero.length < _numberOfPostsPerRequest;
          _loading = false;
          _pageNumber = _pageNumber + 1;
          allHeroes.addAll(allPageHero);
          saveHeroesToHive(allHeroes, _pageNumber); // Сохраняем с учетом номера страницы
          _pageNumber++; // Увеличиваем номер страницы
        });
        return "success";
      }
    } on DioException catch (e) {
      print(
        "getPerson fail " +
            DateTime.now().toString() +
            " reason " +
            e.message.toString(),
      );
      setState(() {
        _loading = false;
        _error = true;
      });
      return "error" + (e.message ?? "");
    }
  }

  // Функция для сохранения списка HeroModel в Hive (с учетом страницы)
  Future<void> saveHeroesToHive(List<HeroModel> heroes, int pageNumber) async {
    final box = Hive.box<HeroModel>('heroesBox');
    final key = 'page_$pageNumber'; // Ключ для каждой страницы
    await box.put(key, heroes); // Сохраняем данные для конкретной страницы
  }

  // Функция для получения списка HeroModel из Hive (с учетом страницы)
  Future<List<HeroModel>> getHeroesFromHive(int pageNumber) async {
    final box = Hive.box<HeroModel>('heroesBox');
    final key = 'page_$pageNumber'; // Ключ для конкретной страницы
    final List<HeroModel>? heroes = box.get(key); // Получаем данные по ключу

    return heroes ?? [];
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _loading = true;
                _error = false;
                getHeros();
              });
            },
            child: const Text(
              "Retry",
              style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("All Hero"),
      ),
      body: buildPostsView(),
    );
  }
  Widget buildPostsView() {
    final double setWidth = MediaQuery.of(context).size.width / 2.3;
    final double setHeight = MediaQuery.of(context).size.height / 2.5;
    if (allHeroes.isEmpty) {
      if (_loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
        );
      } else if (_error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (setWidth / setHeight),
        crossAxisCount: 2,
      ),
      itemCount: allHeroes.length + (_isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == allHeroes.length - _nextPageTrigger) {
          getHeros();
        }
        if (index == allHeroes.length) {
          if (_error) {
            return Center(child: errorDialog(size: 15));
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
        final HeroModel hero = allHeroes[index];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: HeroCard(
            image: hero.image!,
            name: hero.name!,
            gender: hero.gender!,
            favorite: hero.favorite != true ? false : true,
            id: hero.id!,
          ),
        );
      },
    );
  }
}
