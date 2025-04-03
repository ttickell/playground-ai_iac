# Azure VM Infrastructure Deployment with Ansible

This repository contains Ansible code for deploying a virtual machine (VM) and its associated infrastructure in Microsoft Azure. This Ansible project is the result of converting a Terraform project into an equivalent Ansible implementation.

## Project Structure

The project is organized into the following directory structure:

. ├── ansible.cfg # Ansible configuration file 
  ├── inventory # Inventory file (hosts) 
  ├── playbooks 
  │ └── main.yml # Main playbook 
  └── roles 
  ├── network_interface 
  │ 
  └── tasks 
  │ 
  └── main.yml 
  ├── network_security_group │ └── tasks │ └── main.yml ├── public_ip │ └── tasks │ └── main.yml ├── subnet │ └── tasks │ └── main.yml ├── virtual_machine │ └── tasks │ └── main.yml └── virtual_network └── tasks └── main.yml └── group_vars └── all.yml # group variables


*   **`ansible.cfg`:** The Ansible configuration file.
*   **`inventory`:** The Ansible inventory file, defining the target hosts.
*   **`playbooks/main.yml`:** The main Ansible playbook, which orchestrates the deployment.
*   **`roles/`:** This directory contains the Ansible roles.
    *   **`network_interface/`:** Manages the creation and configuration of a network interface.
    *   **`network_security_group/`:** Manages the creation and configuration of a network security group.
    *   **`public_ip/`:** Manages the creation and configuration of a public IP address.
    *   **`subnet/`:** Manages the creation and configuration of a subnet.
    *   **`virtual_machine/`:** Manages the creation and configuration of a virtual machine.
    *   **`virtual_network/`:** Manages the creation and configuration of a virtual network.
*   **`group_vars/all.yml`:** This file contains variables that are used by all roles.

## Conversion from Terraform to Ansible

This Ansible project was created by converting an existing Terraform project that deployed the same Azure infrastructure. The conversion process involved several key steps:

1.  **Modular Mapping:** Each Terraform module was mapped to an equivalent Ansible role. This ensured that the modular structure of the Terraform project was preserved in Ansible.
2.  **Resource Mapping:** Each Terraform resource was mapped to an equivalent Ansible module. For example:
    *   `azurerm_virtual_network` became `azure_rm_virtualnetwork`.
    *   `azurerm_subnet` became `azure_rm_subnet`.
    *   `azurerm_network_security_group` became `azure_rm_securitygroup`.
    *   `azurerm_public_ip` became `azure_rm_publicipaddress`.
    *   `azurerm_network_interface` became `azure_rm_networkinterface`.
    *   `azurerm_linux_virtual_machine` became `azure_rm_virtualmachine`.
    * `azurerm_network_interface_security_group_association` became a property of `azure_rm_networkinterface`.
    * `azurerm_resource_group` became `azure_rm_resourcegroup`
    * `azurerm_virtual_network_info` became `azure_rm_virtualnetwork_info`
    * `azurerm_subnet_info` became `azure_rm_subnet_info`
    * `azurerm_securitygroup_info` became `azure_rm_securitygroup_info`
    * `azurerm_networkinterface_info` became `azure_rm_networkinterface_info`
3.  **Variable Conversion:** Terraform variables were converted into Ansible variables and placed in the `group_vars/all.yml` file. This centralizes the configuration and makes it easy to modify.
4.  **Idempotency:** The Terraform pattern of using data sources to check for existing resources was translated into Ansible's approach of using `*_info` modules and the `when` conditional. This ensures that the Ansible code is idempotent.
5.  **Procedural Logic:** The declarative nature of Terraform was translated into the procedural logic of Ansible tasks. This involved defining the order of operations explicitly in the `playbooks/main.yml` file.
6. **Output Handling:** The Terraform outputs were translated into `debug` tasks in the `virtual_machine` role.

## Design Choices

The following design choices were made during the conversion process:

1.  **Roles for Modules:** Ansible roles were chosen to mirror the Terraform modules. This provides a clear separation of concerns and promotes reusability.
2.  **`group_vars/all.yml` for Variables:** All variables were placed in a single file (`group_vars/all.yml`). This makes it easy to manage and modify the configuration.
3.  **`*_info` Modules for Idempotency:** The `azure_rm_*_info` modules were used to check for existing resources. This, combined with the `when` conditional, ensures that the code is idempotent.
4.  **Procedural Logic in Playbook:** The `playbooks/main.yml` file explicitly defines the order of operations. This is necessary because Ansible is procedural, unlike Terraform, which is declarative.
5. **Local Connection:** The `localhost` connection was used to run the playbook locally.
6. **No Facts:** Facts were disabled to speed up execution.
7. **Debug for Outputs:** The `debug` module was used to output the public IP address, VM ID, and private IP address.

## Getting Started

1.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Install Ansible:**
    ```bash
    # Install Ansible
    ```
3.  **Install Azure Modules:**
    ```bash
    pip install 'ansible[azure]'
    ```
4.  **Azure Credentials:** Configure your Azure credentials for Ansible. The easiest way is to use the Azure CLI to log in:
    ```bash
    az login
    ```
5.  **Run the Playbook:**
    ```bash
    ansible-playbook playbooks/main.yml
    ```

## Contributing

Contributions to this project are welcome! Please feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License

[Insert License Information Here]
