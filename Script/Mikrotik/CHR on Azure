# CHR on Azure

This repository provides a step-by-step guide to deploying MikroTik Cloud Hosted Router (CHR) on Microsoft Azure. Since an official CHR image is not yet available in the Azure Marketplace, this guide walks you through the manual setup process.

## **Table of Contents**
- [Prerequisites](#prerequisites)
- [Step 1: Download and Convert CHR VHD](#step-1-download-and-convert-chr-vhd)
- [Step 2: Upload CHR VHD to Azure Storage](#step-2-upload-chr-vhd-to-azure-storage)
- [Step 3: Create an Azure Image](#step-3-create-an-azure-image)
- [Step 4: Deploy CHR Virtual Machine](#step-4-deploy-chr-virtual-machine)
- [Step 5: (Optional) Site-to-Site VPN](#step-5-optional-site-to-site-vpn)

---

## **Prerequisites**
- An active Microsoft Azure subscription.
- Azure Storage Account and a Blob Container.
- MikroTik CHR `.vhdx` image (Download from [MikroTik](https://mikrotik.com/download)).
- PowerShell installed on your local machine.

---

## **Step 1: Download and Convert CHR VHD**

Download the CHR `.vhdx` image from MikroTik and convert it to a `.vhd` format using PowerShell:

```powershell
Convert-VHD -Path C:\chr-6.45.6.vhdx -DestinationPath C:\chr-6.45.6.vhd -VHDType Fixed
```

> **Note:** Azure only supports fixed-size VHD files.

---

## **Step 2: Upload CHR VHD to Azure Storage**

1. In the **Azure Portal**, navigate to **Storage Accounts**.
2. Select your target storage account.
3. Under **Blob Service**, go to **Containers**.
4. Select an existing container or **Add Container** to create a new one.
5. Click **Upload**, select the `.vhd` file, and ensure **Blob type** is set to **Page Blob**.

---

## **Step 3: Create an Azure Image**

1. In the **Azure Portal**, navigate to **Images** (not Virtual Machines).
2. Click **Add** to create a new image.
3. Provide an **Image Name** (e.g., `MikroTik-CHR`).
4. Ensure the **Location** matches your storage account's location.
5. In the **OS Disk** section:
   - **OS Type**: Linux  
   - **Storage Blob**: Browse and select the CHR `.vhd` uploaded in Step 2.
   - **VM Generation**: Generation 1.
6. Click **Create** and wait for the image creation process to complete.

---

## **Step 4: Deploy CHR Virtual Machine**

1. In the **Azure Portal**, navigate to **Virtual Machines**.
2. Click **Add** to create a new VM.
3. Under **Image**, select **Browse all public and private images**.
4. In **My Items**, select the CHR image created in Step 3.
5. Choose an appropriate **VM Size** (e.g., `B1ls` for the smallest instance).
6. Complete the remaining configuration and **Create** the VM.

> **Note:** You must enable **IP Forwarding** on the VM's network interface for proper packet forwarding.

---

## **Step 5: (Optional) Site-to-Site VPN**

To configure an S2S VPN between your Azure VNet and an on-premise router:
- Ensure **NAT Traversal** is enabled in MikroTik profiles.
- Configure a **Route Table** to direct traffic through the VPN tunnel.

---

## **Azure Serial Console Support**

Azure’s **Serial Console** works with MikroTik CHR, allowing direct console access for troubleshooting.

---

## **Contributing**
Feel free to submit **issues** and **pull requests** to improve this documentation!

## **License**
This project is licensed under the MIT License.

