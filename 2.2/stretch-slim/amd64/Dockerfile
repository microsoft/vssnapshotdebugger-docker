FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim

# Install Visual Studio Snapshot Debugger prerequisites
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl libxml2 uuid libunwind8

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=2.0.21
ARG VSSNAPSHOTDEBUGGER_SHA512=bf362fda48ba361ae908f8561fb53c89b89b478c8aee113b1756e2d2f159c1a5e83eb4a076b54c6957039ad907a56fa37326f368e8fdabf6498defe954eb9bba
RUN curl -SL --output vssnapshotdebugger.tar.gz "https://aka.ms/vssnapshotdebugger/release/${VSSNAPSHOTDEBUGGER_VERSION}/vssnapshotdebugger-${VSSNAPSHOTDEBUGGER_VERSION}-linux-x64.tar.gz" \
    && echo "${VSSNAPSHOTDEBUGGER_SHA512}  vssnapshotdebugger.tar.gz" | sha512sum -c - \
    && mkdir -p /diag \
    && mkdir -p /tmp/diag \
    && tar -pzxf vssnapshotdebugger.tar.gz -C /diag \
    && rm vssnapshotdebugger.tar.gz

# Set environment variables to load Visual Studio Snapshot Debugger into .NET Core applications
ENV CORECLR_ENABLE_PROFILING=1
ENV CORECLR_PROFILER={324F817A-7420-4E6D-B3C1-143FBED6D855}
ENV CORECLR_PROFILER_PATH_64=/diag/Instrumentation64/libInstrumentationEngine.so
ENV MicrosoftInstrumentationEngine_FileLog=Errors
ENV MicrosoftInstrumentationEngine_FileLogPath=/tmp/diag/log.txt
ENV MicrosoftProductionDiagnostics_RuntimeFolder=/diag/Runtime
ENV MicrosoftProductionDiagnostics_UtilsPath=/diag/Utils/ProductionBreakpointsUtils.dll

# Install Visual Studio Debugger script prerequisites
RUN apt-get install -y --no-install-recommends \
    unzip

# Install Visual Studio Debugger
# Check the repo's README for version compatibility with Visual Studio
RUN curl -SL --output getvsdbg.sh "https://aka.ms/getvsdbgsh" \
    && sh ./getvsdbg.sh -v vs2019 -l /diag/vsdbg \
    && rm getvsdbg.sh

# Remove package lists to save space; can be restored with 'apt-get update'
RUN rm -rf /var/lib/apt/lists/*