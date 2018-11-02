FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine3.8

# Install Visual Studio Snapshot Debugger prerequisites
RUN apk update
RUN apk add libxml2 libuuid libunwind

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=1.2.1
ARG VSSNAPSHOTDEBUGGER_SHA512=2fc3f1c3bacfc7185ad3d415c0145928fed8fb91480fdce2951dabe0e4a3e028a636715d1337f1dc58c23b5d9e83dc5bdc83cbe68e576b3105d5a22b52bdea9f
RUN wget -O vssnapshotdebugger.tar.gz "https://aka.ms/vssnapshotdebugger/release/${VSSNAPSHOTDEBUGGER_VERSION}/vssnapshotdebugger-${VSSNAPSHOTDEBUGGER_VERSION}-linux-musl-x64.tar.gz" \
    && echo "${VSSNAPSHOTDEBUGGER_SHA512}  vssnapshotdebugger.tar.gz" | sha512sum -c - \
    && mkdir -p /diag \
    && tar -pzxf vssnapshotdebugger.tar.gz -C /diag \
    && rm vssnapshotdebugger.tar.gz

# Set environment variables to load Visual Studio Snapshot Debugger into .NET Core applications
ENV CORECLR_ENABLE_PROFILING=1
ENV CORECLR_PROFILER={324F817A-7420-4E6D-B3C1-143FBED6D855}
ENV CORECLR_PROFILER_PATH_64=/diag/Instrumentation64/libInstrumentationEngine.so
ENV MicrosoftInstrumentationEngine_Host={CA487940-57D2-10BF-11B2-A3AD5A13CBC0}
ENV MicrosoftInstrumentationEngine_HostPath_64=/diag/Instrumentation64/libMicrosoftExtensionsHost.so
ENV MicrosoftInstrumentationEngine_FileLog=Errors
ENV MicrosoftInstrumentationEngine_FileLogPath=/tmp/diag/log.txt

# Install Visual Studio Debugger script prerequisites
RUN apk add bash unzip

# Install Visual Studio Debugger
ARG GETVSDBG_SHA512=e5da609ee0a9dcd2d7d33f58b3eb9fe3db8389e08522dd8b4c42a2dc930cd01d1e818476fb4e0d079015dbd07324c8aca36de3e78d361102d2b327a6699f4d65
RUN wget -O getvsdbg.sh "https://aka.ms/getvsdbgsh" \
    && echo "${GETVSDBG_SHA512}  getvsdbg.sh" | sha512sum -c - \
    && bash ./getvsdbg.sh -v latest -l /diag/vsdbg \
    && rm getvsdbg.sh
