sequenceDiagram
    participant Developer
    participant GitHub
    participant Jenkins
    participant DockerHub
    participant Nexus
    participant Terraform
    participant Ansible
    participant KubernetesMaster
    participant KubernetesWorker
    participant Nginx
    participant Prometheus
    participant Grafana
    participant Trivy
    participant SonarQube

    Developer ->> GitHub: Push code
    GitHub ->> Jenkins: Trigger pipeline

    alt CI/CD Pipeline
        Jenkins ->> DockerHub: Build Docker image
        DockerHub ->> Nexus: Push Docker image
        Nexus ->> DockerHub: Push Docker image
        Jenkins ->> Trivy: Scan image security
        Jenkins ->> SonarQube: Analyze code quality
    end

    Jenkins ->> Terraform: Provision infrastructure
    Terraform ->> Ansible: Create Master Node
    Terraform ->> Ansible: Create Worker Nodes
    Ansible ->> Nginx: Setup reverse proxy
    Ansible ->> KubernetesMaster: Configure and install
    Ansible ->> KubernetesWorker: Configure and install
    KubernetesMaster ->> KubernetesWorker: Schedule workloads
    KubernetesWorker ->> KubernetesWorker: Run containers (PetClinic app)
    Nginx ->> KubernetesWorker: Forward traffic
    KubernetesWorker ->> Prometheus: Collect metrics
    Prometheus ->> Grafana: Show metrics

    Note over Jenkins, Trivy: Security Scanning
    Note over Jenkins, SonarQube: Code Quality Analysis