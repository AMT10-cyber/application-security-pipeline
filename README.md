# End-to-End DevSecOps CI/CD Pipeline

This repository demonstrates a **security-first, end-to-end DevSecOps CI/CD pipeline** implemented using **GitHub Actions** and a simple **Node.js** application.

The goal of this project is to show how **security can be embedded at every stage of the software delivery lifecycle** — from code commit to containerized deployment — using widely adopted, industry-standard tools.

> ⚠️ **Important Note**
> The application itself is intentionally minimal.
> The primary focus of this repository is **DevSecOps architecture, CI/CD pipeline design, and security integration**, not application complexity.

---

## Project Overview

This project implements a realistic DevSecOps workflow that includes:

* Continuous Integration (CI)
* Software Composition Analysis (SCA)
* Infrastructure as Code (IaC) scanning
* Container vulnerability scanning
* Static Application Security Testing (SAST)
* Dynamic Application Security Testing (DAST)
* Secure container publishing
* Optional Kubernetes-based runtime

The pipeline is designed to be:

* **Security-first**
* **Non-blocking**
* **Production-realistic**

It closely mirrors how modern enterprise DevSecOps pipelines operate.

---

## Application Used

The DevSecOps pipeline is demonstrated using a simple Node.js sample application provided by Heroku.

* **Source application repository:**
  [https://github.com/heroku/node-js-getting-started](https://github.com/heroku/node-js-getting-started)

The application is intentionally kept simple so the focus remains on CI/CD design, security tooling, and deployment strategy rather than application logic.

---

## Architecture & Pipeline Flow

At a high level, this project follows a **secure artifact–centric DevSecOps model**, where a trusted container image is produced only after passing multiple automated security checks.

### High-Level Flow

```
Developer Commit
   ↓
GitHub Actions CI
   ↓
Security Scans (Parallel)
   - Dependency Scanning (SCA)
   - IaC Misconfiguration Scanning
   - Container Vulnerability Scanning
   - Static Application Security Testing (SAST)
   - Dynamic Application Security Testing (DAST)
   ↓
Trusted Container Image
   ↓
Docker Hub (Artifact Registry)
   ↓
Runtime (Docker / Kubernetes)
```

The pipeline intentionally separates:

* **Build & validation**
* **Security verification**
* **Artifact publishing**
* **Runtime execution**

This ensures that only **scanned and verified artifacts** are promoted to deployment environments.

---

## CI/CD Pipeline Stages

The CI/CD pipeline is implemented using **GitHub Actions** and is structured as a set of independent jobs triggered after a successful build.

Each job addresses a specific security or quality concern, making the pipeline easier to audit, maintain, and extend.

---

### 1. Continuous Integration (CI)

* Checks out the source code
* Installs Node.js dependencies
* Runs basic application tests

This stage validates that the application builds successfully before any security analysis begins.

---

### 2. Software Composition Analysis (SCA)

**Tool:** OWASP Dependency-Check

* Scans third-party dependencies for known vulnerabilities
* Uses the National Vulnerability Database (NVD)
* Generates an HTML vulnerability report

This stage identifies risks introduced through external libraries.

---

### 3. Infrastructure as Code (IaC) Scanning

**Tool:** Checkov

* Scans Docker and Kubernetes configuration files
* Detects insecure defaults and misconfigurations
* Produces machine-readable JSON reports

This ensures infrastructure definitions follow security best practices.

---

### 4. Container Vulnerability Scanning

**Tool:** Trivy

* Builds the application Docker image
* Scans the image for OS-level and dependency vulnerabilities
* Outputs scan results in JSON format

Only scanned container images are treated as valid deployment artifacts.

---

### 5. Static Application Security Testing (SAST)

**Tool:** GitHub CodeQL

* Performs semantic, data-flow-aware code analysis
* Detects common security issues in JavaScript
* Publishes findings to GitHub Security alerts

This stage identifies vulnerabilities directly within the application source code.

---

### 6. Dynamic Application Security Testing (DAST)

**Tool:** OWASP ZAP

* Runs the application in a controlled CI environment
* Performs a baseline security scan against the running application
* Generates HTML, Markdown, and JSON reports

This validates the application’s security posture at runtime.

---

## Deployment Strategy

The deployment model follows a **secure artifact promotion approach**.

Instead of deploying source code directly, the pipeline produces a **trusted, scanned container image** that can be consistently deployed across environments.

---

### Docker-Based Deployment

After passing all CI and security stages, the application is packaged as a Docker image and published to **Docker Hub**.

This image represents a **verified deployment artifact**.

#### Example

```bash
docker pull amt1002/devsecops-node-app:latest
docker run -p 3000:5006 amt1002/devsecops-node-app:latest
```

The application will be available at:

```
http://localhost:3000
```

---

### Kubernetes (Optional Runtime)

The same trusted container image can be deployed to Kubernetes using standard Deployment and Service manifests.

```bash
kubectl apply -f k8s/
```

Once deployed, the application can be accessed via the configured service endpoint.

---

### Why Deployment Is Decoupled from CI

Deployment is intentionally **decoupled from the CI/CD pipeline** in order to:

* Avoid coupling security scans to a specific runtime environment
* Promote reuse of verified artifacts across environments
* Reflect real-world enterprise DevSecOps practices

This ensures that only **approved and scanned artifacts** are promoted to runtime.

---

## Design Decisions & Future Improvements

This project prioritizes **clarity, security integration, and realistic pipeline design** over production-scale complexity.

### Key Design Decisions

* **Simple application, complex pipeline**
  The application is intentionally minimal to keep the focus on DevSecOps concepts.

* **Non-blocking security stages**
  Security scans generate visibility and reports without immediately failing the pipeline, reflecting gradual security adoption.

* **Artifact-centric deployment**
  Deployments are based on promoting a trusted container image rather than redeploying source code.

* **Optional Kubernetes runtime**
  Kubernetes is treated as a consumer of trusted artifacts, not tightly coupled to CI execution.

---

### Potential Improvements

Future enhancements could include:

* Enforcing security gates based on vulnerability severity
* Image signing and verification (e.g., Cosign)
* Policy-as-code enforcement for IaC and containers
* Centralized logging and monitoring
* Hardened Kubernetes manifests (security contexts, resource limits)

---
