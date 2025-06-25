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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b916918d81c01209bcb0864ba160a99ff6651efd50f2e7d44967ee1fce2e761"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3abacb4ece74235a323e241fb0c612ad133c546bbf969e280a0be09aecfb74c3"
    sha256 cellar: :any_skip_relocation, ventura:       "71c5315c53a131c93225d3b4afbd6ef3b71355663b2eb1953ad9f9e09c3704df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b953b504891110fb58587d1ed51d4a0555fda0b81c7a5544957ab314ddc9523"
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
