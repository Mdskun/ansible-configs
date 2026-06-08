<div align="center">

# ⚙️ Ansible DevOps Automation Suite

### *Infrastructure provisioning at the speed of a single command.*

<p align="center">
  Battle-tested Ansible playbooks for automating the full DevOps toolchain —<br/>
  from bare metal to a production-grade Kubernetes + monitoring stack, all on RHEL/CentOS.
</p>

<br/>

![Ansible](https://img.shields.io/badge/Ansible-2.12%2B-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![RHEL](https://img.shields.io/badge/RHEL%2FCentOS-9%2B-CC0000?style=for-the-badge&logo=redhat&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.29-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-Latest-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen?style=for-the-badge)

<br/>

> 🚀 **Zero to full DevOps stack in minutes — not hours.**

</div>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Playbook Coverage](#-playbook-coverage)
- [Tech Stack](#-tech-stack)
- [Requirements](#-requirements)
- [Project Structure](#-project-structure)
- [Configuration](#-configuration)
- [Installation & Setup](#-installation--setup)
- [How It Works](#-how-it-works)
- [Working & User Flow](#-working--user-flow)
- [Documentation](#-documentation)
- [Contributing](#-contributing)
- [License](#-license)
- [Author & Credits](#-author--credits)

---

## 🔍 Overview

### What is this?

**Ansible DevOps Automation Suite** is a curated collection of production-ready Ansible playbooks that automate the provisioning and configuration of a complete DevOps infrastructure stack on RHEL/CentOS-based systems.

### The Problem

Setting up a real DevOps pipeline — Jenkins CI/CD, Docker, Kubernetes cluster, Prometheus monitoring, Grafana dashboards, Terraform IaC — requires hours of manual installation, misconfigured services, and undocumented steps that break across environments.

### The Solution

One inventory file. One `ansible-playbook` command. A fully provisioned, production-oriented DevOps environment — idempotent, repeatable, and version-controlled.

### Who Is It For?

| Audience | Use Case |
|---|---|
| 🧑‍💻 DevOps Engineers | Rapid environment provisioning on AWS EC2 or local VMs |
| 🎓 Students & Learners | Hands-on learning of the full DevOps toolchain |
| 🏗️ Platform Teams | Baseline automation for internal infrastructure |
| 🧪 Lab & Training Environments | Reproducible setups for workshops and demos |

---

## ✨ Features

- 🐳 **Docker CE (Clean Install)** — Removes Podman conflicts, installs Docker CE with BuildX & Compose plugins, adds user to docker group automatically
- 🤖 **Jenkins Automation** — Full Jenkins install with Java 21, firewall rule for port 8080, service enablement, and initial admin password retrieval
- ☸️ **Kubernetes Cluster Bootstrapping** — Master node init with `kubeadm`, Calico CNI networking, join command auto-saved for workers
- 🛤️ **Minikube for Local Dev** — Single-node cluster setup using Docker driver with kubectl, swap management included
- 📊 **Prometheus + Grafana Stack** — Binary install (no container), systemd service, port 9090 via firewalld, dedicated prometheus user
- 📈 **Node Exporter** — System metrics exporter as a managed systemd service
- 🌍 **Terraform IaC** — HashiCorp official repo install on RHEL with Git dependency chain
- ☕ **Oracle JDK 26** — Direct RPM download and install with version verification
- 🔐 **Git with Encrypted Credentials** — Cross-distro Git install with global config via `ansible-vault`-compatible `credentials.yml`
- 🔁 **Idempotent by Design** — Every playbook is safe to re-run without side effects

---

## 🗂️ Playbook Coverage

| Category | Playbook | Target Hosts | Key Actions |
|---|---|---|---|
| 🐳 Containers | `docker/docker.yml` | `all` | Removes Podman, installs Docker CE, enables service |
| 🤖 CI/CD | `jenkins/jenkins.yml` | `all` | Installs Jenkins + Java 21, opens port 8080, prints admin password |
| ☸️ Kubernetes | `k8s/kubernates_m.yml` | `kslave` | Cluster init, Calico CNI, saves join command |
| ☸️ Kubernetes | `k8s/kubernates_w.yml` | `kworker` | Joins worker nodes to cluster |
| 🛤️ Local K8s | `k8s/minikube.yml` | `all` | Minikube + kubectl via Docker driver |
| 📊 Monitoring | `prometheus-graphana/prometheus.yml` | `all` | Binary install, systemd, firewall, user setup |
| 📈 Monitoring | `prometheus-graphana/node_exporter.yml` | `all` | Node Exporter as systemd service |
| 📉 Monitoring | `prometheus-graphana/graphana.yml` | `all` | Grafana setup |
| 🌍 IaC | `Terraform/Terraform.yml` | `all` | HashiCorp repo + Terraform install (imports Git) |
| ☕ Packages | `Packages/java.yml` | `j-slave` | Oracle JDK 26 RPM install with verification |
| 🔐 Version Control | `Git/git.yml` | `all` | Cross-distro Git + global config from vault credentials |

---

## 🛠️ Tech Stack

| Technology | Role in This Project |
|---|---|
| **Ansible 2.12+** | Orchestration engine — all automation logic |
| **RHEL / CentOS 9+** | Primary target OS for all playbooks |
---

## ✅ Requirements

### Control Node (your machine running Ansible)

| Requirement | Version |
|---|---|
| OS | Linux / macOS / WSL2 |
| Python | 3.8+ |
| Ansible | 2.12+ (`core`) |
| SSH Access | Key-based auth to all target hosts |

### Managed Nodes (target servers)

| Requirement | Details |
|---|---|
| OS | RHEL 9 / CentOS Stream 9 or later |
| User | `ec2-user` (AWS) or `root` (local VMs) |
| SSH | Port 22 open, key or password auth configured |
| Internet | Required for package downloads during provisioning |
| Privileges | `sudo`/`become: true` — root access required |

> 💡 Tested on **AWS EC2 (RHEL 9)** and **local KVM VMs(RHEL9)**.

---

## 📁 Project Structure

```
ansible-configs/
│
├── ansible.cfg                  # Global Ansible config (inventory path, SSH settings)
├── key                          # SSh key for authentication(Not commited but still needed)
├── hosts                        # Inventory: EC2 and local VM host groups
├── .gitignore
│
├── docker/
│   └── docker.yml               # Docker CE full install (removes Podman)
│
├── jenkins/
│   ├── jenkins.yml              # Jenkins + Java 21 + firewall + service
│   └── ip_script.sh             # Helper script for IP resolution
│
├── k8s/
│   ├── kubernates_m.yml         # Kubernetes master node setup (kubeadm init)
│   ├── kubernates_w.yml         # Kubernetes worker node join
│   └── minikube.yml             # Minikube single-node cluster (Docker driver)
│
├── Packages/
│   └── java.yml                 # Oracle JDK 26 RPM download & install
│
├── prometheus-graphana/
│   ├── prometheus.yml           # Prometheus binary install + systemd + firewall
│   ├── prometheus.service       # Systemd unit file for Prometheus
│   ├── node_exporter.yml        # Node Exporter install + service
│   ├── node_exporter.service    # Systemd unit file for Node Exporter
│   └── graphana.yml             # Grafana setup playbook
│
├── Terraform/
│   └── Terraform.yml            # HashiCorp repo + Terraform install (imports Git)
│
├── Git/
│   ├── git.yml                  # Cross-distro Git install + global config
│   └── credentials.yml          # Git credentials(Have to make it it's not commited)
│
└── aws/                         # AWS-specific configs (incomplate)
```

---

## ⚙️ Configuration

### Inventory (`hosts`)

Edit the `hosts` file to match your environment:

```ini
# for ec2 basesystem:
<INSTANCE_IP> ansible_user=ec2-user ansible_ssh_private_key_file=<EC2 PRIVATE KEY>

# for normal users:
<IP> ansible_user=<USER> ansible_ssh_pass=<USER_PASSWOD>
```

`hosts` file used here is:
```ini
[kslave]           # Kubernetes Master
172.31.1.159 ansible_user=ec2-user ansible_ssh_private_key_file=key

[kworker]          # Kubernetes Worker(s)
172.31.1.126 ansible_user=ec2-user ansible_ssh_private_key_file=key

[jslave]           # Jenkins Agent
172.31.1.195 ansible_user=ec2-user ansible_ssh_private_key_file=key

[local]            # Local VMs (password auth)
192.168.122.53 ansible_user=root ansible_ssh_pass=admin
```

### Ansible Config (`ansible.cfg`)

```ini
[defaults]
inventory=./hosts
host_key_checking = False
```

### Git Credentials (`Git/credentials.yml`)

This file should be encrypted with Ansible Vault:

```yaml
git_username: "Your Name"
git_email: "you@example.com"
```

Encrypt it:
```bash
ansible-vault encrypt Git/credentials.yml
```

### Playbook Variables

| Playbook | Variable | Default | Description |
|---|---|---|---|
| `docker.yml` | `docker_user` | `ec2-user` | User added to docker group |
| `prometheus.yml` | `link` | Prometheus v3.11.3 | Download URL |
| `prometheus.yml` | `install_dir` | `/tmp/prometheus` | Temp extraction path |
| `java.yml` | `java_rpm_url` | Oracle JDK 26 | JDK download URL |

---

## 🚀 Installation & Setup

<p align="center">

[![Download ZIP](https://img.shields.io/badge/⬇️%20Download-Source%20ZIP-blue?style=for-the-badge)](https://github.com/mdskun/ansible-configs/archive/refs/heads/main.zip)
&nbsp;
[![Clone Repo](https://img.shields.io/badge/📋%20Clone-Repository-gray?style=for-the-badge)](https://github.com/mdskun/ansible-configs)

</p>

### Step 1 — Clone the Repository

```bash
git clone https://github.com/yourusername/ansible-configs.git
cd ansible-configs
```

### Step 2 — Install Ansible

```bash
# RHEL/CentOS
sudo dnf install ansible -y

# Ubuntu/Debian
sudo apt install ansible -y

# pip (recommended for latest)
pip install ansible
```

### Step 3 — Configure Your Inventory

```bash
# Edit hosts file with your server IPs
nano hosts
```

### Step 4 — Add Your SSH Key

```bash
# Place your private key in the project directory
cp ~/.ssh/your-key.pem ./key
chmod 400 ./key
```

### Step 5 — Run a Playbook

```bash
# Install Docker on all hosts
ansible-playbook docker/docker.yml

# Set up Jenkins
ansible-playbook jenkins/jenkins.yml

# Bootstrap Kubernetes master
ansible-playbook k8s/kubernates_m.yml

# Set up full monitoring stack
ansible-playbook prometheus-graphana/prometheus.yml
ansible-playbook prometheus-graphana/node_exporter.yml
ansible-playbook prometheus-graphana/graphana.yml

# Install Terraform (automatically chains Git install)
ansible-playbook Terraform/Terraform.yml

# Limit to specific host group
ansible-playbook docker/docker.yml --limit jslave
```

> 🔒 **Vault-encrypted playbooks** (Git):
> ```bash
> ansible-playbook Git/git.yml --ask-vault-pass
> ```

---

## 🔄 How It Works

### User Flow

```
1. Edit hosts inventory  →  Add your target server IPs + auth method
2. Pick a playbook       →  Choose from docker, jenkins, k8s, monitoring, etc.
3. Run the command       →  ansible-playbook <playbook>.yml
4. Ansible connects      →  SSH into each host in the inventory
5. Tasks execute         →  Idempotent task-by-task provisioning
6. Result               →  Service installed, configured, and running ✅
```

### Internal Working

```
ansible-playbook
    │
    ├── Reads ansible.cfg         → Loads inventory path, SSH settings
    ├── Parses hosts file         → Resolves target host groups
    ├── Connects via SSH          → Uses key or password auth
    │
    ├── Executes Tasks (in order):
    │     ├── Package removal (cleanup conflicts)
    │     ├── Repo addition (yum/dnf/apt)
    │     ├── Package installation
    │     ├── Service enablement (systemd)
    │     ├── Firewall rule application (firewalld)
    │     └── Verification & output
    │
    └── Returns task-level status (ok / changed / failed / skipped)
```

### Kubernetes Setup Flow

```
1. [kslave]  → kubernates_m.yml → kubeadm init → Calico CNI → saves join-command.sh
2. [kworker] → kubernates_w.yml → reads join-command.sh → kubeadm join
3. [any]     → minikube.yml     → minikube start --driver=docker (local dev)
```

---

## 📖 Documentation

### Architecture Pattern

This project follows the **Playbook-per-Role** pattern — each technology concern (Docker, Jenkins, K8s, Monitoring) is isolated into its own playbook directory with clear host targeting. Shared concerns (Git, Java packages) are extracted as importable playbooks using `import_playbook`.

```
Pattern: Flat Playbook Composition (Ansible best practice for small-to-mid infra)
         ↕
         Dependency chain via import_playbook (Terraform → Git)
         ↕
         Role variables per-play (vars block) for easy customization
```

### Design Decisions

| Decision | Reason |
|---|---|
| Binary install for Prometheus | No Docker dependency; cleaner systemd integration |
| `become: true` globally | All infra tasks require root; explicit per-play |
| `ignore_errors: true` on cleanup | Idempotency — missing packages shouldn't fail runs |
| `ansible.cfg` with `host_key_checking = False` | Supports dynamic EC2 IPs in lab/training environments |
| Calico CNI for Kubernetes | Supports `192.168.0.0/16` pod CIDR; production-grade |

### Changelog

| Version | Changes |
|---|---|
| `v1.0` | Initial playbooks: Docker, Jenkins, K8s master/worker |
| `v1.1` | Added Prometheus, Grafana, Node Exporter |
| `v1.2` | Added Terraform (with Git dependency chain) |
| `v1.3` | Added Minikube, Oracle JDK 26, credentials vault |
| `v1.4` | Cleaned Docker install for RHEL 9/10 (Podman conflict fix) |

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how to get involved:

```bash
# 1. Fork this repository
# 2. Create your feature branch
git checkout -b feature/add-nginx-playbook

# 3. Commit your changes
git commit -m "feat: add Nginx reverse proxy playbook"

# 4. Push to your branch
git push origin feature/add-nginx-playbook

# 5. Open a Pull Request
```

### Contribution Ideas

- 🐳 Add an `nginx.yml` or `haproxy.yml` playbook
- ☁️ Add AWS-specific playbooks in the `aws/` directory
- 🔐 Add `ansible-vault` usage documentation
- 🧪 Add Molecule tests for playbook validation
- 📦 Refactor into proper Ansible Roles structure

> Please ensure all playbooks are **idempotent**, **tested on RHEL 9**, and follow the existing naming convention.

---

## 📄 License

This project is licensed under the **MIT License** — you're free to use, modify, and distribute it.

See [`LICENSE`](LICENSE) for full details.

---

## 👨‍💻 Author & Credits

<p align="center">

**Built with precision by a DevOps practitioner who believes infrastructure should be code — not tribal knowledge.**

</p>

| Field | Details |
|---|---|
| 👤 Author | Manthan D Soni |
| 🐙 GitHub | [@mdskun](https://github.com/mdskun) |
| 📧 Contact | manthandsoni@gmail.com |

---

<div align="center">

### ⭐ If this saved you hours of setup time, drop a star — it helps others find it too.

*"Automate the boring stuff. Ship the important stuff."*

<br/>

![Ansible](https://img.shields.io/badge/Made%20with-Ansible-EE0000?style=flat-square&logo=ansible)
![DevOps](https://img.shields.io/badge/For-DevOps%20Engineers-326CE5?style=flat-square&logo=kubernetes)
![RHEL](https://img.shields.io/badge/Tested%20on-RHEL%209-CC0000?style=flat-square&logo=redhat)

</div>
