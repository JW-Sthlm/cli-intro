# Enable Windows Sandbox (one-time host setup)

You only do this once on the host. After that, `launch.cmd` works.

> **Tip — running on a Dev Box?** The same enable command works inside a Dev Box and gives you the gold-standard validation setup (clean cloud host + disposable sandbox per walk). See [sandbox-in-devbox.md](sandbox-in-devbox.md) for the full flow.

## Requirements

- Windows 11 Pro, Enterprise, or Education (Home doesn't support Sandbox).
- Virtualization enabled in BIOS (almost always on for Microsoft-issued laptops).
- Admin rights on the laptop. Microsoft-issued machines: you usually have admin-on-request.

## Enable

Open PowerShell **as Administrator** and run:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All -NoRestart
```

Then reboot when convenient:

```powershell
Restart-Computer
```

After reboot, verify:

```powershell
Get-Command WindowsSandbox -ErrorAction SilentlyContinue
```

If it returns a path, you're done. Run [launch.cmd](launch.cmd).

## If the enable command fails

Possible causes:

| Error | Cause | Fix |
|-------|-------|-----|
| `requires elevation` | Not admin | Open PowerShell as Administrator (right-click → Run as administrator) |
| `feature not present` | Wrong Windows edition | Check `winver` — must be Pro/Enterprise/Education |
| `disabled by group policy` | Corporate policy blocks Sandbox | Use the [Codespaces fallback](fallback-codespace.md) |
| `virtualization not supported` | BIOS setting | Enter BIOS, enable Intel VT-x / AMD-V / virtualization |

If your laptop blocks the feature entirely, switch to the Codespaces fallback. Sandbox is preferred because it's true Windows, but a Codespace gets you 80% of the validation value for the auth/MCP flows.

## ARM64 note

Build 26100+ on Windows 11 supports Windows Sandbox on ARM64. If you're on an older ARM build, check `winver` and consider a feature update before relying on Sandbox.
