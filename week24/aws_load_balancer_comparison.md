
# AWS Load Balancers Study: ALB vs ELB (Classic) vs NLB

## Objective
This document provides a detailed study of AWS load balancers by:
- Differentiating between Application Load Balancer (ALB), Classic Elastic Load Balancer (ELB), and Network Load Balancer (NLB)
- Explaining their architectures and working mechanisms
- Highlighting Layer 4 vs Layer 7 differences
- Documenting use cases, advantages, and limitations
- Presenting a clear comparison table

---

## A. Overview of AWS Load Balancers

AWS Elastic Load Balancing automatically distributes incoming traffic across multiple targets to ensure:
- High availability
- Fault tolerance
- Scalability

AWS provides three main types of load balancers:
1. Application Load Balancer (ALB)
2. Network Load Balancer (NLB)
3. Classic Load Balancer (ELB – legacy)

---

## B. Load Balancer Types Explained

## 1. Application Load Balancer (ALB)

**Architecture & Working:**
- Operates at **Layer 7 (Application Layer)**
- Uses HTTP/HTTPS request content to route traffic
- Integrates deeply with ECS, EKS, and microservices

**Key Features:**
- Path-based and host-based routing
- WebSocket and HTTP/2 support
- Native integration with AWS WAF

**Use Cases:**
- Microservices architectures
- Container-based applications
- REST APIs and web applications

**Advantages:**
- Advanced routing rules
- Better visibility into requests
- Ideal for modern applications

**Limitations:**
- Not suitable for non-HTTP traffic
- Slightly higher latency than NLB

---

## 2. Network Load Balancer (NLB)

**Architecture & Working:**
- Operates at **Layer 4 (Transport Layer)**
- Routes traffic based on TCP/UDP packets
- Uses static IP addresses

**Key Features:**
- Ultra-low latency
- Handles millions of requests per second
- Preserves client source IP

**Use Cases:**
- High-performance applications
- Real-time systems (VoIP, gaming)
- TCP/UDP-based workloads

**Advantages:**
- Extremely fast and scalable
- Supports non-HTTP protocols
- Ideal for performance-critical systems

**Limitations:**
- No application-level routing
- No WAF integration

---

## 3. Classic Load Balancer (ELB – Legacy)

**Architecture & Working:**
- Supports both **Layer 4 and limited Layer 7**
- Older generation load balancer
- Limited routing capabilities

**Key Features:**
- Basic load balancing
- Supports EC2 Classic (legacy)

**Use Cases:**
- Legacy applications
- Simple load balancing needs

**Advantages:**
- Simple to configure
- Supports older AWS architectures

**Limitations:**
- Limited features
- Not recommended for new applications

---

## C. Layer-Level Differences (Layer 4 vs Layer 7)

| Layer | Description | Load Balancer |
|------|------------|---------------|
| Layer 4 | Routes based on IP & port | NLB |
| Layer 7 | Routes based on HTTP headers, paths | ALB |

---

## D. Comparison Table

| Feature | ALB | NLB | Classic ELB |
|------|-----|-----|-------------|
| OSI Layer | Layer 7 | Layer 4 | Layer 4 & 7 |
| Protocols | HTTP, HTTPS | TCP, UDP | HTTP, HTTPS, TCP |
| Routing | Path & Host-based | Port-based | Limited |
| Performance | High | Very High | Moderate |
| Static IP | No | Yes | No |
| Source IP Preservation | No | Yes | No |
| WAF Support | Yes | No | No |
| Container Support | Excellent | Limited | Poor |
| Recommended for New Apps | Yes | Yes | No |
| Cost Efficiency | Moderate | High | Low (legacy) |

---

## E. Summary & Recommendations

- **Use ALB** for web applications, APIs, and microservices requiring smart routing.
- **Use NLB** for performance-critical, low-latency TCP/UDP workloads.
- **Avoid Classic ELB** for new designs; migrate to ALB or NLB.

---

## Conclusion
Understanding the differences between AWS load balancers is critical for designing scalable, secure, and high-performance cloud architectures. Choosing the right load balancer depends on protocol needs, performance requirements, and application design.
