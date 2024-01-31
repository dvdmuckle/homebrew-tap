class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.2.0.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    rebuild 2
    sha256 cellar: :any_skip_relocation, ventura:      "3e46582499cb523969e8715d02dd1be4bb9ec7acaceea5e7ce534bee60e099d3"
    sha256 cellar: :any_skip_relocation, monterey:     "16f478d5de174fcfae7afb58e55b7f60864e0feb3327f6d13ba2cd4c4d916465"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "faaa892366ab69dd4e8b7ea28bd8d2c8b145a79b0df57461514908aa05384402"
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
