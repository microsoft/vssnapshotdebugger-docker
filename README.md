# Visual Studio Snapshot Debugger Docker Images

This repository contains Dockerfiles that demonstrate how to set up the Visual Studio Snapshot Debugger on Docker images.

## Latest Release

### Version: 1.2.1
File Name | Description
:---------|:-----------
[vssnapshotdebugger-1.2.1-linux-x64.tar.gz](https://aka.ms/vssnapshotdebugger/release/1.2.1/vssnapshotdebugger-1.2.1-linux-x64.tar.gz) | For glibc based OS - most common
[vssnapshotdebugger-1.2.1-linux-musl-x64.tar.gz](https://aka.ms/vssnapshotdebugger/release/1.2.1/vssnapshotdebugger-1.2.1-linux-musl-x64.tar.gz) | For musl based OS, such as Alpine Linux

### Additional Information

- See [releases](https://github.com/microsoft/vssnapshotdebugger-docker/blob/master/RELEASES.md) for information about any current or previous release.
- See [checksums](https://github.com/microsoft/vssnapshotdebugger-docker/blob/master/CHECKSUMS) for checksum information for individual files in each release.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Developing

1. Clone this repository to your local machine.
2. Run init.cmd or init.ps1, found in the root of the repository.

This initialization script installs local Git hooks to automatically run update scripts when commits are made,
for example, the CHECKSUMS, README.md, and RELEASES.md files are updated automatically when a change is made to
the releases.json file.

## Issues

If you have any problems with or questions about this repository, please contact us through a
[GitHub issue](https://github.com/microsoft/vssnapshotdebugger-docker/issues).

## Licenses

- [Repository License](https://github.com/microsoft/vssnapshotdebugger-docker/blob/master/LICENSE)
