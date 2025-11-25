# KDE Plasma — Команды и настройки из видео (Часть 2)

Этот файл содержит все команды и пути, которые использовались во второй части видео про настройку KDE Plasma в Arch Linux.

---

## 1. Очистка системы

### 🧹 Удаление лишних пакетов из группы `kde-applications`

В первой части мы установили группу **kde-applications**. Она состоит из множества подгрупп, и многие из них можно удалить без потери важного функционала.

#### Полезные команды:

```bash
pacman -Sg | grep kde        # Показать все группы KDE в репозиториях
pacman -Qg | grep kde        # Какие группы KDE установлены в системе
pacman -Qg kde-games         # Состав конкретной группы
```

#### Удалить мультимедиа-пакеты:

```bash
sudo pacman -Rn kde-multimedia  # кроме ffmpegthumbs
```

#### Удалить образовательные приложения:

```bash
sudo pacman -Rn kde-education
```

#### Удалить офисные программы:

```bash
sudo pacman -Rn kde-office
```

#### Удалить игры:

```bash
sudo pacman -Rn kde-games
```

---

## 1.1. Удаление тем, иконок и оформления вручную

Пути к локальным пользовательским директориям:

```bash
~/.local/share/plasma/look-and-feel/     # Темы окружения (Look-and-Feel)
~/.local/share/color-schemes/            # Цветовые схемы
~/.local/share/plasma/desktoptheme/      # Темы рабочего стола
~/.local/share/aurorae/themes/           # Оформление окон
~/.local/share/icons/                    # Иконки
~/.icons/                                # Курсоры
```

---

## 2. Виртуальная клавиатура в KDE Plasma

### 2.1 Qt Virtual Keyboard 

#### Установка:

```bash
sudo pacman -S qt6-virtualkeyboard
```

#### Добавить метод ввода для SDDM:

Файл: `/etc/sddm.conf.d/10-virtualkeyboard.conf`

```
[General]
InputMethod=qtvirtualkeyboard
```

---

### 2.2 plasma-keyboard (встроенная клавиатура Plasma для Wayland)

#### Установка:

```bash
sudo pacman -S plasma-keyboard
```

#### Настройки SDDM:

Файл: `/etc/sddm.conf.d/10-virtualkeyboard.conf`

```
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1 --inputmethod plasma-keyboard
```

#### Включить отображение методов ввода для окон:

Файл: `/etc/environment`

```
KWIN_IM_SHOW_ALWAYS=1
```

---

## 3. Cron: проверка обновлений, автоматизация и kcron

### Проверить установленный cron:

```bash
pacman -Q cron
```

### Проверить активность сервисов:

```bash
systemctl is-active cronie    # cronie
systemctl is-active fcron     # fcron
```

### Заменить fcron → cronie:

```bash
sudo pacman -S cronie
```

Pacman автоматически предложит удалить `fcron`.

### Отключить старый cron:

```bash
sudo systemctl disable --now fcron
```

### Включить новый cron:

```bash
sudo systemctl enable --now cronie
```

### Проверить задания crontab:

```bash
crontab -l
```

Теперь kcron работает корректно и задачи можно добавлять через графический интерфейс KDE.
#### 📺 YouTube: [KDE Plasma часть 2](https://youtu.be/w2s3jBl4mLk)

#### [Скрипт проверки обновлений](scripts/cron-checkupdates.sh)
