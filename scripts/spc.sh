#!/bin/sh
VERSION=$1

# check presence of version
if [ -z $VERSION ]; then
	echo "Missing argument with version" >&2
	exit 1
fi

echo "Preparing release $VERSION"

# check presence of tooling
SHASUM=`which shasum`
CURL=`which curl`
[ -n ${SHASUM} ] && [ -n ${CURL} ] || exit 2

# Check if macOS release exists, if it does then it is likely that the Linux one does too
MAC_TAR_URL_X64="https://github.com/dvdmuckle/spc/releases/download/${VERSION}/spc-${VERSION}-darwin-amd64.tar.gz"
LINUX_TAR_URL_X64="https://github.com/dvdmuckle/spc/releases/download/${VERSION}/spc-${VERSION}-linux-amd64.tar.gz"
MAC_TAR_URL_ARM="https://github.com/dvdmuckle/spc/releases/download/${VERSION}/spc-${VERSION}-darwin-arm64.tar.gz"
LINUX_TAR_URL_ARM="https://github.com/dvdmuckle/spc/releases/download/${VERSION}/spc-${VERSION}-linux-arm64.tar.gz"


CHECKVER_CODE=`curl -X HEAD -m 3 -sfw "%{response_code}" ${MAC_TAR_URL_X64}`
if [ $CHECKVER_CODE -ne 302 ]; then
	echo "Version ${VERSION} does not exist" >&2
	exit 3
fi

echo "Fetching Linux X64 sha256"
#LINUX_SHA=$(curl -sLS "${LINUX_SHA_URL}" | cut -f1 -d\ "")
LINUX_SHA_X64=$(curl -sLS "${LINUX_TAR_URL_X64}" | shasum -a 256 | cut -f1 -d\ "")
echo "Fetching macOS X64 sha256"
#MAC_SHA=$(curl -sLS "${MAC_SHA_URL}" | cut -f1 -d\ "")
MAC_SHA_X64=$(curl -sLS "${MAC_TAR_URL_X64}" | shasum -a 256 | cut -f1 -d\ "")
echo "Fetching Linux ARM sha256"
#LINUX_SHA=$(curl -sLS "${LINUX_SHA_URL}" | cut -f1 -d\ "")
LINUX_SHA_ARM=$(curl -sLS "${LINUX_TAR_URL_ARM}" | shasum -a 256 | cut -f1 -d\ "")
echo "Fetching macOS ARM sha256"
#MAC_SHA=$(curl -sLS "${MAC_SHA_URL}" | cut -f1 -d\ "")
MAC_SHA_ARM=$(curl -sLS "${MAC_TAR_URL_ARM}" | shasum -a 256 | cut -f1 -d\ "")

cat > Formula/spc.rb <<FORMULA
class Spc < Formula
  version "${VERSION}"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  if Hardware::CPU.intel?
    if OS.mac?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-darwin-amd64.tar.gz"
      sha256 "${MAC_SHA_X64}"
    elsif OS.linux?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-linux-amd64.tar.gz"
      sha256 "${LINUX_SHA_X64}"
    end
  end
  if Hardware::CPU.arm?
    if OS.mac?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-darwin-arm64.tar.gz"
      sha256 "${MAC_SHA_ARM}"
    elsif OS.linux?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-linux-arm64.tar.gz"
      sha256 "${LINUX_SHA_ARM}"
    end
  end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
end

end
FORMULA

echo "Successfully updated! Check the code before pushing."
