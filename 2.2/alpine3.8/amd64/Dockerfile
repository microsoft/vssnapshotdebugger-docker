FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-alpine3.8

# Install Visual Studio Snapshot Debugger prerequisites
RUN apk update \
    && apk add libxml2 libuuid libunwind

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=2.0.16
ARG VSSNAPSHOTDEBUGGER_SHA512=59f9406dbc397d6ca0dcb4f885c36f6c2d0ee28bee8386c11cf57dcae91fb4a04f625b72ce3949f5194dfad8c1b1e4c82edd09054a3f74304d4608476a3304d9
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
ENV MicrosoftInstrumentationEngine_FileLog=Errors
ENV MicrosoftInstrumentationEngine_FileLogPath=/tmp/diag/log.txt

# Install Visual Studio Debugger script prerequisites
RUN apk add unzip

# Install Visual Studio Debugger
# Check the repo's README for vsdbg version compatibility with Visual Studio
RUN wget -O getvsdbg.sh "https://aka.ms/getvsdbgsh" \
    && sh ./getvsdbg.sh -v vs2019 -l /diag/vsdbg \
    && rm getvsdbg.sh
