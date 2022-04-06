## Vault with TFE Certificate Lifecycle Management

This repo contains some code examples which will help get you started managing SSL certificates through Vault with Terraform Enterprise.

The repository is broken out into sections;

- `01_vault_backend_config` - Setup the required roles and secret backend in Vault
- `04_cert_only` - Example code to create a certificate and private key 
- `05_generate_csr` - Example code to generate a CSR and private key in terraform, then submit to Vault for signing
- `06_submitted_csr` - Example code to sign a user provided CSR
- `Customer_Data` - Form data providing the information required
- `modules` - Modules which will create TFE Workspaces which contain the required variables and information to process certificates.

### How to Run. 
Configure Vault Secrets engine and Role (Optional)
This may not be required if you already have Vault configured. However if not, you can run Terraform from the `01_vault_backend_config` directory to configure a new secrets engine, root certificate authority, roles and CSR details. 

Create a Workspace (Workspace Controller) in TFE which will manage our "child workspaces". Each of these child workspaces will contain the information and variables needed to create a certificate in Vault. 
The Workspace Controller will be linked to the root of this repository. You will need to watch either the entire repo or the Customer_Data directory for automatic runs. 
Variables requried: 
- oauthid - VCS oauthid configured in TFE/TFC
- organisation - the TFE/TFC organisation
- token - TFE/TFC token to create workspaces
- VAULT_ADDR - Vault server address (TF Environment variable)
- VAULT_TOKEN - Vault access token (TF Environment variable)

The Workspace Controller is designed to watch the Customer_Data directory for new submissions. Each new submission will create a new TFE Workspace and issue a new Certificate. 

#### Child Workspaces:
Child workspaces will be created with the required VCS integration and variable information from the Customer_Data files. However each workspace will also need access to Vault, so the following variables are required. In my demonstation I use Variable Sets to attach this automatically without exposing sensitive data.
Variables requried: 
- VAULT_ADDR - Vault server address (TF Environment variable)
- VAULT_TOKEN - Vault access token (TF Environment variable)


#### Customer_Data
Three sub-directories based on different use-cases. 
Cert-only - User submits *just enough* information for Vault to create an SSL certificate and private key.
Generate-CSR - User submits their own CSR information so TFE can create a CSR and submit it to Vault for signing.
Submitted-CSR - User submits their own CSR for signing.

Three examnple files exist in the Customer_Data directory. Move them into the required subdirectory for testing. (Removing the last file prefix)
- **Note:** The submitted_csr file is Yaml formatted to allow multiline data.

