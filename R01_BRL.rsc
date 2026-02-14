# ============================================================
# Конфигурация роутера R01.BRL (Берлин)
# Лабораторная работа №2 — Статическая маршрутизация
# ============================================================
# Этот роутер находится в берлинском офисе.
# ether1 — канал до Москвы (R01.MSK)
# ether2 — канал до Франкфурта (R01.FRT)
# ether3 — локальная сеть офиса (PC3)
# ============================================================

# --- Установка имени устройства ---
/system identity set name=R01.BRL

# --- Смена пароля администратора ---
/user set [find name=admin] password=admin

# --- Настройка IP-адресов на интерфейсах ---
/ip address
add address=10.10.1.2/30 interface=ether1 comment="Канал до Москвы (R01.MSK)"
add address=10.10.3.1/30 interface=ether2 comment="Канал до Франкфурта (R01.FRT)"
add address=192.168.30.1/24 interface=ether3 comment="Локальная сеть офиса Берлин"

# --- Настройка DHCP-сервера ---
/ip pool
add name=pool_berlin ranges=192.168.30.10-192.168.30.254

/ip dhcp-server
add name=dhcp_berlin interface=ether3 address-pool=pool_berlin disabled=no

/ip dhcp-server network
add address=192.168.30.0/24 gateway=192.168.30.1 dns-server=8.8.8.8

# --- Настройка статических маршрутов ---

# До сети Москвы — через R01.MSK (наш сосед на ether1)
/ip route
add dst-address=192.168.10.0/24 gateway=10.10.1.1 comment="До сети Москвы через R01.MSK"

# До сети Франкфурта — через R01.FRT (наш сосед на ether2)
add dst-address=192.168.20.0/24 gateway=10.10.3.2 comment="До сети Франкфурта через R01.FRT"

# До линка Москва-Франкфурт — через R01.MSK
add dst-address=10.10.2.0/30 gateway=10.10.1.1 comment="До линка MSK-FRT через R01.MSK"
