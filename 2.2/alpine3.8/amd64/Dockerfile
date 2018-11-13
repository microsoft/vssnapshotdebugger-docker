FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine3.8

# Install Visual Studio Snapshot Debugger prerequisites
RUN apk update \
    && apk add libxml2 libuuid libunwind

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=1.2.2
ARG VSSNAPSHOTDEBUGGER_SHA512=2e74a03fb244fb2378f7841d4615f69976ee4af6d5943037d57dc0b3e643bccae6f14b1ac884862040ae70975387586d12861ff2b8520574f2568f12d82b1876
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
ARG GETVSDBG_SHA512=fe76c7671951d2c0ba254c76d3fd7dc9f90cd329457e89bd277f099904b416578a6346d2b8e5d686f7e7f66463e8830e886cf869ef2d95b5a229324c6e15a649
RUN wget -O getvsdbg.sh "https://aka.ms/vssnapshotdebugger/preview/getvsdbgsh" \
    && echo "${GETVSDBG_SHA512}  getvsdbg.sh" | sha512sum -c - \
    && bash ./getvsdbg.sh -v latest -l /diag/vsdbg \
    && rm getvsdbg.sh
