# 🌐 Inception

**Inception** is a project from 42 school that introduces Docker-based web infrastructure design. The goal is to create a fully operational multi-container setup using **Docker Compose** with a focus on reproducibility, scalability, and modularity.

---

## 🛠 Features

- **Dockerized Environment**:
  - A **WordPress** instance served by **Nginx**.
  - A **MariaDB** database for persistent data storage.
- **Secrets Management**:
  - Credentials and sensitive information are securely stored in `secrets`.
- **Custom Configurations**:
  - Fine-tuned configuration files for MariaDB, Nginx, and WordPress.
- **Modularity**:
  - Each service is isolated into its own Docker container for better management and scalability.

---

## 📂 Project Structure

```plaintext
.
├── Makefile                       # Build and manage containers
├── secrets                        # Sensitive data storage
│   ├── credentials.txt            # WordPress credentials
│   ├── db_password.txt            # MariaDB user password
│   └── db_root_password.txt       # MariaDB root password
└── srcs                           # Docker Compose and configurations
    ├── docker-compose.yml         # Main configuration for the stack
    └── requirements               # Individual service setups
        ├── bonus                  # Placeholder for bonus features
        ├── mariadb                # MariaDB database setup
        │   ├── Dockerfile         # Dockerfile for MariaDB
        │   ├── conf               # Configuration and scripts
        │   │   ├── 50-server.cnf  # MariaDB server configuration
        │   │   └── init-db.sh     # Initialization script
        │   └── tools              # Tools directory for additional scripts
        ├── nginx                  # Nginx reverse proxy setup
        │   ├── Dockerfile         # Dockerfile for Nginx
        │   ├── conf               # Configuration and scripts
        │   │   └── nginx.conf     # Nginx configuration file
        │   └── tools              # Tools directory for additional scripts
        └── wordpress              # WordPress setup
            ├── Dockerfile         # Dockerfile for WordPress
            ├── conf               # Configuration and scripts
            │   ├── wp-config.sh   # WordPress configuration script
            │   └── www.conf       # PHP-FPM configuration
            └── tools              # Tools directory for additional scripts
