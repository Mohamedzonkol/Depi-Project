```mermaid 

flowchart LR
    A(Start) --> B(Developers push code to GitHub)
    B --> C(Jenkins CI/CD pipeline triggered on code commit)
    C --> D(Build Docker image of the Java Spring PetClinic application)
    D --> E{Security Tools}
    E -->|Trivy: Docker Image Security Scanning| F(Push Docker image to Nexus repository or Docker Hub)
    E -->|SonarQube: Code Quality Analysis| F
    F --> G(Terraform provisions
    infrastructure on cloud
    provider for
    Kubernetes clusters)
    G --> H(Provisioning VMs,
    networking for
    Kubernetes Master
    and Worker Nodes)
    H --> I(Ansible configures
VMs, installs
necessary packages,
and configures
Kubernetes)
    I --> J{Kubernetes Master Node}
    J -->|Schedules workloads on Worker Nodes| L(Kubernetes Worker
Nodes running Spring
PetClinic in Docker
containers)
    J -->|Controls Kubernetes Worker Nodes| L
    L --> M(Nginx serves as reverse proxy to Kubernetes cluster)
    M --> N{Prometheus for monitoring and Grafana for data visualization}
    N --> O(Centralized logs stored using ELK Stack optional)
    N --> P(Grafana visualizes metrics)
    O --> Q(End)
    Q --> A(Start)
    ```
