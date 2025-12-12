Title: chore: audit & dependency security fixes for portfolio

Description:
This PR contains changes to mitigate nested dependency vulnerabilities found by `npm audit` in the `portfolio` project.

What changed:
- Added `overrides` in `portfolio/package.json` to bump nested dependencies (`nth-check`, `postcss`, `svgo`, `css-select`, `webpack-dev-server`) that triggered alerts.
- Updated `portfolio/package-lock.json` with enforced overrides.
- Added a CI step (`.github/workflows/ci.yml`) to run `npm audit --audit-level=moderate` and fail CI if vulnerabilities appear at moderate level or higher.
- Minor docs updates: `portfolio/README.md` security note and `PR_AUDIT_FIX.md` with test steps.

Why:
- `npm audit` found 9 vulnerabilities (6 high, 3 moderate) in nested dependencies like `svgo`, `postcss`, `nth-check` used transitively via `react-scripts` and others.
- These `overrides` allow us to mitigate immediate risks while we evaluate a longer-term fix (bumping `react-scripts` or migrating build stack).

Testing performed:
- `npm --prefix ./portfolio ci` and `npm --prefix ./portfolio audit` — after overrides, 0 vulnerabilities.
- `npm --prefix ./portfolio test -- --watchAll=false` — tests passed.
- `npm --prefix ./portfolio run build` — production build succeeded.

Potential follow-up actions:
- Consider updating `react-scripts` to a version that resolves these nested packages in a semver-safe manner.
- For long-term maintenance, plan a migration from `react-scripts` to Vite or Next.js.

How to push & open PR:
1. Create remotes (if not set):
   - git remote add origin git@github.com:<your-username>/<repo>.git
2. Push branches:
   - git push -u origin fix/audit-updates
   - git push -u origin fix/audit-updates-root
3. Open PRs in GitHub GUI linking both if needed.

If you want, I can try to push the branch to a remote if you provide remote access, or you can push and open the PR and I'll prepare suggested reviewers + CI labels.
