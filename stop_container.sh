#!/bin/bash

# Detener el contenedor si está en ejecución
sudo docker stop pruebas || true
sudo docker rm pruebas || true