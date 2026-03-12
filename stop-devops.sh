#!/bin/bash

echo "🛑 Stopping DevOps Platform..."

echo ""
echo "-------------------------------------"
echo "1️⃣ Stopping ngrok"
echo "-------------------------------------"
pkill ngrok 2>/dev/null

echo ""
echo "-------------------------------------"
echo "2️⃣ Stopping Jenkins"
echo "-------------------------------------"
docker stop jenkins 2>/dev/null

echo ""
echo "-------------------------------------"
echo "3️⃣ Stopping SonarQube"
echo "-------------------------------------"
docker stop sonarqube 2>/dev/null

echo ""
echo "-------------------------------------"
echo "4️⃣ Stopping Kubernetes Cluster"
echo "-------------------------------------"
minikube stop

echo ""
echo "-------------------------------------"
echo "5️⃣ Checking Docker Containers"
echo "-------------------------------------"
docker ps

echo ""
echo "✅ DevOps Platform Stopped"