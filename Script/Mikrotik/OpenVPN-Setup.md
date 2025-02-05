# OpenVPN (OVPN) Server Setup on MikroTik RouterOS v7.17

This guide provides a step-by-step process for setting up an OpenVPN (OVPN) server on MikroTik RouterOS v7.17.

## **Table of Contents**
- [Certificate Management](#certificate-management)
- [Configure PPP Profile](#configure-ppp-profile)
- [Add OVPN User](#add-ovpn-user)
- [Configure OVPN Server](#configure-ovpn-server)
- [Firewall Configuration](#firewall-configuration)
- [Export Client Certificates](#export-client-certificates)
- [Client Configuration](#client-configuration)

---

## **1. Certificate Management**

Generate the necessary certificates directly on the MikroTik router.

- **Create a Certificate Authority (CA):**

  ```bash
  /certificate add name=ca-template common-name=MyCA key-usage=key-cert-sign,crl-sign
  /certificate sign ca-template name=ca-template
  ```

- **Generate Server Certificate:**

  ```bash
  /certificate add name=server-template common-name=server
  /certificate sign server-template name=server-template ca=ca-template
  ```

- **Generate Client Certificate:**

  ```bash
  /certificate add name=client-template common-name=client
  /certificate sign client-template name=client-template ca=ca-template
  ```

- **Set Certificates as Trusted:**

  ```bash
  /certificate set ca-template trusted=yes
  /certificate set server-template trusted=yes
  /certificate set client-template trusted=yes
  ```

---

## **2. Configure PPP Profile**

Define a PPP profile for OVPN clients:

```bash
/ppp profile add name=ovpn-profile local-address=192.168.88.1 dns-server=192.168.88.1 use-encryption=yes
```

- `local-address`: The router's LAN IP.
- `dns-server`: The DNS server address for OVPN clients.

---

## **3. Add OVPN User**

Create a user for OVPN access:

```bash
/ppp secret add name=ovpn-user password=yourpassword profile=ovpn-profile service=ovpn
```

---

## **4. Configure OVPN Server**

Set up the OVPN server interface:

```bash
/interface ovpn-server server add auth=sha1 certificate=server-template cipher=aes256-cbc default-profile=ovpn-profile disabled=no mac-address=FE:C8:E3:16:A4:88 name=ovpn-server1 require-client-certificate=yes
```

---

## **5. Firewall Configuration**

Allow OVPN traffic through the firewall:

```bash
/ip firewall filter add chain=input action=accept protocol=tcp dst-port=1194
```

---

## **6. Export Client Certificates**

Export the client certificate and key for client configuration:

```bash
/certificate export-certificate client-template export-passphrase=yourpassphrase
```

This will generate `.crt` and `.key` files in the router's file system.

---

## **7. Client Configuration**

On the client device, use the exported certificates to configure the OVPN client. Ensure the client settings match the server's configuration, including authentication methods and encryption ciphers.

For a visual guide, refer to this tutorial: [How to Configure OVPN Server & Client on MikroTik RouterOS v7](https://www.youtube.com/watch?v=oBOTd9OIWHU&utm_source=chatgpt.com).

---

## **Conclusion**
By following these steps, you can establish a secure OpenVPN (OVPN) server on your MikroTik router running RouterOS v7.17.

