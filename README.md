<h1>🌐 Two-Tier Architecture Using Terraform</h1>
<p>This project demonstrates the deployment of a two-tier architecture on AWS using Terraform.
  The architecture separates the web and application layers, ensuring scalability, security, and modular design.
  Terraform is used for defining and provisioning the infrastructure as code. 🚀.</p>

  <h2>🌟 Architecture Overview </h2>
The architecture consists of the following components:
<h3>🛠️ Network Layer:</h3>
<li>🌍 A Virtual Private Cloud (VPC) with subnets spread across multiple Availability Zones for high availability.</li>
<il>🛡️ Public and private subnets to separate web and application layers.</li>
<li>🌐 Internet Gateway for public access and NAT Gateway for outbound traffic from private subnets.</li>

<h3>🖥️ Web Layer:</h3>
<li>⚡ EC2 instances in the public subnet to handle web requests.</li>
<li>🔒 Security group to allow HTTP/HTTPS traffic to the web servers.</li>

<h3>⚙️ Application Layer:</h3>
<li>📦 EC2 instances in private subnets for backend processing.</li>
<li>🔒 Security group to restrict access to traffic only from the web layer.</li>

<h3>🔐 Security:</h3>
<li>🛡️ IAM roles and policies for secure access to AWS resources.</li>
<li>🔒 Security groups and network ACLs for controlled traffic flow.</li>

<h2>📂 Project Files</h2>
<li>Network Configuration: Defines VPC, subnets, route tables, and gateways.</li>
<li>Compute Resources: Provisions EC2 instances for web and application layers.</li>
<li>Security Resources: Manages security groups and IAM roles.</li>
<li>Provider Configuration: Sets up Terraform with the AWS provider.</li>

<h2>✨ Future Enhancements</h2>
<li>🗄️ Integration of a database layer for persistence.</li>
<li>🌐 Load balancing for improved scalability and fault tolerance.</li>
<li>📈 Autoscaling to dynamically manage traffic spikes.</li>

<h3>📜 License</h3>
This project is licensed under the MIT License. 📄
<br>
Feel free to suggest improvements or fork the repository to extend the functionality! 💡

Maintained by: Kumar22Ankit 🙌
