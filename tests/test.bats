setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/envsa-ddev-config
  mkdir -p $TESTDIR
  export PROJNAME=envsa-ddev-config
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

health_checks() {
  # Do something useful here that verifies the add-on
  # Check that port 3000 is exposed for vite [✅]
  ddev describe -j | jq '.raw.services.web.exposed_ports' | grep 3000
  # Check that there is an environmnet variable set for VITE_PORT [✅]
  ddev exec env | grep "DDEV_VITE_PORT"
  # Check that image magick has the correct resource allocation [✅]
  ddev exec cat /etc/ImageMagick-6/policy.xml | grep "<policy domain=\"resource\" name=\"disk\" value=\"8GiB\"/>"
  # Check that playwright's dependencies have been installed [✅]
  ddev exec npx playwright install --with-deps chromium | grep "0 upgraded, 0 newly installed, 0 to remove"
  # check that apache has include module enabled [✅]
  ddev exec apachectl -M | grep "include_module"
  # test all image optimize commands [✅]
  ddev exec /usr/bin/jpegoptim --version
  ddev exec /usr/bin/optipng --version
  ddev exec /usr/bin/svgo --version
  ddev exec /usr/bin/gifsicle --version
  ddev exec /usr/bin/cwebp
  # Check that each custom command is functional [✅]
  ddev pnpm --version
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  health_checks
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get envsa/ddev-config with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get envsa/ddev-config
  ddev restart >/dev/null
  health_checks
}
