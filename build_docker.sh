# Build container
export SPTUSER=sptworker
export UID_NUMBER=1006
export MINICONDA_PATH=/opt/miniconda3
export SPT3G_CUTTER_VERSION=0.2.1
export TAG=dev
export IMAGE=spt3g_cutter
docker build -f docker/Dockerfile -t menanteau/$IMAGE:$TAG \
       --build-arg SPTUSER \
       --build-arg UID_NUMBER \
       --build-arg MINICONDA_PATH \
       --build-arg SPT3G_CUTTER_VERSION \
       --rm=true .

docker tag menanteau/$IMAGE:$TAG registry.gitlab.com/spt3g/kubernetes/$IMAGE:$TAG
echo "Push commands:"
echo "   docker push menanteau/$IMAGE:${TAG}"
echo "   docker push registry.gitlab.com/spt3g/kubernetes/$IMAGE:${TAG}"
# Push to gitlab
# docker login registry.gitlab.com
