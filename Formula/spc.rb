class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.3.tar.gz"
  sha256 "fef3419842af48d4989ccddeafaca8a2178b55f142beb2bf07fb9e6f47c0418a"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8e95e3918fa8150ff3b35216e9e773c7c2739393728e5a7cada1754df529d04c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5d1e55e7fdd543de9fc6c03e486216fbf702776343bb5c293389f1749bbecfb6"
    sha256 cellar: :any_skip_relocation, ventura:       "321180f77712457c58b3c24a21d987cea3653ec7a752273c0f7610221f33eda3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8cdd7d5861b3ac2c2a51fbc1cf3274a66d373e69e2ec048f1857516ceca64191"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    generate_completions_from_executable(bin/"spc", "completion")

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
