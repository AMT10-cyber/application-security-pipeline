# Application Security Pipeline (DevSecOps)

## Overview

This project implements an end-to-end **Application Security and Secure Software Development Lifecycle (SSDLC)** pipeline for a Node.js web application. The primary goal is to demonstrate how security controls can be integrated directly into the CI/CD process using DevSecOps principles, ensuring continuous vulnerability detection and risk assessment throughout the software delivery lifecycle.

The application itself is intentionally simple. The focus of the project is on **security automation, pipeline design, and tooling integration**, reflecting real-world application security and cloud security practices.

---

## Key Objectives

- Integrate automated security testing across the CI/CD pipeline
- Apply shift-left security principles
- Detect vulnerabilities in source code, dependencies, infrastructure, containers, and running applications
- Produce auditable security reports as pipeline artifacts
- Demonstrate enterprise-style DevSecOps and AppSec workflows

---

## Security Controls Implemented

### 1. Continuous Integration (CI)
- Source code checkout
- Node.js environment setup
- Dependency installation
- Automated test execution

### 2. Software Composition Analysis (SCA)
- Tool: **OWASP Dependency-Check**
- Purpose: Identify known vulnerabilities in third-party and open-source dependencies
- Output: HTML vulnerability reports archived as build artifacts

### 3. Static Application Security Testing (SAST)
- Tool: **GitHub CodeQL**
- Purpose: Detect insecure coding patterns and potential application-level vulnerabilities
- Results available in GitHub Security dashboard

### 4. Infrastructure as Code (IaC) Security Scanning
- Tool: **Checkov**
- Purpose: Detect misconfigurations in Dockerfiles and Kubernetes manifests
- Output: JSON scan reports archived as pipeline artifacts

### 5. Container Security Scanning
- Tool: **Trivy**
- Purpose: Identify OS-level and application-level vulnerabilities in Docker images
- Output: JSON vulnerability reports archived as build artifacts

### 6. Dynamic Application Security Testing (DAST)
- Tool: **OWASP ZAP**
- Purpose: Scan the running application for common web vulnerabilities such as injection flaws, insecure headers, and misconfigured endpoints

---

## CI/CD Pipeline Architecture

- Platform: **GitHub Actions**
- Pipeline Structure:
  - Build job (base job)
  - Parallel security scanning jobs:
    - SCA
    - SAST
    - IaC scanning
    - Container scanning
    - DAST
- Security reports are generated automatically and stored as artifacts for traceability and compliance.

---

## Technologies Used

- Node.js
- GitHub Actions
- Docker
- OWASP Dependency-Check
- GitHub CodeQL
- Checkov
- Trivy
- OWASP ZAP

---

## Project Domain

**Cybersecurity – Application Security / DevSecOps**

---

## Purpose and Learning Outcomes

This project demonstrates how modern application security is implemented as a continuous, automated process rather than a manual or post-deployment activity. It highlights the importance of integrating security into CI/CD pipelines to reduce risk, improve visibility, and enforce consistent security standards across the software development lifecycle.

---

## Disclaimer

This project is intended for educational and demonstration purposes. The application code is deliberately minimal to emphasize security tooling, automation, and pipeline design rather than application complexity.
