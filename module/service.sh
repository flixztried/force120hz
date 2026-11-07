#!/system/bin/sh
# Refresh Rate Lock - late-boot enforcement

LOG=/data/local/tmp/refresh_lock.log
i=0

while [ "$(getprop sys.boot_completed)" != "1" ] && [ $i -lt 120 ]; do
    sleep 1
    i=$((i + 1))
done

[ "$(getprop sys.boot_completed)" = "1" ] || exit 0

echo "$(date): boot complete" >> "$LOG"

resetprop debug.sf.set_idle_timer_ms 0 || true
resetprop debug.sf.set_touch_timer_ms 0 || true
resetprop debug.sf.frame_rate_multiple_threshold 120 || true

settings put system min_refresh_rate 120.0 || true
settings put system peak_refresh_rate 120.0 || true
settings put system user_refresh_rate 120.0 || true

settings put secure min_refresh_rate 120.0 || true
settings put secure peak_refresh_rate 120.0 || true
settings put secure user_refresh_rate 120.0 || true

settings put global min_refresh_rate 120.0 || true
settings put global peak_refresh_rate 120.0 || true

sleep 2
echo "$(date): lock applied" >> "$LOG"
