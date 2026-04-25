# FitnessFormula Rails Site

FitnessFormula is a Rails 7.1 marketing site for Julie's Scotland-based fitness coaching business. The page presents personal training, group classes, nutrition coaching, training video previews, client results, and a booking call-to-action in one focused landing experience.

## Local development

Requirements:

- Ruby compatible with the version in `.ruby-version` or the app's Rails 7.1 bundle
- Bundler
- SQLite development headers if your local Ruby does not already provide SQLite support

Install and run the app:

```sh
bundle install
bin/rails server
```

Then open <http://localhost:3000>.

Useful local commands:

```sh
bin/rails routes
bin/rails console
```

## Tests and linting

Run the Rails test suite:

```sh
bin/rails test
```

Run RuboCop with the Rails rules included in the bundle:

```sh
bundle exec rubocop
```

Run both before handing off a change that touches Ruby, Rails views, styles, or documentation that references implementation details.

## Design direction and Architect rationale

The chosen direction is a warm, confident fitness-coaching landing page rather than a generic gym template. The page is structured as a guided sales story: a clear hero, service sections for personal training, group classes, and nutrition coaching, video previews, social proof, then a booking CTA.

Architect rationale:

- Lead with Julie's approachable personal coaching voice so the site feels local, supportive, and low-pressure.
- Keep the layout simple and fast: static Rails views, semantic sections, no client-side framework, and responsive CSS.
- Use strong visual contrast and rounded cards to make the page feel energetic without becoming intimidating.
- Reserve video slots for future production assets so the current placeholders do not shape the long-term content model.

Design options considered:

- **Corporate wellness:** polished but too impersonal for Julie's local coaching offer.
- **Hardcore gym:** high-energy but risks feeling exclusionary for beginners and busy families.
- **Supportive transformation:** selected because it balances motivation, trust, and accessibility across training, classes, and nutrition.

## Brand palette and visual direction

The brand colors are defined in `app/assets/stylesheets/application.css`:

- FitnessFormula green `#4CAF50` for primary actions, progress, and positive movement cues.
- Purple `#7B3F8C` for confidence, section contrast, and brand depth.
- Gold `#F5C518` for highlights, accents, and celebratory CTAs.
- Cream `#fffaf0`, white `#ffffff`, ink `#182018`, and muted green-gray `#536155` for readable content areas.

The intended visual direction is friendly, bright, and practical: large headlines, generous spacing, rounded cards, supportive copy, and clear calls to action that work on mobile as well as desktop.

## Training videos and production media

`app/views/pages/_training_videos.html.erb` currently uses Pexels video URLs as placeholders and includes `data-future-src` values that show the intended DigitalOcean Spaces production URLs.

**Pexels hotlink warning:** do not hotlink Pexels placeholder videos in production. Before launch, confirm licensing, download approved source files if appropriate, upload final edited videos to your own DigitalOcean Space/CDN, and replace the placeholder `poster` and `<source src="...">` URLs.

To swap in production videos hosted on DigitalOcean Spaces:

1. Create or choose a Space, for example `fitnessformula-assets`, in the region you plan to use, for example `ams3`.
2. Upload optimized `.mp4` files under a stable prefix such as `videos/`.
3. Upload poster images under a stable prefix such as `posters/`.
4. Make the objects public or serve them through the Spaces CDN.
5. In `app/views/pages/_training_videos.html.erb`, replace each Pexels `poster` URL with the Spaces poster URL.
6. Replace each `<source src="...">` URL with the matching Spaces video URL.
7. Keep `type="video/mp4"` unless the production asset format changes.
8. Confirm the deployed page can load, seek, and play the video from the production domain.

Example production URL pattern:

```text
https://fitnessformula-assets.ams3.digitaloceanspaces.com/videos/personal-training-intro.mp4
https://fitnessformula-assets.ams3.cdn.digitaloceanspaces.com/videos/personal-training-intro.mp4
```

## DigitalOcean Spaces CORS

Configure CORS on the Space that serves videos and posters so the Rails site can load media from the browser. Replace the origin values with the real production and local development origins before applying.

Exact CORS JSON for S3-compatible tooling:

```json
{
  "CORSRules": [
    {
      "AllowedOrigins": [
        "https://www.fitnessformula.example",
        "https://fitnessformula.example",
        "http://localhost:3000"
      ],
      "AllowedMethods": ["GET", "HEAD"],
      "AllowedHeaders": ["*"],
      "ExposeHeaders": ["Accept-Ranges", "Content-Length", "Content-Range", "ETag"],
      "MaxAgeSeconds": 3600
    }
  ]
}
```

DigitalOcean control-panel steps:

1. Open DigitalOcean → Spaces Object Storage → select the production Space.
2. Open **Settings** → **CORS Configurations**.
3. Add a rule with origins `https://www.fitnessformula.example`, `https://fitnessformula.example`, and `http://localhost:3000`.
4. Set allowed methods to `GET` and `HEAD`.
5. Set allowed headers to `*`.
6. Set exposed headers to `Accept-Ranges`, `Content-Length`, `Content-Range`, and `ETag`.
7. Set max age to `3600` seconds and save.
8. Re-test video playback from both local development and the deployed production domain.

Avoid `*` for `AllowedOrigins` on the production Space unless the media is intentionally reusable by any website.

## Kamal deployment to DigitalOcean

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
