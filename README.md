# ArduPlane Actions — Matek H743 V3 (All Baro Drivers)

Це готовий репозиторій для GitHub Actions, який збирає **ArduPlane (Plane)** під **Matek H743 V3** і публікує артефакти:
- `arduplane.apj`
- `arduplane.hex`

Додатково застосовується патч, який:
- вмикає **усі основні баро-драйвери** (BMP085/180, BMP280, BMP388, MS5611, DPS280, DPS310, LPS25/22),
- додає `HAL_BARO_ALLOW_ALL=1` для максимального охоплення.

## Використання
1. Створи порожній репозиторій на GitHub.
2. Завантаж вміст цього архіву.
3. Вкладка **Actions** → обери **Build ArduPilot for Matek H743 (Plane)** → **Run workflow**.
4. По завершенню скачай артефакт `arduplane_artifacts.zip` (всередині `.apj` і `.hex`).

## Прошивання
- **Mission Planner** → Install Firmware → Load custom firmware → вибери `arduplane.apj`.
- Або проший `arduplane.hex` через DFU/STM32CubeProgrammer (обережно зі стиранням!).
