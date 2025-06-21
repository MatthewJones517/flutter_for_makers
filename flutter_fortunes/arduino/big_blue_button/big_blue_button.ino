const int BUTTONPIN = 2;
const int LIGHTPIN = A7;

int buttonState = 0;         
int lastButtonState = HIGH;  

bool fortuneReadingActive = false;


void setup() {
  Serial.begin(9600);

  pinMode(BUTTONPIN, INPUT_PULLUP);
  pinMode(LIGHTPIN, OUTPUT);
}

void loop() {
  buttonState = digitalRead(BUTTONPIN);

  if (buttonState != lastButtonState) {

    if (buttonState == LOW && !fortuneReadingActive) {
      fortuneReadingActive = true;
      digitalWrite(LIGHTPIN, HIGH);
      Serial.println("ACTIVATE");
    }

    delay(50);
  }

  listenForSerialUpdate();

  lastButtonState = buttonState;
}

void listenForSerialUpdate() {
  if (Serial.available() > 0) {
    String command = Serial.readStringUntil('\n');
    
    command.trim();

    if (command == "DEACTIVATE") {
      digitalWrite(LIGHTPIN, LOW);
      fortuneReadingActive = false;
    } 
  }
}