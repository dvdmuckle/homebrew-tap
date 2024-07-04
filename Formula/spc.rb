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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8c5f47a457a24b0690fc86538644f89a634067fc180a776bf925ad2eafa8f799"
    sha256 cellar: :any_skip_relocation, ventura:      "e287c6ee8c97f1c4531d24e43de621c10b7d2a0dc8a2a3b7973e32548d3d0ada"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "006b52e1ed6081267e72c88d6499c9d36da5223df559abb440fcd2991cc85bb6"
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
