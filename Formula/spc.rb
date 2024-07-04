class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.2.1.tar.gz"
  sha256 "232c208d5e5662041ad6cb7ff72267b1f901fa835e4feb11c061e4950b6a2345"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "595bff6b6e7064df096e38fb0b1b21cabcb6a258085bea3c4421737055ac403a"
    sha256 cellar: :any_skip_relocation, ventura:      "da28c0b09c8fd41907815418963ad766da4d47200d45e434648ed027d6a95b9e"
    sha256 cellar: :any_skip_relocation, monterey:     "0025fb19a2e1eacb4f4f661fe0bc2b3a1ed770f478ad65d7862240d6f6e2038f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "989ac51d7ac9ab59d5f73371a7be7040fb982c9a6c4f63ba7c7ee6d5c16339ca"
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
