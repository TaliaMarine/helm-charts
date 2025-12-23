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

1. Bump the chart version in `charts/<chart>/Chart.yaml` (`version:` field).
2. Merge to `main`.
3. The workflow will:
   - package the chart (`.tgz`)
   - create or update a GitHub Release
   - publish/update `index.yaml` on the `gh-pages` branch

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

## Charts

- `note-discovery`
