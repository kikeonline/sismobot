# SismoBot
Este es un script escrito en BASH para monitorear los últimos sismos en Nicaragua detectados por INETER.
![alt tag](https://raw.githubusercontent.com/kikeonline/sismobot/master/readme/screen.png)


Ejectuar Script desde server remoto.
```bash
$bash <(curl -s http://kike.work/sismobot.sh)
```

Ejectuar Script localmente.
```bash
$./sismobot.sh
```

Ejectuar Script con argumento -l para leer todos la lista de sismos.
```bash
$./sismobot.sh -l
```

### INETER
Los datos provienen de http://www.ineter.gob.ni/
