const int POT_PIN = A1;
const int SMOOTHING_SAMPLES = 20;
const int UPPER_DEADBAND = 1008;

int readings[SMOOTHING_SAMPLES];
int readIndex = 0;
int total = 0;
int average = 0;


void setup() {
   Serial.begin(9600);

    for (int i = 0; i < SMOOTHING_SAMPLES; i++) {
         readings[i] = 0;
       }
}

void loop() {
  total = total - readings[readIndex];

  int potValue = analogRead(POT_PIN);

  if (potValue >= UPPER_DEADBAND) {
    potValue = 1023;
  }

  readings[readIndex] = potValue;

  total = total + readings[readIndex];

  readIndex = (readIndex + 1) % SMOOTHING_SAMPLES;

  average = total / SMOOTHING_SAMPLES;

  int scaledValue = map(average, 0, 1023, 0, 100);
  Serial.println(scaledValue);

  delay(10);
}
