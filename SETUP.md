# Helm Charts

This repository hosts Helm charts for the TaliaMarine org.

## Helm repo over GitHub Pages

Once GitHub Pages is enabled (see setup below), you can install charts like this:

```bash
helm repo add talia-marine https://taliamarine.github.io/helm-charts
helm repo update
helm search repo talia-marine
helm install note-discovery talia-marine/note-discovery
```

## Publishing / releasing charts (GitHub Pages)

This repo uses **Release Please** (https://github.com/googleapis/release-please) to automatically manage chart versions.

### How it works

1. When you merge changes to `main`, Release Please opens/updates a **Release PR**.
2. When you merge the Release PR, Release Please creates a **GitHub Release** (tag).
3. The `release-charts.yaml` workflow runs on that release and publishes the Helm repo:
   - packages the chart(s)
   - updates `index.yaml` on the `gh-pages` branch

### Releasing a new chart version

1. Merge your normal PR(s) into `main`.
2. Review and merge the automatically created **Release PR**.

That’s it — you do **not** manually edit `Chart.yaml` versions.

## One-time GitHub configuration

### Enable GitHub Pages

1. Go to **Settings → Pages** in https://github.com/TaliaMarine/helm-charts
2. Set **Build and deployment** to **Deploy from a branch**
3. Select:
   - Branch: `gh-pages`
   - Folder: `/ (root)`

After the first release workflow run, GitHub Pages will serve:

- `https://taliamarine.github.io/helm-charts/index.yaml`

### Actions permissions

Ensure workflows can publish releases/branches:

- **Settings → Actions → General → Workflow permissions**
  - Select **Read and write permissions**

## Release Please authentication (GitHub App, no PAT)

Your organization currently blocks GitHub Actions from creating PRs with the default `GITHUB_TOKEN`.
To use Release Please without a PAT, use a **GitHub App**.

### Option: Install the Release Please GitHub App (recommended)

1. Install the GitHub App:
   - https://github.com/apps/release-please
2. During installation, grant it access to **TaliaMarine/helm-charts**.
3. In the App settings, generate a **private key**.
4. Add these repository secrets in **Settings → Secrets and variables → Actions**:

   - `RELEASE_PLEASE_APP_ID` (the App ID)
   - `RELEASE_PLEASE_PRIVATE_KEY` (paste the full PEM private key)

The workflow `.github/workflows/release-please.yaml` will generate an installation token at runtime and use it to open Release PRs and create GitHub Releases.

> If your org has additional restrictions, also ensure in **Settings → Actions → General → Workflow permissions** that workflows have **Read and write permissions**.

## Charts

- `note-discovery`
