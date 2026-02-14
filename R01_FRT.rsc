# ============================================================
# Конфигурация роутера R01.FRT (Франкфурт)
# Лабораторная работа №2 — Статическая маршрутизация
# ============================================================
# Этот роутер находится во франкфуртском офисе.
# ether1 — канал до Берлина (R01.BRL)
# ether2 — канал до Москвы (R01.MSK)
# ether3 — локальная сеть офиса (PC2)
# ============================================================

# --- Установка имени устройства ---
/system identity set name=R01.FRT

# --- Смена пароля администратора ---
/user set [find name=admin] password=admin

# --- Настройка IP-адресов на интерфейсах ---
/ip address
add address=10.10.3.2/30 interface=ether1 comment="Канал до Берлина (R01.BRL)"
add address=10.10.2.2/30 interface=ether2 comment="Канал до Москвы (R01.MSK)"
add address=192.168.20.1/24 interface=ether3 comment="Локальная сеть офиса Франкфурт"

# --- Настройка DHCP-сервера ---
# Аналогично Москве — для автоматической выдачи IP сотрудникам
/ip pool
add name=pool_frankfurt ranges=192.168.20.10-192.168.20.254

/ip dhcp-server
add name=dhcp_frankfurt interface=ether3 address-pool=pool_frankfurt disabled=no

/ip dhcp-server network
add address=192.168.20.0/24 gateway=192.168.20.1 dns-server=8.8.8.8

# --- Настройка статических маршрутов ---

# До сети Москвы — через R01.MSK (наш сосед на ether2)
/ip route
add dst-address=192.168.10.0/24 gateway=10.10.2.1 comment="До сети Москвы через R01.MSK"

# До сети Берлина — через R01.BRL (наш сосед на ether1)
add dst-address=192.168.30.0/24 gateway=10.10.3.1 comment="До сети Берлина через R01.BRL"

# До линка Москва-Берлин — через R01.MSK
add dst-address=10.10.1.0/30 gateway=10.10.2.1 comment="До линка MSK-BRL через R01.MSK"
