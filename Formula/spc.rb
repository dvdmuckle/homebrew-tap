class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.0.tar.gz"
  sha256 "1695c8668de159df99615a20e4bd9dde36e06085ce81dab59259946508c446e0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4adcd3ba8b7f22c27cec59eb79f05f110a59cb4bcd62cbfa45a3c3f4bee620db"
    sha256 cellar: :any_skip_relocation, ventura:      "ee347e4ef3d657814b02bae93875a705fb729166cae0b8609333b4db5d505c80"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2962923ce0cceef34991960477394bbc9d65e2d6e662928460ad9afe54bd4fe3"
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
