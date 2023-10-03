class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.6.tar.gz"
  sha256 "bb2654de3a4e7c8420102384365512533264c6ff5716a17302831f8671220dc3"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c242288564b9600390ba8db201ca2d1d4aabcda1dc0f9b414a61ce7c7271c507"
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
