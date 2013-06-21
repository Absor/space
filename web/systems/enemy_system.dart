part of space;

class EnemySystem implements System {
  
  bool enabled;
  int priority;
  
  bool spawned;
  World _world;
  IdManager _idManager;
  Entity _player;
    
  EnemySystem(this._idManager) {
    spawned = false;
  }
  
  void _addEnemy() {
    Entity enemy = _world.createEntity(_idManager.getFreeId());
    
    RenderComponent rc = new RenderComponent();
    rc.imageScaler = 0.5;
    rc.sourceWidth = 182;
    rc.sourceHeight = 248;
    rc.sourceX = 0;
    rc.sourceY = 0;
    rc.xOffset = -91;
    rc.yOffset = -124;
    rc.source = new ImageElement(src:"assets/testship.png");
    enemy.addComponent(rc);
    
    PositionComponent pc = new PositionComponent();
    pc.position = new Vector2(100.0, 100.0);
    enemy.addComponent(pc);
    
    RotationComponent roc = new RotationComponent();
    roc.angleInDegrees = 0;
    enemy.addComponent(roc);
    
    AccelerationComponent ac = new AccelerationComponent();
    ac.maxForce = 1000;
    ac.acceleration = new Vector2.zero();
    enemy.addComponent(ac);
    
    VelocityComponent vc = new VelocityComponent();
    vc.velocity = new Vector2.zero();
    vc.maxVelocity = 500;
    enemy.addComponent(vc);
    
    FollowerComponent fc = new FollowerComponent();
//    fc.targetId = _player.id;
    fc.targetPosition = new Vector2.zero();
    enemy.addComponent(fc);
    
//    WandererComponent wc = new WandererComponent();
//    wc.wanderAngle = 0;
//    wc.wanderChange = 30 * PI / 180;
//    enemy.addComponent(wc);
    
    PathFollowerComponent pfc = new PathFollowerComponent();
    pfc.pathPoints = new List<Vector2>();
    for (int i = 0; i < 36; i++) {
      num angle = 2*PI * (i/36);
      pfc.pathPoints.add(new Vector2(400*cos(angle), 400*sin(angle)));
    }
    enemy.addComponent(pfc);
    
    _world.activateEntity(enemy.id);
  }
  
  void process(num timeDelta) {
    if (_player == null) return;
    
    if (!spawned) _addEnemy();
    spawned = true;
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CameraCenteringComponent)) {
      _player = entity;
    }
  }
  
  void entityDeactivation(Entity entity) {
    if (_player == entity) _player = null;
  }
}