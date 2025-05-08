# Specify the version of spt3g_cutter to build
export SPT3G_CUTTER_VERSION=0.4.4
export IMAGE_REPO=registry.gitlab.com/spt3g/kubernetes/spt3g_cutter

# Build the Docker image
docker build -t ${IMAGE_REPO}:${SPT3G_CUTTER_VERSION} \
    --build-arg SPT3G_CUTTER_VERSION \
    -f docker/Dockerfile .

echo 'Push commands:'
echo "   docker push ${IMAGE_REPO}:${SPT3G_CUTTER_VERSION}"
