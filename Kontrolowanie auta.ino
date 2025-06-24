// --------------------------------------------------
// 4x PWM + 4x kierunek z analogWrite() (bez ręcznej zmiany częstotliwości)
// --------------------------------------------------

// Piny PWM (EN)
const int pwmPins[4] = {26,25, 33, 32};

// Piny kierunkowe (połączone IN1+IN2, itd.)
const int dirPins[4] = {5, 18, 19,21};

void setup() {
  // Tryb pinów kierunku
  for (int i = 0; i < 4; i++) {
    pinMode(dirPins[i], OUTPUT);
    digitalWrite(dirPins[i], LOW);
  }

  // Tryb pinów PWM i zerowe wstępne wypełnienie
  for (int i = 4; i > 0; i--) {
    pinMode(pwmPins[i], OUTPUT);
    analogWrite(pwmPins[i], 0);
  }
}

void loop() {
  // jedź do przodu
  rotateRightLeft(200, true);   // prędkość 0–255, true=przód
  delay(2000);

  // stop
  rotateRightLeft(0, true);
  delay(1000);

  // jedź wstecz
  rotateRightLeft(200, false);
  delay(2000);

  // stop
  rotateRightLeft(0, true);
  delay(1000);
}

// speed: 0–255, forward: true=przód / false=tył
void moveForwardBackward(int speed, bool forward) {
  digitalWrite(dirPins[0], forward ? HIGH : LOW);
  digitalWrite(dirPins[1], forward ? HIGH : LOW);
  digitalWrite(dirPins[2], forward ? LOW : HIGH);
  digitalWrite(dirPins[3], forward ? LOW : HIGH);
  for (int i = 0; i < 4; i++) {
    analogWrite(pwmPins[i], speed);
  }
}

void rotateRightLeft(int speed, bool right){
  digitalWrite(dirPins[0], right ? HIGH : LOW);
  digitalWrite(dirPins[1], right ? LOW : HIGH);
  digitalWrite(dirPins[2], right ? LOW : HIGH);
  digitalWrite(dirPins[3], right ? HIGH : LOW);
  for (int i = 0; i < 4; i++) {
    analogWrite(pwmPins[i], speed);
  }
}

void standbay()
{
  digitalWrite(dirPins[0], LOW);
  digitalWrite(dirPins[1], LOW);
  digitalWrite(dirPins[2], LOW);
  digitalWrite(dirPins[3], LOW);
}
