part of space;

class EntitySpawningSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  IdManager _idManager;
  Entity _player;
  
  num _spawnTimer;
    
  EntitySpawningSystem() {
    _spawnTimer = 25000;
    _idManager = new IdManager();
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
    _player = _world.createEntity(_idManager.getFreeId());
    componentAttacher.attachPlayerComponents(_player);
    _world.activateEntity(_player.id);
  }
  
  void _addEnemy() {
    Entity enemy = _world.createEntity(_idManager.getFreeId());
    componentAttacher.attachBasicEnemyComponents(enemy);
    _world.activateEntity(enemy.id);
  }
    
  void process(num timeDelta) {
    if (_player == null) return;
    _spawnTimer += timeDelta;
    if (_spawnTimer > 30000) {
      _spawnTimer -= 30000;
      _addEnemy();
    }
  }
    
  void attachWorld(World world) {
    _world = world;
    _addBackground();
    _addPlayer();
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
  }
  
  void entityDeactivation(Entity entity) {
  }
}