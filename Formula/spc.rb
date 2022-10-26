class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.4.tar.gz"
  sha256 "07fe75be2953a5b143f82443ff29e16d1571b1a39411bc3e6cf1bdde8d573c66"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, big_sur:      "f154d405db6931971a3be424a6ce14b75a941f3b42674fa6dd2a61d6daa6de2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69c987b3b5983a9bdb558ea7d5b755438277c886f58209fa445a5200d2e0fce7"
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
