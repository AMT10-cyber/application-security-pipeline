# End-to-End DevSecOps CI/CD Pipeline

This repository showcases a **complete, security-focused DevSecOps CI/CD pipeline** built using **GitHub Actions** and a simple Node.js application.

The purpose of this project is to demonstrate how **security can be embedded at every stage of the software delivery lifecycle** — from code commit to containerized deployment — using widely adopted, industry-standard tools.

> ⚠️ **Important Note**  
> The application itself is intentionally simple.  
> The primary focus of this repository is **DevSecOps architecture, pipeline design, and security integration**, not application complexity.

---

## Project Overview

This project implements an end-to-end DevSecOps workflow that includes:

- Continuous Integration (CI)
- Software Composition Analysis (SCA)
- Infrastructure as Code (IaC) scanning
- Container vulnerability scanning
- Static Application Security Testing (SAST)
- Dynamic Application Security Testing (DAST)
- Secure container publishing
- Optional Kubernetes-based runtime

The pipeline is designed to be **security-first**, **non-blocking**, and **production-realistic**, closely mirroring how modern DevSecOps pipelines operate in real enterprise environments.

---

## Application Used

This DevSecOps pipeline is demonstrated using a simple Node.js sample application provided by Heroku.

- **Application repository:** https://github.com/heroku/node-js-getting-started

The application was intentionally kept minimal to ensure the focus remains on CI/CD design, security tooling, and deployment strategy rather than application logic.

---

## Architecture & Pipeline Flow

At a high level, this project follows a security-first DevSecOps architecture where a **trusted container artifact** is produced through multiple automated security gates before being made available for deployment.

### High-Level Flow

```

Developer Commit
↓
GitHub Actions CI
↓
Security Scans (Parallel)

* Dependency Scanning (SCA)
* IaC Misconfiguration Scanning
* Container Vulnerability Scanning
* Static Code Analysis (SAST)
* Dynamic Application Security Testing (DAST)
  ↓
  Trusted Container Image
  ↓
  Docker Hub (Artifact Registry)
  ↓
  Runtime (Docker / Kubernetes)

````

The CI/CD pipeline is intentionally designed to separate:

- **Build & validation**
- **Security verification**
- **Artifact publishing**
- **Runtime execution**

This separation ensures that only **verified and scanned artifacts** are promoted for deployment.

---

## CI/CD Pipeline Stages

The CI/CD pipeline is implemented using **GitHub Actions** and is structured as a series of independent jobs that run after a successful build stage.

Each job focuses on a specific security or quality concern, enabling clear separation of responsibilities and easier auditing.

---

### 1. Continuous Integration (CI)

- Checks out the source code
- Installs Node.js dependencies
- Runs basic tests

This stage ensures the application builds correctly before any security analysis is performed.

---

### 2. Software Composition Analysis (SCA)

**Tool:** OWASP Dependency-Check

- Scans third-party dependencies for known vulnerabilities
- Uses the National Vulnerability Database (NVD)
- Generates an HTML vulnerability report

This stage helps identify risks introduced through external libraries.

---

### 3. Infrastructure as Code (IaC) Scanning

**Tool:** Checkov

- Scans Docker and Kubernetes configuration files
- Detects insecure defaults and misconfigurations
- Produces a machine-readable JSON report

This ensures infrastructure definitions follow security best practices.

---

### 4. Container Vulnerability Scanning

**Tool:** Trivy

- Builds the application Docker image
- Scans the image for OS-level and dependency vulnerabilities
- Outputs results in JSON format

Only scanned container images are considered valid deployment artifacts.

---

### 5. Static Application Security Testing (SAST)

**Tool:** GitHub CodeQL

- Performs semantic, data-flow-aware code analysis
- Detects common security vulnerabilities in JavaScript
- Publishes findings to GitHub Security alerts

This stage identifies security issues directly within the application source code.

---

### 6. Dynamic Application Security Testing (DAST)

**Tool:** OWASP ZAP

- Runs the application in a controlled CI environment
- Performs a baseline security scan against the running app
- Generates HTML, Markdown, and JSON reports

This validates the application’s security posture at runtime.

---

## Deployment Strategy

The deployment approach follows a **secure artifact promotion model**.

Instead of deploying source code directly, the pipeline produces a **trusted, scanned container image** that can be deployed consistently across environments.

---

### Docker-Based Deployment

After successfully passing all CI and security stages, the application is packaged as a Docker image and published to **Docker Hub**.

This image represents a **verified deployment artifact**.

#### Example

```bash
docker pull amt1002/devsecops-node-app:latest
docker run -p 3000:5006 amt1002/devsecops-node-app:latest
````

The application will be accessible at:

```
http://localhost:3000
```

---

### Kubernetes (Optional Runtime)

The same trusted container image can be deployed to Kubernetes using basic Deployment and Service manifests.

Example:

```bash
kubectl apply -f k8s/
```

Once deployed, the application can be accessed using the configured service port.

---

### Why Deployment Is Decoupled from CI

Deployment is intentionally **decoupled from the CI/CD pipeline** to:

* Avoid coupling security scans to a specific runtime environment
* Promote reuse of verified artifacts
* Reflect real-world enterprise DevSecOps practices

This ensures that only **scanned and approved artifacts** are promoted to runtime environments.

---

## Design Decisions & Future Improvements

This project intentionally prioritizes **clarity, security integration, and realistic pipeline design** over production-scale complexity.

### Key Design Decisions

* **Simple application, complex pipeline**
  The application is intentionally minimal to keep the focus on DevSecOps concepts rather than business logic.

* **Non-blocking security stages**
  Security scans generate reports and visibility without immediately failing the pipeline, mirroring how teams gradually introduce security gates.

* **Artifact-centric deployment**
  Deployment is based on promoting a scanned container image rather than redeploying source code, ensuring consistency across environments.

* **Kubernetes kept optional**
  Kubernetes is demonstrated as a runtime consumer of trusted artifacts, not tightly coupled to CI/CD execution.

---

### Potential Improvements

If this project were extended further, possible enhancements include:

* Enforcing security thresholds based on vulnerability severity
* Introducing image signing and verification (e.g., Cosign)
* Adding policy-as-code enforcement for IaC and containers
* Integrating centralized logging and monitoring
* Expanding Kubernetes manifests with security contexts and resource limits

```
