[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![last commit](https://img.shields.io/github/last-commit/envsa/ddev-config)](https://github.com/envsa/ddev-config/commits)
[![tests](https://github.com/envsa/ddev-config/actions/workflows/tests.yml/badge.svg)](https://github.com/envsa/ddev-config/actions/workflows/tests.yml)
[![release](https://img.shields.io/github/v/release/envsa/ddev-config)](https://github.com/envsa/ddev-config/releases/latest)

# envsa DDEV Config

## Overview

This is a repository to quickstart out envsa DDEV projects with some custom settings.

## Installation

```sh
ddev add-on get envsa/ddev-config
ddev restart
```

After installation, make sure to commit the .ddev directory to version control.

## What is included

- Install pnpm as package manager
- Install playwright dependencies in the web container
- Expose a port for Vite's dev server
  - Make this settable via an environment variable
  - Default back to port 3000

## Usage

| Command         | Description                                       |
| --------------- | ------------------------------------------------- |
| `ddev describe` | View service status and used ports for this addon |

## How to debug in GitHub Actions

See [full instructions](./README_DEBUG.md).

## Resources

- [DDEV Add-ons: Creating, maintaining, testing](https://www.youtube.com/watch?v=TmXqQe48iqE) (part of the [DDEV Contributor Live Training](https://ddev.com/blog/contributor-training))
- [Advanced Add-On Techniques](https://ddev.com/blog/advanced-add-on-contributor-training/)
- [DDEV Add-on Maintenance Guide](https://ddev.com/blog/ddev-add-on-maintenance-guide/)
- [DDEV Documentation for Add-ons](https://ddev.readthedocs.io/en/stable/users/extend/additional-services/)
- [DDEV Add-on Registry](https://addons.ddev.com/)

**Contributed and maintained by [@rellafella](https://github.com/rellafella)**
