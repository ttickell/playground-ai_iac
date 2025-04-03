# Azure VM Infrastructure with Terraform Modules

This repository contains Terraform code for deploying a virtual machine (VM) and its associated infrastructure in Microsoft Azure. The code is structured into modules for improved organization, reusability, and maintainability.

## Project Structure

The project is organized into the following directory structure:

. 
├── main.tf # Root module 
├── modules 
│ ├── network_interface 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── network_security_group 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── public_ip 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── subnet 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── virtual_machine 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ └── virtual_network 
│ ├── main.tf 
│ ├── outputs.tf 
│ └── variables.tf 
└── variables.tf # root variables

*   **`main.tf`:** The root Terraform configuration file. It orchestrates the deployment by calling the various modules.
*   **`modules/`:** This directory contains the Terraform modules.
    *   **`network_interface/`:** Manages the creation and configuration of a network interface.
    *   **`network_security_group/`:** Manages the creation and configuration of a network security group.
    *   **`public_ip/`:** Manages the creation and configuration of a public IP address.
    *   **`subnet/`:** Manages the creation and configuration of a subnet.
    *   **`virtual_machine/`:** Manages the creation and configuration of a virtual machine.
    *   **`virtual_network/`:** Manages the creation and configuration of a virtual network.
*   **`variables.tf`:** This file in the root directory defines all of the variables that are used by the root module and the submodules.

## Iterative Development Process

This Terraform project was developed using an iterative approach, focusing on building functionality incrementally and improving the code structure over time. The process can be summarized as follows:

1.  **Initial Setup (Not Included in Repo):**
    *   The process began with a basic Terraform configuration to create the core resources: a virtual machine, a network interface, a subnet, a virtual network, a network security group, and a public IP.
    *   This initial code was contained in a single file, and was not modularized.

2.  **Addressing Errors:**
    *   The initial code was run, and errors were addressed as they were encountered.
    *   These errors included:
        *   Deprecated resources.
        *   Incorrect resource configuration.
        *   Missing resources.
        *   Incorrect resource relationships.
    * The code was modified to address these errors.

3.  **Adding Idempotency:**
    *   The code was modified to ensure that it was idempotent.
    *   This was done by adding data sources to look up existing resources, and only creating resources if they did not exist.
    * The `coalesce` function and `depends_on` attribute were used to accomplish this.

4.  **Adding SSH Access:**
    *   A network security group rule was added to allow SSH access to the virtual machine.
    *   The code was modified to use SSH keys instead of passwords for authentication.

5.  **Modularization:**
    *   The code was refactored into modules to improve organization, reusability, and maintainability.
    *   Each resource type was moved into its own module.
    *   The root module was created to orchestrate the deployment.
    *   Variables were added to make the modules configurable.
    *   Outputs were added to expose important information.

6. **Variable Creation:**
    * Variables were created to allow the code to be configured.
    * Variables were added to the root module, and to each of the submodules.

7. **Output Creation:**
    * Outputs were created to expose important information about the created resources.
    * Outputs were added to the root module, and to each of the submodules.

8. **Refinement:**
    *   The code was reviewed and refined to improve its structure, readability, and efficiency.
    *   Comments were added to explain the code.

## Key Concepts Demonstrated

*   **Modularization:** Breaking down complex infrastructure into smaller, reusable modules.
*   **Idempotency:** Ensuring that the code can be run multiple times without unintended side effects.
*   **Error Handling:** Addressing errors as they are encountered.
*   **Variable Usage:** Using variables to make the code configurable.
* **Output Usage:** Using outputs to expose important information.
*   **Iterative Development:** Building functionality incrementally and improving the code structure over time.
* **Data Sources:** Using data sources to look up existing resources.
* **`coalesce` Function:** Using the `coalesce` function to handle optional resource creation.
* **`depends_on` Attribute:** Using the `depends_on` attribute to ensure that resources are created in the correct order.

## Getting Started

1.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
3.  **Plan the Deployment:**
    ```bash
    terraform plan
    ```
4.  **Apply the Deployment:**
    ```bash
    terraform apply
    ```

## Contributing

Contributions to this project are welcome! Please feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License

[Insert License Information Here]
