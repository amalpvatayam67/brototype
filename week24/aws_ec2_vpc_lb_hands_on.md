
# AWS Hands-On Lab: EC2, VPC, Security Groups & Load Balancer

## Objective
This lab provides practical, step-by-step guidance to:
- Launch and configure an EC2 instance
- Host a basic website on EC2
- Create and configure a custom VPC
- Secure resources using Security Groups
- Implement Load Balancers for high availability

---

## A. Launch and Configure an EC2 Instance (AWS Management Console)

### Steps:
1. Log in to the **AWS Management Console**
2. Navigate to **EC2 → Instances → Launch Instance**
3. Choose an Amazon Machine Image (AMI):
   - Amazon Linux 2 (recommended)
4. Select Instance Type:
   - `t2.micro` (Free Tier eligible)
5. Choose or create a **Key Pair** (for SSH access)
6. Configure Network:
   - Select your VPC
   - Choose a public subnet
   - Enable Auto-assign Public IP
7. Configure Storage:
   - Default 8 GB gp2/gp3 volume
8. Configure Security Group:
   - Allow SSH (22) from your IP
   - Allow HTTP (80) from anywhere
9. Review and Launch

---

## B. Host a Basic Website on EC2

### Steps:
1. Connect to EC2 using SSH:
   ```bash
   ssh -i key.pem ec2-user@<public-ip>
   ```
2. Install Apache web server:
   ```bash
   sudo yum update -y
   sudo yum install httpd -y
   ```
3. Start and enable Apache:
   ```bash
   sudo systemctl start httpd
   sudo systemctl enable httpd
   ```
4. Deploy a simple website:
   ```bash
   echo "<h1>Welcome to AWS EC2</h1>" | sudo tee /var/www/html/index.html
   ```
5. Access the site via browser:
   ```
   http://<EC2-Public-IP>
   ```

---

## C. Create and Configure a Custom VPC

### Steps:
1. Go to **VPC → Create VPC**
2. Configure:
   - Name: `Custom-VPC`
   - IPv4 CIDR: `10.0.0.0/16`
3. Create Subnets:
   - Public Subnet: `10.0.1.0/24`
   - Private Subnet: `10.0.2.0/24`
4. Create Internet Gateway:
   - Attach it to `Custom-VPC`
5. Create Route Table:
   - Add route `0.0.0.0/0 → Internet Gateway`
   - Associate with Public Subnet

---

## D. Configure Security Groups (Least Privilege)

### Inbound Rules:
| Port | Protocol | Source |
|----|--------|--------|
| 22 | SSH | My IP |
| 80 | HTTP | 0.0.0.0/0 |
| 443 | HTTPS | 0.0.0.0/0 |

### Best Practices:
- Restrict SSH to specific IPs
- Avoid opening unnecessary ports
- Use separate Security Groups per role

---

## E. Implement Load Balancer for High Availability

### Steps:
1. Navigate to **EC2 → Load Balancers → Create Load Balancer**
2. Choose **Application Load Balancer (ALB)**
3. Configure:
   - Internet-facing
   - Select VPC and public subnets
4. Create Target Group:
   - Target type: Instances
   - Protocol: HTTP (80)
5. Register EC2 instances
6. Configure Health Checks:
   - Path: `/`
7. Attach Security Group:
   - Allow HTTP/HTTPS traffic
8. Access application via Load Balancer DNS name

---

## Architecture Flow

1. User → Load Balancer
2. Load Balancer → EC2 Instances
3. Security Groups control traffic
4. VPC provides isolated networking
5. Route Tables manage internet access

---

## Outcome
- A secure, scalable EC2-based web application
- High availability using Load Balancer
- Proper network isolation with VPC and subnets

---

## Notes
- This setup can be extended with Auto Scaling Groups, WAF, and HTTPS (ACM)
- Always follow AWS security best practices
