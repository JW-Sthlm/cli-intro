# Fallback: GitHub Codespace clean-test

Use this if Windows Sandbox is blocked by corporate policy or unavailable on the host. A Codespace gives you a clean Linux environment — close enough to test the auth flow and MCP setup, but not the Windows-specific install path.

## What this validates

| Coverage | Sandbox | Codespace |
|----------|---------|-----------|
| `winget install GitHub.Copilot` | yes | no (Linux) |
| PowerShell 7 install | yes | partial (Linux pwsh) |
| `verify.ps1` end-to-end | yes | no (Windows-specific) |
| `gh auth login` dual-account flow | yes | yes |
| `az login` with tenant | yes | yes |
| MCP install location prompt | yes | partial (different default config path) |
| `copilot-overview-plugin` install | yes | partial |

Use Codespace for **auth + MCP prompt validation**. It will not catch Windows-specific issues. After Codespace testing, find one colleague with a fresh Windows machine for a final pass.

## Steps

1. Go to `https://github.com/JW-Sthlm/cli-intro` (or your fork).
2. Click **Code → Codespaces → Create codespace on main**. Wait for it to spin up.
3. In the Codespace terminal, install Copilot CLI:
   ```bash
   curl -fsSL https://github.com/cli/cli/releases/latest/download/install.sh | sh
   # GitHub Copilot CLI for Linux:
   sudo apt-get update && sudo apt-get install -y gh
   gh extension install github/gh-copilot
   ```
   (Note: this is the `gh copilot` extension, not the standalone `copilot` binary. The CLI workshop uses the standalone binary, which is currently Windows/macOS only. The Codespace path validates the auth and MCP flows but not the exact CLI surface.)
4. Run through `setup-guide.md` adapting commands for bash where needed.
5. Document findings in [results-template.md](results-template.md).

## When to use which

| Situation | Use |
|-----------|-----|
| Validating the workshop on a fresh Windows | Sandbox |
| Validating MCP server prompt behavior | Sandbox preferred, Codespace OK |
| Validating EMU vs personal account dance | Either |
| Validating `verify.ps1` script | Sandbox only |
| Validating `copilot-overview-plugin` install on Windows | Sandbox only |
| You have 10 minutes and need a quick auth-flow check | Codespace |

If both are blocked, the last resort is to ask one colleague who hasn't done the workshop to follow the setup guide on their own laptop and report back.
