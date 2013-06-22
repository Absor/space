part of space;

class ComponentAttacher {
  
  void attachPlayerComponents(Entity player) {
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
    
    CollisionComponent cc = new CollisionComponent();
    cc.collisionRadius = 100;
    player.addComponent(cc);
    
    player.addComponent(new CameraCenteringComponent());
  }
  
  void attachBasicEnemyComponents(Entity enemy) {
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
      pfc.pathPoints.add(new Vector2(distance*cos(angle), distance*sin(angle)));
    }
    enemy.addComponent(pfc);
  }
}