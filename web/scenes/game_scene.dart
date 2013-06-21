part of space;

class GameScene implements Scene {
  
  World _world;
  Timer _gameTick;
  RenderingSystem _renderingSystem;
  IdManager _idManager;
    
  GameScene() {
    _idManager = new IdManager();
    _world = new World();
    _renderingSystem = new RenderingSystem();
    MovementSystem movementSystem = new MovementSystem();
    FollowerSystem followerSystem = new FollowerSystem();
    EnemySystem enemySystem = new EnemySystem(_idManager);
    DebuggingSystem debuggingSystem = new DebuggingSystem();
    WandererSystem wandererSystem = new WandererSystem();
    PathFollowerSystem pathFollowerSystem = new PathFollowerSystem();
    
    _renderingSystem.enabled = false;
    movementSystem.enabled = true;
    followerSystem.enabled = true;
    enemySystem.enabled = true;
    debuggingSystem.enabled = true;
    wandererSystem.enabled = true;
    pathFollowerSystem.enabled = true;
    
    enemySystem.priority = 0;
    pathFollowerSystem.priority = 4;
    followerSystem.priority = 5;
    wandererSystem.priority = 5;
    movementSystem.priority = 10;
    _renderingSystem.priority = 50;
    debuggingSystem.priority = 100;
    
    _world.addSystem(enemySystem);
    _world.addSystem(followerSystem);
    _world.addSystem(movementSystem);
    _world.addSystem(_renderingSystem);
    _world.addSystem(debuggingSystem);
    _world.addSystem(wandererSystem);
    _world.addSystem(pathFollowerSystem);
    
    _addBackground();
    _addPlayer();
  }
  
  void _addBackground() {    
    RenderComponent rc = new RenderComponent();
    rc.imageScaler = 2;
    rc.sourceWidth = 2048;
    rc.sourceHeight = 1536;
    rc.sourceX = 0;
    rc.sourceY = 0;
    rc.xOffset = -1024;
    rc.yOffset = -768;
    rc.source = new ImageElement(src:"assets/background.png");
    
    RotationComponent rotation = new RotationComponent();
    rotation.angleInDegrees = 0;
    
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 3; x++) {
        Entity background = _world.createEntity(_idManager.getFreeId());
        background.addComponent(rc);
        PositionComponent pc = new PositionComponent();
        pc.position = new Vector2((-4096 + 4096 * x).toDouble(),
            (-3072 + 3072 * y).toDouble());
        background.addComponent(pc);
        background.addComponent(rotation);
        _world.activateEntity(background.id);
      }
    }
  }
  
  void _addPlayer() {
    Entity player = _world.createEntity(_idManager.getFreeId());
    
    RenderComponent rc = new RenderComponent();
    rc.imageScaler = 1;
    rc.sourceWidth = 182;
    rc.sourceHeight = 248;
    rc.sourceX = 0;
    rc.sourceY = 0;
    rc.xOffset = -91;
    rc.yOffset = -124;
    rc.source = new ImageElement(src:"assets/testship.png");
    player.addComponent(rc);
    
    PositionComponent pc = new PositionComponent();
    pc.position = new Vector2.zero();
    player.addComponent(pc);
    
    RotationComponent rotation = new RotationComponent();
    rotation.angleInDegrees = 90;
    player.addComponent(rotation);
    
    AccelerationComponent ac = new AccelerationComponent();
    ac.acceleration = new Vector2(0.0, 0.0);
    ac.maxForce = 0;
    player.addComponent(ac);
    
    VelocityComponent vc = new VelocityComponent();
    vc.velocity = new Vector2(0.0, 0.0);
    vc.maxVelocity = 0;
    player.addComponent(vc);
    
    player.addComponent(new CameraCenteringComponent());
    
    _world.activateEntity(player.id);
  }
  
  void draw() {
    canvasManager.clearCanvas();
    _renderingSystem.process(0);
  }
  
  void start() {
    _gameTick = new Timer.periodic(new Duration(milliseconds:15), (t) {
      _world.process(15);
    });
  }
  
  void stop() {
    _gameTick.cancel();
  }
}