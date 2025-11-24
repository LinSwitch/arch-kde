#!/usr/bin/env bash
# Уведомление о новых обновлениях Arch (checkupdates)

# --- переменные для cron ---
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# --- считаем пакеты ---
mapfile -t updates < <(checkupdates 2>/dev/null)
count=${#updates[@]}

# --- выводим только если есть ---
if (( count > 0 )); then
    notify-send -i system-software-update \
                "Arch 🚀" \
                "$count новых обновлений доступно
                ${updates[*]:0:3}$( ((count>3)) && echo " …и ещё $((count-3))" )"
fi
