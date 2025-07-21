---
name: Release PR
about: Create a pull request for a new release
title: 'Release v[VERSION]'
labels: 'release'
assignees: ''
---

## Release Checklist

### Pre-Release
- [ ] Updated `VERSION.md` with new version and changelog
- [ ] Updated `CHANGELOG.md` with new version entry
- [ ] Tested configuration with `./test_config.zsh`
- [ ] Validated installation with `./quick_test.zsh`
- [ ] Checked for security issues
- [ ] Updated documentation if needed

### Version Information
**Version**: v[X.Y.Z]
**Type**: [Major/Minor/Patch]

### Changes
<!-- Describe the main changes in this release -->

### Breaking Changes
<!-- List any breaking changes, or write "None" -->

### Migration Guide
<!-- If there are breaking changes, provide migration instructions -->

### Testing
- [ ] Tested on macOS [version]
- [ ] Validated ASDF integration
- [ ] Confirmed 1Password CLI integration
- [ ] Verified aliases and functions work
- [ ] Checked shell startup performance

### Post-Release Tasks
- [ ] Tag will be created automatically
- [ ] GitHub release will be generated
- [ ] Release notes will be published
- [ ] Announce release (if applicable)

## Additional Notes
<!-- Any additional information about this release -->