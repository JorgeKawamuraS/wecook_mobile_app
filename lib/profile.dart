import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wecookmobile/identity.dart';
import 'package:wecookmobile/statistic.dart';
import 'package:wecookmobile/subscription.dart';
import 'package:wecookmobile/widgets/block_menu.dart';
import 'bottomNavigation.dart';
import 'globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  static Map<int, Color> colorCustomBrown = {
    50: const Color.fromRGBO(239, 235, 233, 1),
    100: const Color.fromRGBO(215, 204, 200, 1),
    200: const Color.fromRGBO(188, 170, 164, 1),
    300: const Color.fromRGBO(161, 136, 127, 1),
    400: const Color.fromRGBO(141, 110, 99, 1),
    500: const Color.fromRGBO(121, 85, 72, 1),
    600: const Color.fromRGBO(109, 76, 65, 1),
    700: const Color.fromRGBO(93, 64, 55, 1),
    800: const Color.fromRGBO(78, 52, 46, 1),
    900: const Color.fromRGBO(62, 39, 35, 1),
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

      ),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildGrid(),
            ],
          ),
        ),  
      )
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: BlockMenuContainer(
            color: Colors.brown,
            icon: Icons.food_bank,
            isSmall: false,
            blockTittle: "MIS RECETAS",
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: ((context) => const ActionsMyCategoriesScreen())));
            },
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: BlockMenuContainer(
            color: Colors.brown,
            icon: Icons.logout,
            isSmall: false,
            //blockSubLabel: "10 Páginas",
            blockTittle: "CERRAR SESIÓN",
            onTap: () {
              globals.isLoggedIn = false;
              globals.idNavigation = 3;
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>bottomNavigation(chips: [])));
              // Navigator.push(
              // context,
              // MaterialPageRoute(
              //   builder: ((context) => const ActionsMyCoursesScreen()),
              // ));
            },
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: BlockMenuContainer(
            color: Colors.brown,
            isSmall: false,
            icon: Icons.subscriptions,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const SubscriptionScreen())));
              //Navigator.pushNamed(context, Routes.todaysTask);
            },
            blockTittle: "SUSCRIPTORES", //sugerencias primero
            //blockSubLabel: "Encuentra tickets",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: BlockMenuContainer(
            color: Colors.brown,
            isSmall: false,
            icon: Icons.note,
            //blockSubLabel: "9 Insignias",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const StatisticScreen())));
              //Navigator.pushNamed(context, Routes.todaysTask);
            },
            blockTittle: "ESTADÍSTICAS",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1.1,
          child: BlockMenuContainer(
            color: Colors.brown,
            isSmall: false,
            icon: Icons.verified,
            //blockSubLabel: "9 Insignias",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const IdentityScreen())));
              //Navigator.pushNamed(context, Routes.todaysTask);
            },
            blockTittle: "MI PERFIL",
          ),
        ),
      ],
    );
  }

}