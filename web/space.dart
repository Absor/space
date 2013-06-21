library space;

import 'dart:html';
import 'dart:collection';
import 'dart:async';
import 'dart:math';
import 'package:siege_engine/siege_engine.dart';
import 'package:vector_math/vector_math.dart';

part 'components/acceleration_component.dart';
part 'components/position_component.dart';
part 'components/render_component.dart';
part 'components/rotation_component.dart';
part 'components/velocity_component.dart';
part 'components/camera_centering_component.dart';
part 'components/follower_component.dart';
part 'components/wanderer_component.dart';
part 'components/path_follower_component.dart';
part 'managers/canvas_manager.dart';
part 'managers/scene_manager.dart';
part 'utils/game_settings.dart';
part 'utils/id_manager.dart';
part 'scenes/scene.dart';
part 'scenes/main_menu_scene.dart';
part 'scenes/game_scene.dart';
part 'systems/rendering_system.dart';
part 'systems/movement_system.dart';
part 'systems/follower_system.dart';
part 'systems/enemy_system.dart';
part 'systems/debugging_system.dart';
part 'systems/wanderer_system.dart';
part 'systems/path_follower_system.dart';

GameSettings settings;
CanvasManager canvasManager;
SceneManager sceneManager;

void main() {
  settings = new GameSettings();
  canvasManager = new CanvasManager(query("#space_game_canvas"));
  sceneManager = new SceneManager();
  sceneManager.run();
  sceneManager.addScene("mainmenu", new MainMenuScene());
  sceneManager.addScene("game", new GameScene());
  sceneManager.changeScene("game");
}