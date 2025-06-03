# Zuzzurello Tickets Infrastructure

Questa repository contiene il codice di infrastruttura per l'applicazione Zuzzurello Tickets, utilizzando Terraform per fornire risorse in Azure.

## Directory Structure

```plaintext
.
├── .gitignore
├── main.tf
├── network.tf
└── readme.md
```

## Infrastructure Overview

📦 1. Resource Group

    Un resource group dedicato all’ambiente di test

🌐 2. Virtual Network (VNet)

    Una rete virtuale con un range IP privato (es: 10.0.0.0/16)

    All’interno della VNet, definizione di subnet distinte per separazione logica e NSG associabili:

    a. Subnet-fe: frontend (React o Nginx static)

    b. Subnet-be: backend (Python API)

    c. Subnet-db: database (es: PostgreSQL su VM o container)

    d. Subnet-jump: opzionale, per la jumpbox/VM SSH management

🔐 3. Network Security Groups (NSG)
    Associazione di NSG a ciascuna subnet per controllare il traffico in ingresso e in uscita
    con regole specifiche per ogni subnet:

| NSG         | Inbound consentito                             | Outbound consentito                         |
|-------------|-----------------------------------------------|---------------------------------------------|
| Frontend    | HTTP/HTTPS da Internet                        | Verso Backend                              |
| Backend     | Da Frontend su porte applicative              | Verso Database                             |
| Database    | Da Backend su porte DB                        | - (blocco totale o restrizione forte)      |
| Jumpbox     | SSH/RDP da IP admin                           | Verso tutte le subnet interne              |

🖥 4. Virtual Machines (SKU: Standard_B1ls)

    VM frontend (opzionale se usi hosting statico)

    VM backend (Python)

    VM database (PostgreSQL, o container Docker con volume persistente)

    Jumpbox (accesso SSH da IP pubblico con NSG restrittivo)

🪪 5. SSH Key

    Generazione chiave pubblica/privata locale

    Distribuzione della chiave pubblica alle VM

💽 6. Dischi e Storage

    Dischi OS per ciascuna VM

    Eventuali dischi dati per DB persistente (managed disk separato)

    Opzionale: storage account per logging o snapshot/test backup

📡 7. Public IP e Accesso

    Solo la jumpbox ha un IP pubblico

    Le altre VM sono in subnet private (accessibili via SSH tunnel o bastion/jumpbox)

📈 8. Output e provisioning di base

    Output degli IP e nomi host

    Output delle subnet per referenziare velocemente


📁 9. Struttura dei file Terraform consigliata:

    main.tf

    variables.tf

    outputs.tf

    network.tf (VNet, subnet, NSG)

    compute.tf (VMs, disks, IPs)

    security.tf (NSG rules)

    ssh.tf (chiavi e gestione accessi)

## Usage

1. Clona la repository:

   ```bash
   git clone <repository-url>
   cd zuzzurello-tickets
   ```

2. Inizializza Terraform:

   ```bash
   terraform init
   ```

3. Pianifica il deployment:

   ```bash
   terraform plan
   ```

4. Applica le modifiche:

   ```bash
   terraform apply
   ```

5. Distruggi l'infrastruttura:

   ```bash
   terraform destroy
   ```

## Requirements

- Terraform 1.0 or later
- Azure subscription

## Author

Emanuele Romano