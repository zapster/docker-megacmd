FROM ubuntu:22.04

MAINTAINER Josef Eisl <zapster@zapster.cc>

RUN apt-get update \

    # Upgrade
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \

    # Install dependencies
    && apt-get install wget -y \

    # Download & Install MegaCMD
    && wget https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megacmd-xUbuntu_22.04_amd64.deb \
    && (dpkg -i megacmd-xUbuntu_22.04_amd64.deb || true) \
    && apt-get install -f -y \

    # Cleanup
    && rm *.deb \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y \


    && mkdir /root/MEGA

RUN useradd -ms /bin/bash mega
USER mega
WORKDIR /home/mega
RUN mkdir /home/mega/MEGA && mkdir /home/mega/.megaCmd

ENTRYPOINT ["mega-cmd-server"]
