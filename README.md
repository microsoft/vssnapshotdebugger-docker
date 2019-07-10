[//]: # (WARNING! This is a file that is automatically generated from the /templates/README.md.template file.)
[//]: # (DO NOT edit the README.md file directly, otherwise its contents will be automatically overwritten from the template.)
[//]: # (Any intended change to the README.md file must be made in the /templates/README.md.template file.)

# Visual Studio Snapshot Debugger Docker Images

This repository contains Dockerfiles that demonstrate how to set up the Visual Studio Snapshot Debugger on Docker images.

## What is the Visual Studio Snapshot Debugger?

The Visual Studio Snapshot Debugger is a feature of Visual Studio that allows you to take snapshots and to create log statements of in-production ASP.NET Azure
applications without interupting them. Please see https://aka.ms/snappoint for more infomration regarding the Visual Studio Snapshot Debugger.

## Dockerfiles

The Dockerfiles are organized according to the ASP.NET Core major and minor version, the OS platform, and the platform architecture.
For example, the ASP.NET Core 2.2 Alpine 3.8 x64 Dockerfile is located at /2.2/alpine/amd64/Dockerfile. When built, this Dockerfile produces
an image with Alpine 3.8 x64 as the base with ASP.NET Core 2.2 Runtime and the latest supported Snapshot Debugger backend package and vsdbg package.

The Dockerfiles do not take a dependency on the Docker build context, thus they can be built without specifying a build context when executing "docker build".

### VsDbg Version Compatibility Table

Pseudo-Version | Visual Studio Version
:--------------|:-----------
vs2017u5       | 2019

## Latest Release

### Version: 2.0.16
File Name | Description
:---------|:-----------
[vssnapshotdebugger-2.0.16-linux-x64.tar.gz](https://aka.ms/vssnapshotdebugger/release/2.0.16/vssnapshotdebugger-2.0.16-linux-x64.tar.gz) | For glibc based OS - most common
[vssnapshotdebugger-2.0.16-linux-musl-x64.tar.gz](https://aka.ms/vssnapshotdebugger/release/2.0.16/vssnapshotdebugger-2.0.16-linux-musl-x64.tar.gz) | For musl based OS, such as Alpine Linux

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

Usage of the Snapshot Debugger and Visual Studio Debugger distributable files and components are subject to the [licensing and terms defined by Visual Studio](https://visualstudio.microsoft.com/license-terms/mlt031719/).