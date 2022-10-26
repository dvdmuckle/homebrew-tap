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
    sha256 cellar: :any_skip_relocation, big_sur:      "142bc907f022e2231d6d8f89626d1a9d7d43b33a435ac85825fdf8404a27f229"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0770935f07ad67ae107bcb8f0a0ba505cdaa5deb09ee6e9ad5890db96e635779"
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
