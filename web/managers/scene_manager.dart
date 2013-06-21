part of space;

class SceneManager {
  
  Map<String, Scene> _scenes;
  Scene _currentScene;
  
  SceneManager() {
    _scenes = new HashMap<String, Scene>();
  }
  
  void run() {
    _run();
  }
  
  void _run() {
    if (_currentScene != null) _currentScene.draw();
    window.animationFrame.then((t) => _run());
  }
  
  void addScene(String name, Scene scene) {
    _scenes[name] = scene;
  }
  
  void changeScene(String name) {
    if (_currentScene != null) {
      Scene oldScene = _currentScene;
      _currentScene = null;
      oldScene.stop();
    }
    Scene newScene = _scenes[name];
    if (newScene != null) {
      newScene.start();
      _currentScene = newScene;
    }
  }
}