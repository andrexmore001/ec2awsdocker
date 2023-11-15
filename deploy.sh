#!/bin/bash

# Obtener la última imagen desde ECR
sudo docker pull 738333466680.dkr.ecr.us-east-1.amazonaws.com/ec2aws:latest

# Iniciar el nuevo contenedor
sudo docker run -d -p 80:80 --name pruebas 738333466680.dkr.ecr.us-east-1.amazonaws.com/ec2aws:latest