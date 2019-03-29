FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine3.8

# Install Visual Studio Snapshot Debugger prerequisites
RUN apk update \
    && apk add libxml2 libuuid libunwind

# Install Visual Studio Snapshot Debugger
ARG VSSNAPSHOTDEBUGGER_VERSION=2.0.8
ARG VSSNAPSHOTDEBUGGER_SHA512=1fecc5e198fcfd35a743f1245db0bdede68f3b2e65db1b808e7091151d46d8db106324a1fac4bcdaa3b5e38ac4e50cbcd8c1a488bbd2764ead8af24787f5b3dd
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
ENV MicrosoftInstrumentationEngine_Host={CA487940-57D2-10BF-11B2-A3AD5A13CBC0}
ENV MicrosoftInstrumentationEngine_HostPath_64=/diag/Instrumentation64/libMicrosoftExtensionsHost.so
ENV MicrosoftInstrumentationEngine_FileLog=Errors
ENV MicrosoftInstrumentationEngine_FileLogPath=/tmp/diag/log.txt

# Install Visual Studio Debugger script prerequisites
RUN apk add bash unzip

# Install Visual Studio Debugger
# Check the repo's README for vsdbg version compatibility with Visual Studio
RUN wget -O getvsdbg.sh "https://aka.ms/getvsdbgsh" \
    && bash ./getvsdbg.sh -v vs2017u5 -l /diag/vsdbg \
    && rm getvsdbg.sh
