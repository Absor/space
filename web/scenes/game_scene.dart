part of space;

class GameScene implements Scene {
  
  World _world;
  Timer _gameTick;
  ImageRenderingSystem _imageRenderingSystem;
  DebuggingSystem _debuggingSystem;
  UISystem _uiSystem;
  
  bool _processing;
    
  GameScene() {
    _processing = false;
    _world = new World();
    _imageRenderingSystem = new ImageRenderingSystem();
    MovementSystem movementSystem = new MovementSystem();
    FollowerSystem followerSystem = new FollowerSystem();
    EntitySpawningSystem entitySpawningSystem = new EntitySpawningSystem();
    _debuggingSystem = new DebuggingSystem();
    WandererSystem wandererSystem = new WandererSystem();
    PathFollowerSystem pathFollowerSystem = new PathFollowerSystem();
    AttachSystem attachSystem = new AttachSystem();
    WeaponTriggeringSystem weaponTriggeringSystem = new WeaponTriggeringSystem();
    _uiSystem = new UISystem();
    WeaponShootingSystem weaponShootingSystem = new WeaponShootingSystem();
    TargetPredictingSystem targetPredictingSystem = new TargetPredictingSystem();
    
    _imageRenderingSystem.enabled = false;
    movementSystem.enabled = true;
    followerSystem.enabled = true;
    entitySpawningSystem.enabled = true;
    _debuggingSystem.enabled = false;
    wandererSystem.enabled = true;
    pathFollowerSystem.enabled = true;
    attachSystem.enabled = true;
    weaponTriggeringSystem.enabled = true;
    _uiSystem.enabled = false;
    weaponShootingSystem.enabled = true;
    targetPredictingSystem.enabled = true;
    
    entitySpawningSystem.priority = 0;
    
    // pathfollower uses follower so it has to be before
    pathFollowerSystem.priority = 5;
    // steering systems before movement
    followerSystem.priority = 10;
    wandererSystem.priority = 10;
    
    movementSystem.priority = 15;
    // attach after movement
    attachSystem.priority = 20;
    
    // 1. choose target
    // 2. target chosen target
    targetPredictingSystem.priority = 30;
    // 3. trigger weapon
    weaponTriggeringSystem.priority = 40;
    // 4. shoot weapon
    weaponShootingSystem.priority = 50;
    
    // debugging draws on other (not used)
    _imageRenderingSystem.priority = 80;
    _uiSystem.priority = 90;
    _debuggingSystem.priority = 100;
    
    _world.addSystem(entitySpawningSystem);
    _world.addSystem(followerSystem);
    _world.addSystem(movementSystem);
    _world.addSystem(_imageRenderingSystem);
    _world.addSystem(_debuggingSystem);
    _world.addSystem(wandererSystem);
    _world.addSystem(pathFollowerSystem);
    _world.addSystem(attachSystem);
    _world.addSystem(weaponTriggeringSystem);
    _world.addSystem(_uiSystem);
    _world.addSystem(weaponShootingSystem);
    _world.addSystem(targetPredictingSystem);
  }
  
  void draw() {
    canvasManager.clearCanvas();
    _imageRenderingSystem.process(0);
    _uiSystem.process(0);
    if (settings.debug) _debuggingSystem.process(0);
  }
  
  void start() {
    _gameTick = new Timer.periodic(new Duration(milliseconds:15), (t) {
      if (!_processing) {
        _processing = true;
        _world.process(15);
        _processing = false;
      }
    });
  }
  
  void stop() {
    _gameTick.cancel();
  }
}