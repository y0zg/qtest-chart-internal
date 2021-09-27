#!/bin/sh -ex


FOLDER="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"

HELM_LAUNCH_VERSION="$4"
LAUNCH_APP_VERSION="$5"

CLONE_DIR=output_clone
echo 'check current directory'
#make directory
mkdir /home/runner/work/$GITHUB_USERNAME

cd /home/runner/work/$GITHUB_USERNAME
pwd
apt-get update && apt-get install git
#apt-get add --no-cache git

git config --global user.email "mtricentis@g.com"
git config --global user.name "$GITHUB_USERNAME"
git clone "https://$API_TOKEN_GITHUB@github.com/$GITHUB_USERNAME/qtest_public.git" $CLONE_DIR

echo 'check current directory after Clone'
cd $CLONE_DIR
echo "After cd $CLONE_DIR"
git checkout -b $GITHUB_REPO
cp -r $FOLDER/Charts/qtest-launch/* Charts/qtest-launch
ls -ltr
#Update Launch Helm and app verison
sed -i 's/\(^version:.*\)/version: '"$HELM_LAUNCH_VERSION"'/g' Charts/qtest-launch/Chart.yaml
sed -i 's/\(.*appVersion:.*\)/appVersion: '"$LAUNCH_APP_VERSION"'/g' Charts/qtest-launch/Chart.yaml

git add --all
git commit --message "Update from $GITHUB_REPOSITORY"

git push origin $GITHUB_REPO --force

cd ..
echo "Done!"
