### Fixes applied: Audit and dependency overrides

Summary:
- Created branch `fix/audit-updates` in `portfolio` and applied `overrides` to reduce vulnerabilities.
- Added CI audit step to fail on `moderate` vulnerabilities in `.github/workflows/ci.yml`.
- Verified `npm audit` shows 0 vulnerabilities after applying overrides.
- All tests pass and the production build succeeds.

Details:
- Affected files:
  - portfolio/package.json (added `overrides`)
  - portfolio/package-lock.json (updated)
  - .github/workflows/ci.yml (added `npm audit` step)

Test steps performed locally:
1. cd portfolio
2. npm ci
3. npm audit
4. npm test -- --watchAll=false --runInBand
5. npm run build

Notes/Risks:
- `overrides` forces nested dependencies to safer versions; please review the change and run CI.
- For longer-term fixes, consider updating `react-scripts` or migrating to Vite/Next.js.

Suggested push & PR steps (GitHub):
1. Push portfolio branch:
   - git push origin fix/audit-updates
2. Push root branch:
   - git push origin fix/audit-updates-root
3. Open PRs from those branches and link them.

If you'd like, I can prepare the PR content or open the PR if you provide the remote.
