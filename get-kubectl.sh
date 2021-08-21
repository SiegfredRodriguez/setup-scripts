#######################
#
#   Author: J-dar Siegfred Rodriguez
#   Created: Aug. 21, 2021
#   
#   Used to download and verify kubectl
#   Usage: get-kubectl.sh <KUBECTL-VERSION> <OUTPUT-DIRECTORY>
#
####################

#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]
    then
      echo "Usage: get-kubectl.sh <KUBECTL-VERSION> <OUTPUT-DIRECTORY>"
      exit 1
fi

temp_dir=$(mktemp -d)

download_kubectl() {
    local version=$1

    echo "Downloading kubectl $version"
    wget https://dl.k8s.io/release/v$version/bin/linux/amd64/kubectl -q --show-progress -P $temp_dir
}

validate_kubectl() {
    local version=$1

    echo "Verifying sha256sum..."
    local sum=$(curl -sL https://dl.k8s.io/v$version/bin/linux/amd64/kubectl.sha256)

    if ! $(echo "$sum $temp_dir/kubectl" | sha256sum --check --status)
      then
        echo "Sha256sum failed, file invalid or corrupt."
        exit 1
    fi
}

download_kubectl $1
validate_kubectl $1

tmp_file="${temp_dir}/kubectl"
target_dir="$2/$1"

mkdir "${target_dir}"
mv "${tmp_file}" "${target_dir}/"
rm -R ${temp_dir}

echo "Executing chmod +x on kubectl"
sudo chmod +x "${target_dir}/kubectl"
echo "Finished"
exit 0
