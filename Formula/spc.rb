class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.4.0.tar.gz"
  sha256 "83d1353b85218b65df6592c80ea08f9383ff85a8e67922806ecc8a9ae8d888eb"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4f7d2f6c45dfa065624e0c69d21a812937a282629b7bd02411a16b2d08bd8ce2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aab9da63a488a423eff9f6a349aebd44073cde13c3710c32d87d29635ba73aca"
    sha256 cellar: :any,                 x86_64_linux:  "7db6d3f66673f00968bca5dea9a535592ddc54c97dbc0d590872508d9b8ef3c9"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    generate_completions_from_executable(bin/"spc", "completion")

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/spc help")
  end
end
