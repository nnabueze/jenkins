# Extend Jenkins 2.249.2 on Debian 9 (stretch)
FROM jenkins/jenkins:2.249.2-lts

# Switch to root user to install .NET SDK
USER root

# Print kernel and distro info
RUN echo "Distro info:" && uname -a && cat /etc/*release

# Install needed tools and upgrade installed packages
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
curl apt-transport-https software-properties-common \
&& apt-get upgrade -y

# Add Microsoft repository for .NET SDK
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-add-repository https://packages.microsoft.com/debian/9/prod/

# Install .NET SDK
RUN apt-get update \
&& apt-get install -y dotnet-sdk-3.1 

# Switch back to jenkins user
USER jenkins