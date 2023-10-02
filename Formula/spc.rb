class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.6.tar.gz"
  sha256 "200580ddf20d44b8d0df264bf30403f7cfe9ef05ea1a1bb97093aef38485f0e1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, monterey:     "7d8c1bc0c541e172ece9fbc06fcc595f14557d2a2357d88c05b2a7d481d2770b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cf4094b089d4bfdc3383339e21f86753a8bcf067eb2f95bba16ac5d52dd5991f"
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
