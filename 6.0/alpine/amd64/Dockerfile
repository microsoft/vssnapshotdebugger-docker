FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine-amd64

# Install Visual Studio Snapshot Debugger prerequisites
RUN apk update \
    && apk add libxml2 libuuid libunwind

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=2.0.31
ARG VSSNAPSHOTDEBUGGER_SHA512=943b08a83f2abe31c56a52c580a76f0b9fde13f5839d14c682b85cdcd9b8dd78426d4bc71e261c0ba3cbb1db1536906eccee6038d34d02878a81fa5d8ae13110
RUN wget -O vssnapshotdebugger.tar.gz "https://aka.ms/vssnapshotdebugger/release/${VSSNAPSHOTDEBUGGER_VERSION}/vssnapshotdebugger-${VSSNAPSHOTDEBUGGER_VERSION}-linux-musl-x64.tar.gz" \
    && echo "${VSSNAPSHOTDEBUGGER_SHA512}  vssnapshotdebugger.tar.gz" | sha512sum -c - \
    && mkdir -p /diag \
    && mkdir -p /tmp/diag \
    && tar -pzxf vssnapshotdebugger.tar.gz -C /diag \
    && rm vssnapshotdebugger.tar.gz

# Set environment variables to load Visual Studio Snapshot Debugger into .NET Core applications
ENV CORECLR_ENABLE_PROFILING=1
ENV CORECLR_PROFILER={324F817A-7420-4E6D-B3C1-143FBED6D855}
ENV CORECLR_PROFILER_PATH_64=/diag/Instrumentation64/libInstrumentationEngine.so
ENV MicrosoftInstrumentationEngine_ConfigPath64_SnapshotDebugger=/diag/Instrumentation64/ProductionBreakpoints_x64.config
ENV MicrosoftInstrumentationEngine_FileLog=Errors
ENV MicrosoftInstrumentationEngine_FileLogPath=/tmp/diag/log.txt
ENV MicrosoftProductionDiagnostics_RuntimeFolder=/diag/Runtime
ENV MicrosoftProductionDiagnostics_UtilsPath=/diag/Utils/ProductionBreakpointsUtils.dll

# Install Visual Studio Debugger
# Check the repo's README for vsdbg version compatibility with Visual Studio
RUN wget -O getvsdbg.sh "https://aka.ms/getvsdbgsh" \
    && sh ./getvsdbg.sh -v vs2019 -l /diag/vsdbg \
    && rm getvsdbg.sh
