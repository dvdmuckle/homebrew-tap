class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.5.tar.gz"
  sha256 "a9ad19d538367ebfec3140a344dc83e05a50e0eb69ab40c6d9994cef606b803a"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f81f66039ec970841b94047427937a97a3b420367b1fd8226be77e06d4ce0a25"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6af6fc6f341b94987ef9e2e45acce2c7e6be3fbbe71a40d25a5c38be22012186"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a86b4227d3d963cfc99008607ad6723ae591f35188a78b554544f9c23269573"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ee6350877b90ddb6bdf4f8e8b96bcd4923f86861b5908965a1f794bf3a26f42"
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
