#!/bin/sh
cd C:/Users/USUARIO/Desktop/MAESTRIA/Tesis-Maestria/NuevaPrueba
git add --all
timestamp() {
  date +"at %H:%M:%S on %d/%m/%Y"
}
git commit -am "Nuevo commit"
git push origin main