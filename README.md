# Refresh Rate Lock

A Magisk / BakaSU flashable module that forces a 120Hz refresh rate system-wide and disables SurfaceFlinger idle/touch-timer downscaling.

## What it does

- Zeroes `ro.surface_flinger.set_idle_timer_ms`, `set_touch_timer_ms`, and `set_display_power_timer_ms` at boot so the compositor never falls back to 60Hz on inactivity.
- Disables content-detection refresh-rate voting.
- Sets `debug.sf.frame_rate_multiple_threshold=120` so the scheduler favours the highest available mode for high-FPS layers.
- After `sys.boot_completed`, writes `min_refresh_rate`, `peak_refresh_rate`, and `user_refresh_rate = 120.0` into the `system`, `secure`, and `global` settings namespaces to survive framework re-application.

## Requirements
- Magisk, KernelSU, or APatch
- Works on any AOSP-derived ROM (LineageOS, crDroid, Pixel, Evolution X, etc).

## Install
Grab `refresh_lock_120-v1.0.0.zip` from the Releases page, flash it in Magisk or BakaSU, then reboot.

Verify after boot:
```sh
getprop ro.surface_flinger.set_idle_timer_ms    # 0
getprop debug.sf.frame_rate_multiple_threshold  # 120
settings get system peak_refresh_rate           # 120.0
```

## Limitations
This is a software lock. It cannot override hardware-level thermal throttling.

## License
MIT
