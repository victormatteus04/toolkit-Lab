## 📝 Ativação do NVIDIA Dynamic Boost via `nvidia-powerd` (Linux)

### 🖥️ Ambiente

* **GPU**: NVIDIA GeForce RTX 4060 Laptop GPU
* **Sistema**: Ubuntu (ou derivado)
* **Driver NVIDIA**: `560.35.03` (suporta `nvidia-powerd`)
* **CUDA**: 12.6

---

### 🔍 Objetivo

Ativar o **`nvidia-powerd`**, daemon responsável por aplicar **Dynamic Boost 2.0+** no Linux, aumentando dinamicamente o **Power Limit da GPU** acima do default bloqueado pela BIOS OEM.

---

## ✅ Etapas Realizadas

### 1. Verificação do estado atual da GPU

```bash
nvidia-smi -q -d POWER
```

Exemplo de saída:

```
Current Power Limit   : 60.00 W  
Max Power Limit       : 140.00 W  
```

➡️ Indica que a GPU pode ir até 140W, mas está travada em 60W por padrão.

---

### 2. Tentativa de ajuste direto (falhou)

```bash
sudo nvidia-smi -pl 70
```

**Resultado:**

```
Changing power management limit is not supported for GPU...
```

➡️ Alteração bloqueada pela BIOS (firmware OEM).

---

### 3. Verificação da presença do daemon

```bash
find /usr -name nvidia-powerd
```

**Resultado:**

```
/usr/bin/nvidia-powerd
```

➡️ O binário existe, mas o serviço systemd não está presente.

---

### 4. Criação do serviço systemd manualmente

Arquivo criado: `/etc/systemd/system/nvidia-powerd.service`

```ini
[Unit]
Description=NVIDIA Power Daemon
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/nvidia-powerd
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Ativação:

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia-powerd
```

---

### 5. Correção de erro de D-Bus

Erro observado:

```
Error requesting D-Bus name (... not allowed to own the service "nvidia.powerd.server")
```

➡️ Causado pela falta de permissão de D-Bus.

#### Correção: criação do arquivo de política D-Bus

Arquivo criado: `/usr/share/dbus-1/system.d/nvidia-powerd.conf`

```xml
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <policy user="root">
    <allow own="nvidia.powerd.server"/>
    <allow send_destination="nvidia.powerd.server"/>
    <allow send_interface="*"/>
  </policy>
</busconfig>
```

Reinício do serviço:

```bash
sudo systemctl restart nvidia-powerd
```

---

### 6. Verificação do funcionamento

```bash
systemctl status nvidia-powerd
journalctl -u nvidia-powerd | tail -n 20
```

Saída esperada:

```
nvidia-powerd version:1.0(build 1)
Dbus Connection is established
```

---

### 7. Monitoramento do comportamento dinâmico

```bash
watch -n 0.5 'nvidia-smi -q -d POWER | grep "Current Power Limit\|Power Draw"'
```

✅ Resultado observado:

* `Default Power Limit`: 60W
* `Current Power Limit`: Dinamicamente varia entre 115W e 125W
* `Power Draw`: sobe em carga até \~75W+, comprovando operação do Dynamic Boost

---

## ✅ Resultado Final

* `nvidia-powerd` funcionando com suporte a D-Bus
* Dynamic Boost ativado com **ajuste automático de até 125W**
* Nenhuma alteração manual em `nvidia-smi -pl` necessária
* Solução 100% via software, respeitando os limites do firmware OEM
