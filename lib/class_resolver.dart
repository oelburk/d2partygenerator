import 'package:d2_class_picker/player.dart';

class ClassResolver {
  static String imageAdrFromClass(CClass charClass) {
    String addr = "";

    switch (charClass) {
      case CClass.Amazon:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/6/6d/Amazon_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Assassin:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/f/fe/Assassin_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Barbarian:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/b/b3/Barbarian_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Druid:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/8/89/Druid_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Necromancer:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/3/39/Necromancer_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Paladin:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/e/e1/Paladin_Sprite_%28Diablo_II%29.gif";
        break;
      case CClass.Sorceress:
        addr =
            "https://static.wikia.nocookie.net/diablo_gamepedia/images/3/3d/Sorceress_Sprite_%28Diablo_II%29.gif";
        break;
      default:
    }

    return addr;
  }

  static String nameFromClass(CClass charClass) {
    String name = "Unknown";
    switch (charClass) {
      case CClass.Amazon:
        name = "Amazon";
        break;
      case CClass.Assassin:
        name = "Assassin";
        break;
      case CClass.Barbarian:
        name = "Barbarian";
        break;
      case CClass.Druid:
        name = "Druid";
        break;
      case CClass.Necromancer:
        name = "Necromancer";
        break;
      case CClass.Paladin:
        name = "Paladin";
        break;
      case CClass.Sorceress:
        name = "Sorceress";
        break;
      default:
    }
    return name;
  }

  static CClass classFromName(String name) {
    CClass charClass = CClass.Undefined;
    switch (name) {
      case "Amazon":
        charClass = CClass.Amazon;
        break;
      case "Assassin":
        charClass = CClass.Assassin;
        break;
      case "Barbarian":
        charClass = CClass.Barbarian;
        break;
      case "Druid":
        charClass = CClass.Druid;
        break;
      case "Necromancer":
        charClass = CClass.Necromancer;
        break;
      case "Paladin":
        charClass = CClass.Paladin;
        break;
      case "Sorceress":
        charClass = CClass.Sorceress;
        break;
      default:
    }
    return charClass;
  }
}
