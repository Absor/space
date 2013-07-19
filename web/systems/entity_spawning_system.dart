part of space;

class EntitySpawningSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  Entity _player;
  
  num _spawnTimer;
  RandomShipGenerator _rsg;
    
  EntitySpawningSystem() {
    _spawnTimer = 25000;
    _rsg = new RandomShipGenerator();
  }
  
  void _addPlayer() {
    _player = new EntityBuilder(_world.createEntity(idManager.getFreeId()))
    .addImageComponent("testship")
    .addPositionComponent(new Vector2.zero())
    .addCameraCenteringComponent()
    .build();
    
    Entity turret =  new EntityBuilder(_world.createEntity(idManager.getFreeId()))
    .addImageComponent("testturret")
    .addPositionComponent(new Vector2.zero())
    .addRotationComponent(0)
    .addAttachComponent(_player.id, new Vector2(0.0, 60.0))
    .addWeaponTriggerComponent(true)
    .addRepeatingWeaponComponent(100, 0)
    .addWeaponAttributesComponent(500)
    .addSingleDirectionWeaponComponent()
    .addPlayerWeaponComponent()
    .addPredictingWeaponComponent()
    .build();

    _world.activateEntity(_player.id);
    _world.activateEntity(turret.id);
  }
  
  void _addEnemy() {
    Entity enemy = _world.createEntity(idManager.getFreeId());
    attachBasicEnemyComponents(enemy);
    _world.activateEntity(enemy.id);
  }
  
  void attachBasicEnemyComponents(Entity enemy) {
    ImageComponent rc = assetManager.getAsset("image_component", "testship");
    enemy.addComponent(rc);
    
    ImageScalingComponent isc = new ImageScalingComponent();
    isc.imageScaler = 0.5;
    enemy.addComponent(isc);
    
    PositionComponent pc = new PositionComponent();
    num startAngle = new Random().nextDouble() * PI*2;
    pc.position = new Vector2(2000*cos(startAngle), 2000*sin(startAngle));
    enemy.addComponent(pc);
    
    RotationComponent roc = new RotationComponent();
    roc.angleInDegrees = 0;
    enemy.addComponent(roc);
    
    AccelerationComponent ac = new AccelerationComponent();
    ac.maxForce = 5000;
    ac.acceleration = new Vector2.zero();
    enemy.addComponent(ac);
    
    VelocityComponent vc = new VelocityComponent();
    vc.velocity = new Vector2.zero();
    vc.maxVelocity = 1500;
    enemy.addComponent(vc);
    
    CollisionComponent cc = new CollisionComponent();
    cc.collisionRadius = 50;
    enemy.addComponent(cc);
    
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
    num distance = new Random().nextInt(600) + 400;
    for (int i = 0; i < 9; i++) {
      num angle = 2*PI * (i/8);
      pfc.pathPoints.add(new Vector2(distance*cos(angle), distance*sin(angle)*0.6));
    }
    enemy.addComponent(pfc);
    
    enemy.addComponent(new EnemyComponent());
  }
  
  void _addBackground() {
    Entity background = new EntityBuilder(_world.createEntity(idManager.getFreeId()))
    .addImageComponent("background")
    .addPositionComponent(new Vector2.zero())
    .addImageScalingComponent(3)
    .build();
    _world.activateEntity(background.id);
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