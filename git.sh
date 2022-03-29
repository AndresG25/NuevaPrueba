#!/bin/sh
cd c:/Users/USUARIO/Desktop/MAESTRIA/Tesis-Maestria/NuevaPrueba
git add --all
timestamp() {
  date +"at %H:%M:%S on %d/%m/%Y"
}
git commit -am "Regular auto-commit $(timestamp)"
git push origin main