# DevOps Automation for Java Spring Pet Clinic

This project automates the deployment, monitoring, and security analysis of the Java Spring Pet Clinic application using various DevOps tools and services. The infrastructure consists of 6 Virtual Machines (VMs) configured as follows:

- **Jenkins VM**: For CI/CD pipeline automation.
- **Kubernetes Cluster (3 VMs)**: For application deployment, consisting of 1 master node and 2 worker nodes (load-balanced).
- **Monitoring VM**: Integrated with Grafana and Prometheus for system and application monitoring.
- **Security VM**: Using Trivy for vulnerability scanning and SonarQube for code quality analysis.

## Project Architecture

The project is structured around these main components:

### 1. **Jenkins (CI/CD Pipeline)**
   - Jenkins is installed on a dedicated VM.
   - The pipeline is designed to automate:
     - **Code checkout** from the repository.
     - **Build** process using Maven.
     - **Unit and integration testing**.
     - **Containerization** of the Spring Pet Clinic app using Docker.
     - **Deployment** to the Kubernetes cluster.
   - Integration with SonarQube for static code analysis.
   - Triggers automated security scans using Trivy.

### 2. **Kubernetes Cluster**
   - The Kubernetes cluster consists of 3 VMs: 
     - **1 Master node**: Responsible for managing the cluster.
     - **2 Worker nodes**: Handle the application deployment in a load-balanced setup.
   - The Spring Pet Clinic application is deployed using Kubernetes manifests (YAML files) for:
     - **Deployments**
     - **Services** for networking
     - **Ingress** for routing external traffic
   - **Docker** is used to containerize the application, and the images are stored in a Docker registry.
   - Horizontal Pod Autoscaler (HPA) is used to scale the application based on demand.

### 3. **Monitoring (Grafana and Prometheus)**
   - Prometheus is configured to scrape metrics from the Kubernetes cluster.
   - Grafana is set up to visualize these metrics for real-time monitoring of the application, including:
     - CPU and memory usage.
     - Response times and errors.
     - Application performance metrics.
   - Alerts are set up in Grafana for critical performance thresholds.

### 4. **Security Analysis (Trivy and SonarQube)**
   - **Trivy**: A VM is dedicated to scanning Docker images for vulnerabilities before they are deployed to the Kubernetes cluster.
   - **SonarQube**: Installed on a separate VM to perform static code analysis for identifying code quality issues such as:
     - Bugs
     - Code smells
     - Security vulnerabilities
   - SonarQube integrates with Jenkins to provide feedback in the CI/CD pipeline.

## VM Setup

The project uses the following 6 VMs:

| **VM Name**         | **Role**                            | **Tools/Services Installed**                            |
|---------------------|-------------------------------------|--------------------------------------------------------|
| **Jenkins VM**       | CI/CD Automation                   | Jenkins, Docker, Maven, SonarQube Plugin, Trivy         |
| **K8s Master VM**    | Kubernetes Master Node             | Kubernetes (Master), Kubectl, Kubeadm                   |
| **K8s Worker 1 VM**  | Kubernetes Worker Node             | Kubernetes (Worker), Docker, Prometheus Node Exporter   |
| **K8s Worker 2 VM**  | Kubernetes Worker Node             | Kubernetes (Worker), Docker, Prometheus Node Exporter   |
| **Monitoring VM**    | Monitoring & Alerting              | Grafana, Prometheus                                    |
| **Security VM**      | Code Quality & Security Analysis   | SonarQube, Trivy                                        |

## Key Features

- **Automated CI/CD pipeline**: Jenkins automates code building, testing, security scanning, and deployment to Kubernetes.
- **Load Balancing and Scalability**: Kubernetes automatically manages application scaling across two worker nodes.
- **Monitoring**: Grafana and Prometheus provide real-time performance monitoring and alerting.
- **Security**: Trivy scans Docker images for vulnerabilities, and SonarQube analyzes the code for quality issues.
  
## How to Run the Project

1. **Clone the Project**:
   ```bash
   git clone <repository-url>
   ```

2. **Jenkins Setup**:
   - Install Jenkins on the Jenkins VM.
   - Configure the Jenkins pipeline to point to the project's repository.
   - Install required plugins: Docker, SonarQube Scanner, Kubernetes, etc.
   
3. **Kubernetes Cluster Setup**:
   - Initialize the Kubernetes cluster on the master node:
     ```bash
     sudo kubeadm init
     ```
   - Join worker nodes to the cluster:
     ```bash
     sudo kubeadm join <master-ip>:<token>
     ```
   - Apply the Kubernetes deployment manifests for the Spring Pet Clinic app:
     ```bash
     kubectl apply -f deployment.yaml
     ```

4. **Monitoring Setup**:
   - Install Prometheus and Grafana on the Monitoring VM.
   - Configure Prometheus to scrape metrics from the Kubernetes nodes.
   - Set up Grafana dashboards and configure alerts for critical thresholds.

5. **Security Setup**:
   - Run Trivy scans on the Security VM to analyze Docker images.
   - Integrate SonarQube with Jenkins to automatically perform code quality checks.





## Explaination video :
[Link](https://drive.google.com/file/d/1EmyZ3OBthkOdHP596KljW3tiwdnritWk/view?usp=drive_link)

## Conclusion

This DevOps project streamlines the deployment and monitoring of the Java Spring Pet Clinic application using Kubernetes, Jenkins, Prometheus, Grafana, Trivy, and SonarQube. The use of a CI/CD pipeline, combined with automated security analysis and monitoring, ensures high availability, security, and performance of the application.
