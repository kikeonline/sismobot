# SismoBot
Shell script para monitorear los últimos sismos en Nicaragua detectados por INETER.
![alt tag](https://raw.githubusercontent.com/kikeonline/sismobot/master/readme/screen.png)

# Instalación/Uso

#### Opción 1: Ejectuar el script desde server remoto.
1. Introducir la siguiente linea en la [Terminal.](https://www.google.com.ni/search?q=google+search+link&oq=google+search+link&aqs=chrome..69i57j69i64.3252j0j4&sourceid=chrome&es_sm=119&ie=UTF-8#q=terminal+window&pws=1) 
  
  ```shell
  bash <(curl -s http://kike.work/sismobot.sh)
  ```

#### Opción 2: Ejecutuar Script localmente.
1. Bajar el script **sismobot.sh**
2. En la [Terminal](https://www.google.com.ni/search?q=google+search+link&oq=google+search+link&aqs=chrome..69i57j69i64.3252j0j4&sourceid=chrome&es_sm=119&ie=UTF-8#q=terminal+window&pws=1) dar permisos ejecutables al script.
  
  ```shell
  sudo chmod +x sismobot.sh
  ```
3. Ejecutar y seguir instrucciones.
  
  ```shell
  ./sismobot.sh
  ```
4. Con argumento ```-l``` el script lanza la lista entera de los últimos sismos.
  
  ```shell
  ./sismobot.sh -l
  ```

# Código
Si corren el script en MAC OS pueden descomentar la *linea 149* para recibir notifcaciones.
```shel
#osascript -e "display notification \"$lugar\" with title \"SismoBot\" subtitle \"$mag\" sound name \"Purr\""
```


# INETER
INSTITUTO NICARAGÜENSE DE ESTUDIOS TERRITORIALES
Los datos provienen de http://www.ineter.gob.ni/
