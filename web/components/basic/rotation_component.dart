part of space;

class RotationComponent extends Component {
  
  num _angleInDegrees;
  num _angleInRadians;
  
  num get angleInDegrees => _angleInDegrees;
  num get angleInRadians => _angleInRadians;
  
  set angleInDegrees(num angle) {
    _angleInDegrees = angle;
    _angleInRadians = angle * degreeRadian;
  }
  
  set angleInRadians(num angle) {
    _angleInRadians = angle;
    _angleInDegrees = angle / degreeRadian;
  }
  
  static num degreeRadian = PI / 180;
}