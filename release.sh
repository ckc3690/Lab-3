set -ex

# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=ckc3690
# image name
IMAGE=explorecali

# ensure we're up to date
git pull origin master

# bump version
docker run --rm -v "$PWD":/app ckc3690/bump patch
version=`cat VERSION`
echo "version: $version"

# run build
./build.sh

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push origin master
git push --tags

docker tag $ckc3690/$explorecali:latest $ckc3690/$explorecali:$version

# push it
docker push $ckc3690/$explorecali:latest
docker push $ckc3690/$explorecali:$version





