#!/bin/bash
echo "Running $0"
echo

OS_RELEASE=$(grep "^NAME=" /etc/os-release)
OS_RELEASE=${OS_RELEASE#NAME=}
OS_RELEASE=${OS_RELEASE//\"}

if [ "$OS_RELEASE" == "Oracle Linux Server" ]; then
    OEL_REPO="/etc/yum.repos.d/public-yum-ol7.repo"
    EPEL_EXISTS=$(grep "ol7_developer" $OEL_REPO | wc -l)
    if [ "$EPEL_EXISTS" == "0" ]; then
        echo "$OS_RELEASE - Adding ol7_developer to $OEL_REPO"
        echo "[ol7_developer]"                                                         >> $OEL_REPO
        echo "name=Oracle Linux $releasever Development Packages ($basearch)"          >> $OEL_REPO
        echo "baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer/$basearch/" >> $OEL_REPO
        echo "gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle"                       >> $OEL_REPO
        echo "gpgcheck=1"                                                              >> $OEL_REPO
        echo "enabled=1"                                                               >> $OEL_REPO
    fi
    
elif [ "$OS_RELEASE" == "CentOS Linux" ]; then
    echo "$OS_RELEASE"

elif [ "$OS_RELEASE" == "Red Hat Enterprise Linux Server" ]; then
    echo "$OS_RELEASE"
    if [ -z "$RHSM_USERNAME" ]; then
        echo "RHSM_USERNAME - is empty"
        exit 1
    fi
    if [ -z "$RHSM_PASSWORD" ]; then
        echo "RHSM_PASSWORD - is empty"
        exit 1
    fi
    subscription-manager register --auto-attach --name=packer-rhel7-x86_64 --username="$RHSM_USERNAME" --password="$RHSM_PASSWORD"
    subscription-manager repos --enable rhel-7-server-extras-rpms --enable rhel-7-server-optional-rpms
else
    echo "$OS_RELEASE - Unknown OS"
    exit 1
fi

# Install Ansible.
yum -y install ansible
