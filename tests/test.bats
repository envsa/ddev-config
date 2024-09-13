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
  # Check that image magick has the correct resource allocation [❌]
  # Check that playwright's dependencies have been installed [❌]
  # Check that each command provides it's default output [❌]
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

