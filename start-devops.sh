#!/bin/bash

echo "🚀 Starting Complete DevOps Platform..."

echo "-------------------------------------"
echo "1️⃣ Starting Minikube Cluster"
echo "-------------------------------------"
minikube start

echo ""
echo "Waiting for Kubernetes to stabilize..."
sleep 10

echo ""
echo "-------------------------------------"
echo "2️⃣ Checking Kubernetes Pods"
echo "-------------------------------------"
kubectl get pods -A

echo ""
echo "-------------------------------------"
echo "3️⃣ Starting Jenkins"
echo "-------------------------------------"
docker start jenkins 2>/dev/null || echo "Jenkins already running"

echo ""
echo "-------------------------------------"
echo "4️⃣ Starting SonarQube"
echo "-------------------------------------"
docker start sonarqube 2>/dev/null || echo "SonarQube already running"

echo ""
echo "-------------------------------------"
echo "5️⃣ Starting ngrok tunnel for Jenkins"
echo "-------------------------------------"
pkill ngrok 2>/dev/null

nohup ngrok http 8080 > ngrok.log 2>&1 &
sleep 5

echo ""
echo "ngrok URL:"
grep -o 'https://[0-9a-z]*\.ngrok-free\.app' ngrok.log | head -n 1

echo ""
echo "-------------------------------------"
echo "6️⃣ Checking Monitoring Stack"
echo "-------------------------------------"

kubectl get pods -n default | grep monitoring
kubectl get pods -n default | grep prometheus
kubectl get pods -n default | grep grafana
kubectl get pods -n default | grep loki

echo ""
echo "-------------------------------------"
echo "7️⃣ Checking Microservices"
echo "-------------------------------------"

kubectl get pods | grep auth
kubectl get pods | grep product
kubectl get pods | grep order

echo ""
echo "-------------------------------------"
echo "8️⃣ Getting Minikube IP"
echo "-------------------------------------"

MINIKUBE_IP=$(minikube ip)

echo ""
echo "Services URLs:"
echo "Auth Service: http://$MINIKUBE_IP:30007"
echo "Product Service: http://$MINIKUBE_IP:30008"
echo "Order Service: http://$MINIKUBE_IP:30009"

echo ""
echo "Grafana:"
echo "kubectl port-forward svc/monitoring-grafana 3000:80"

echo ""
echo "Prometheus:"
echo "kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090"

echo ""
echo "SonarQube:"
echo "http://localhost:9000"

echo ""
echo "Jenkins:"
echo "http://localhost:8080"

echo ""
echo "✅ DevOps Platform Fully Started"