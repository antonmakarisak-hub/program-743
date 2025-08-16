#!/usr/bin/env bash
set -euo pipefail

echo "[apply_baro_patch] Searching for MatekH743 hwdef.dat..."

CANDIDATES=(
  "libraries/AP_HAL_ChibiOS/hwdef/MatekH743/hwdef.dat"
  "libraries/AP_HAL_ChibiOS/hwdef/boards/MatekH743/hwdef.dat"
  "hwdef/boards/MatekH743/hwdef.dat"
)

TARGET=""

for f in "${CANDIDATES[@]}"; do
  if [[ -f "$f" ]]; then
    TARGET="$f"
    break
  fi
done

if [[ -z "${TARGET}" ]]; then
  TARGET=$(git ls-files | grep -E "/MatekH743.*/hwdef\.dat$" | head -n1 || true)
fi

if [[ -z "${TARGET}" || ! -f "${TARGET}" ]]; then
  echo "ERROR: hwdef.dat for MatekH743 not found."
  git ls-files | grep -E "hwdef\.dat$" || true
  exit 1
fi

echo "[apply_baro_patch] Using hwdef: ${TARGET}"

append_define () {
  local DEF="$1"
  if ! grep -qE "^\s*define\s+${DEF}\b" "${TARGET}"; then
    echo "define ${DEF} 1" >> "${TARGET}"
    echo "[apply_baro_patch] + ${DEF}"
  else
    echo "[apply_baro_patch] ${DEF} already present"
  fi
}

# Ensure a blank line before our block (cosmetic)
echo "" >> "${TARGET}"
echo "# --- BEGIN: aggressive barometer enables for MatekH743 ---" >> "${TARGET}"

append_define "HAL_BARO_ALLOW_ALL"

# Common barometer driver toggles (broad coverage)
append_define "DRIVER_BARO_MS5611"
append_define "DRIVER_BARO_BMP280"
append_define "DRIVER_BARO_BMP388"
append_define "DRIVER_BARO_BMP3XX"
append_define "DRIVER_BARO_BMP390"
append_define "DRIVER_BARO_BMP085"
append_define "DRIVER_BARO_DPS310"
append_define "DRIVER_BARO_DPS368"
append_define "DRIVER_BARO_DPS280"
append_define "DRIVER_BARO_LPS22HB"
append_define "DRIVER_BARO_LPS25H"
append_define "DRIVER_BARO_LPS33HW"
append_define "DRIVER_BARO_SPL06"
append_define "DRIVER_BARO_MS5837"
append_define "DRIVER_BARO_MS5803"
append_define "DRIVER_BARO_MS5637"
append_define "DRIVER_BARO_MPL3115A2"
append_define "DRIVER_BARO_DLVR"
append_define "DRIVER_BARO_KELLERLD"

echo "# --- END: aggressive barometer enables ---" >> "${TARGET}"

echo "[apply_baro_patch] Done."
