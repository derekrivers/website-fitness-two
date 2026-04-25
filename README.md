# website-fitness-two

Chat GPT 5.5 Mode

## Kamal Deployment to DigitalOcean

This repository includes `config/deploy.yml` as a safe Kamal template for deploying to a DigitalOcean droplet. The file intentionally uses placeholders for every environment-specific or sensitive value; replace them locally before deploying and do not commit real credentials.

Required placeholders to update:

- `<APP_NAME>`: the Kamal service name for this Rails app.
- `<DO_REGISTRY_IMAGE_NAME>`: the DigitalOcean Container Registry image name, such as `registry.digitalocean.com/<REGISTRY>/<IMAGE>`.
- `<DROPLET_IP>`: the target DigitalOcean droplet IP address or hostname.
- `<APP_HOSTNAME>`: the public hostname for the app.
- `<DO_REGISTRY_USERNAME>` and `<DO_REGISTRY_PASSWORD>`: registry credentials for pushing/pulling the deployment image.
- `<RAILS_MASTER_KEY>`: the Rails production master key or another secret-management placeholder used for `RAILS_MASTER_KEY`.
- `<SSH_USER>`: the SSH user Kamal should use to connect to the droplet.

Basic deployment flow:

1. Install and configure Kamal on your workstation.
2. Copy `config/deploy.yml` or edit it locally, replacing every `<PLACEHOLDER>` with deployment-specific values.
3. Authenticate with DigitalOcean Container Registry using credentials that are not committed to the repository.
4. Ensure the droplet allows SSH for `<SSH_USER>` and web traffic for `<APP_HOSTNAME>`.
5. Run Kamal setup/deploy commands from your configured local environment.

Never commit real registry passwords, droplet IPs, Rails master keys, SSH usernames, or production hostnames to this repository.
