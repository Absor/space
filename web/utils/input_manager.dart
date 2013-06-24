part of space;

class InputManager {
  
  Vector2 _canvasMousePosition;
  bool isMouseDown;
  
  Vector2 get canvasMousePosition => _canvasMousePosition;
  
  InputManager() {
    _canvasMousePosition = new Vector2.zero();
    isMouseDown = false;
    canvasManager.canvas.onMouseDown.listen(_onMouseDown);
    canvasManager.canvas.onMouseUp.listen(_onMouseUp);
    canvasManager.canvas.onMouseMove.listen(_onMouseMove);
  }

  void _onMouseDown(MouseEvent event) {
    event.preventDefault();
    isMouseDown = true;
    _onMouseMove(event);
  }
  
  void _onMouseUp(MouseEvent event) {
    isMouseDown = false;
    _onMouseMove(event);
  }
  
  void _onMouseMove(MouseEvent event) {
    _canvasMousePosition.setValues(event.layer.x.toDouble(), event.layer.y.toDouble());
  }
}