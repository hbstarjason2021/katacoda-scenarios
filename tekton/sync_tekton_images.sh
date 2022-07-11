#!/bin/bash

wget https://github.com/sigstore/rekor/releases/download/v0.9.1/rekor-cli-linux-amd64 && \
chmod +x rekor-cli-linux-amd64 && \
cp rekor-cli-linux-amd64 /usr/local/bin/rekor-cli && \
rekor-cli version

### https://github.com/tektoncd/pipeline/releases

RELEASE_FILE=https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.37.2/release.yaml
REKOR_UUID=362f8ecba72f43269cf1514976bb3f5f404667c6c02359a4a04e762b2c318b8f5195cec448cd6b26

### rekor-cli get --uuid $REKOR_UUID --format json | jq -r .Attestation | jq .

# Obtains the list of images with sha from the attestation
REKOR_ATTESTATION_IMAGES=$(rekor-cli get --uuid "$REKOR_UUID" --format json | jq -r .Attestation | jq -r '.subject[]|.name + ":v0.37.2@sha256:" + .digest.sha256')

# Download the release file
curl "$RELEASE_FILE" > release.yaml

# For each image in the attestation, match it to the release file
for image in $REKOR_ATTESTATION_IMAGES; do
  printf $image; grep -q $image release.yaml && echo " ";
done

