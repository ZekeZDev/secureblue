# See the License for the specific language governing permissions and limitations under the License.
LATEST_URL="$(curl -Ls -o /dev/null -w '%{url_effective}' https://github.com/casey/just/releases/latest)"
VER="$(basename "$LATEST_URL")"
ARCH="$(arch)"
curl -fLs --create-dirs "https://github.com/casey/just/releases/download/${VER}/just-${VER}-${ARCH}-unknown-linux-musl.tar.gz" -o "/tmp/just-${VER}-${ARCH}-unknown-linux-musl.tar.gz"
curl -fLs --create-dirs "https://github.com/casey/just/releases/download/${VER}/SHA256SUMS" -o /tmp/SHA256SUMS
cd /tmp
if ! sha256sum -c SHA256SUMS --ignore-missing
then
    echo "Just tarball verification FAILED! Exiting..."
    exit 1
fi
cd -
mkdir -p /tmp/just && tar -xzf "/tmp/just-${VER}-${ARCH}-unknown-linux-musl.tar.gz" -C /tmp/just/
cp /tmp/just/just /usr/bin/just && chmod 0755 /usr/bin/just
cp /tmp/just/completions/just.bash /usr/share/bash-completion/completions/just
cp /tmp/just/just.1 /usr/share/man/man1/just.1
rm "/tmp/just-${VER}-${ARCH}-unknown-linux-musl.tar.gz"
rm -r /tmp/just/
