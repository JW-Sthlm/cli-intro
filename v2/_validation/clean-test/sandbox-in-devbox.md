# Sandbox in Dev Box: dead end (do not try again)

We considered running Windows Sandbox inside a Microsoft Dev Box to get instant per-walk reset (close the window, state is gone) without the 15-minute Dev Box redeploy.

It does not work in our tenant. This file documents what we tried and why it fails, so the next person doesn't re-discover it.

## What we wanted

The combo:
- Dev Box for the host. Cloud-managed, no local hypervisor issues.
- Windows Sandbox inside it for disposability per walk.

On paper this gives both: no laptop virtualization quirks, no slow redeploy.

## Why it fails

The `Containers-DisposableClientVM` Windows feature is not enabled on the Dev Box pool image, and tenant policy blocks enabling it. Running:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All -NoRestart
```

returns a policy denial. Even with admin elevation on the Dev Box itself, the underlying image does not ship the optional feature, and we cannot install it from inside the Dev Box.

This is not "configure your way out of it." The pool image and policy ownership sit with central IT, not with us.

## What we use instead

Plain Dev Box, reset between walks with [`reset-devbox.ps1`](reset-devbox.ps1). Soft mode wipes auth, config, and repos in about 30 seconds. Full redeploy (~15 min) when the host is too soiled for the soft reset.

See [README.md](README.md) for the current decision tree.

## When to revisit

Only if central IT publishes a new Dev Box pool image that ships `Containers-DisposableClientVM` enabled. There is no signal that this is on a roadmap, so do not assume it.
