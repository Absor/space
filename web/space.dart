library space;

import 'dart:html';
import 'dart:collection';
import 'dart:async';
import 'dart:math';
import 'dart:isolate';
import 'package:siege_engine/siege_engine.dart';
import 'package:vector_math/vector_math.dart';

part 'components/basic/acceleration_component.dart';
part 'components/basic/position_component.dart';
part 'components/basic/render_component.dart';
part 'components/basic/rotation_component.dart';
part 'components/basic/velocity_component.dart';
part 'components/basic/camera_centering_component.dart';
part 'components/basic/attach_component.dart';
part 'components/basic/collision_component.dart';
part 'components/steering/follower_component.dart';
part 'components/steering/wanderer_component.dart';
part 'components/steering/path_follower_component.dart';
part 'components/weapon/weapon_trigger_component.dart';
part 'components/weapon/triggers/repeating_weapon_component.dart';
part 'components/weapon/laser_shot_weapon_component.dart';
part 'utils/canvas_manager.dart';
part 'utils/scene_manager.dart';
part 'utils/game_settings.dart';
part 'utils/id_manager.dart';
part 'utils/component_attacher.dart';
part 'utils/game_status.dart';
part 'scenes/scene.dart';
part 'scenes/main_menu_scene.dart';
part 'scenes/game_scene.dart';
part 'systems/rendering_system.dart';
part 'systems/movement_system.dart';
part 'systems/follower_system.dart';
part 'systems/entity_spawning_system.dart';
part 'systems/debugging_system.dart';
part 'systems/wanderer_system.dart';
part 'systems/path_follower_system.dart';
part 'systems/attach_system.dart';
part 'systems/weapon_triggering_system.dart';
part 'systems/collision_system.dart';
part 'systems/ui_system.dart';

GameSettings settings;
CanvasManager canvasManager;
SceneManager sceneManager;
ComponentAttacher componentAttacher;

void main() {
  settings = new GameSettings();
  componentAttacher = new ComponentAttacher();
  canvasManager = new CanvasManager(query("#space_game_canvas"));
  sceneManager = new SceneManager();
  sceneManager.run();
  sceneManager.addScene("mainmenu", new MainMenuScene());
  sceneManager.addScene("game", new GameScene());
  sceneManager.changeScene("game");
}